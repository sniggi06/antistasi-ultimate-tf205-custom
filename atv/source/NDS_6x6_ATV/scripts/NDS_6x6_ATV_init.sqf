NDS_fnc_6x6_setFuel = {
private ["_atv", "_op","_owner"];
_atv = _this select 0;
_owner = _this select 1;


if (local _atv) then 
	{

if ((_atv animationPhase "HideJerry2") == 0) then {


	if ((_atv animationPhase "HideJerry1") == 0) then {} 
		else{
			
			_atv animate ["HideJerry1", 0];
			
			"Refuelling..." remoteExec ["hint", _owner]; 
			sleep 5;
			_atv setFuel ( Fuel _atv +.5);
			"Added 2nd Fuel Container (20 Litres) " remoteExec ["hint", _owner]; 
			sleep 4;
			"" remoteExec ["hint", _owner]; 
			
			};

	


} 
	else{
		
		_atv animate ["HideJerry2", 0];
		
		"Refuelling...." remoteExec ["hint", _owner]; 
		
		sleep 5;
		_atv setFuel ( Fuel _atv +.5);
		"Added 1st Fuel Container (20 Litres) " remoteExec ["hint", _owner]; 
		sleep 4;
		"" remoteExec ["hint", _owner]; 
		
		};
		
	
	
}else {


[(_this select 0),player] remoteExec ["NDS_fnc_6x6_setFuel",_atv]; 


};	
};


NDS_fnc_6x6_Jerryfill = {
    private ["_atv","_supply","_supplycount","_gotfuel"];
	
    _atv = _this select 0;
	_owner = _this select 1;

if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {  

if (local _atv) then 
	{
	//THIS BIT FOR ACE
	_supply = position _atv nearObjects 8;  
_supplycount = count _supply; 
_gotfuel = [0]; 
_c = 0;   
 while {_c <= (_supplycount - 1)} do {_gotfuel pushback ( [(_supply select _c)] call ace_refuel_fnc_getFuel); _c = _c + 1} ;  
 _c = 0; 
  
_fuelavail = 0; 
_result = { 
    if(_x >=1) then {_fuelavail = 1;} 
} forEach _gotfuel; 
 
if (_fuelavail ==1) then {
	
	"Filling Containers..." remoteExec ["hint", _owner];
	sleep 6;
	_atv animate ["hidejerry1",1];
	_atv animate ["hidejerry2",1];
	"Containers Filled" remoteExec ["hint", _owner];
	sleep 3;
	"" remoteExec ["hint", _owner];
	
	
	
	} else {
	"No Fuel Supply to fill from!" remoteExec ["hint", _owner];
	sleep 4;
	"" remoteExec ["hint", _owner];
	}; 
	
	
	
	
    }else 	{
		[(_this select 0),player] remoteExec ["NDS_fnc_6x6_Jerryfill",_atv]; 
			};





 } 


else {  if (local _atv) then 
	{
	
	_supply = (_atv nearSupplies 8) select {getFuelCargo _x > 0};
	_supplycount = count _supply;
	if (_supplycount >=1) then {
	"Filling Containers..." remoteExec ["hint", _owner];
	sleep 6;
	_atv animate ["hidejerry1",1];
	_atv animate ["hidejerry2",1];
	"Containers Filled" remoteExec ["hint", _owner];
	sleep 3;
	"" remoteExec ["hint", _owner];
	
	
	
	} else {
	"No Fuel Supply to fill from!" remoteExec ["hint", _owner];
	sleep 4;
	"" remoteExec ["hint", _owner];
	}; 
	
	
	
	
    }else 	{
		[(_this select 0),player] remoteExec ["NDS_fnc_6x6_Jerryfill",_atv]; 
			};	  };


};

NDS_fnc_6x6_camnet = {
    private ["_atv","_deployed","_crew"];
	
    _atv = _this select 0;
	_owner = _this select 1;
	_deployed = (_atv animationPhase "camnetdeploy");
	_crew = nil;


if (local _atv) then 
	{
	
	if ( _deployed == 1) then 
	{	
		_atv animatesource ["camnetdeploy", 0];
		_atv setUnitTrait ["camouflageCoef",1];
		_atv lockDriver false;
		_atv lockCargo false;
		_atv enableVehicleCargo true;
		_atv enableRopeAttach true;
	} else
	{
		_atv animatesource ["camnetdeploy", 1];
		(driver _atv) action ["getout", _atv];
		_crew = (((fullCrew _atv) select 0)select 0);
		if (isNil "_crew") then {} else {_crew action ["getout", _atv];};
		_atv setUnitTrait ["camouflageCoef",0.005];
		_atv lockDriver true;
		_atv lockCargo true;
		_atv enableVehicleCargo false;
		_atv enableRopeAttach false;
	};
	
	

	}
	else 	{
		[(_this select 0),player] remoteExec ["NDS_fnc_6x6_camnet",_atv]; 
			};
};






// removed function body to disable respawning
NDS_fnc_6x6_respawn1 = {};


NDS_fnc_6x6_respawnbag = {
//params ["_atv", "_owner"];
private ["_atv", "_mode", "_dir", "_found", "_pos", "_sb","_sbdel","_owner","_op"];
	
_atv = _this select 0;
_op = _this select 1;
_mode = _this select 2;

if (local _atv) then {
//_owner = getPlayerUID _op;
//code
		if (_mode == 1) exitwith
		{
			_dir = (getdir _atv - 35);
			_pos = _atv getrelpos [1.4,210];
			_sb = "NDS_6x6_ATV_respawn_point"createvehicle _pos;
			_sb setdir _dir;
			_sb setpos _pos;
			_atv animatesource ["Respawn",1];
		};

		if (_mode == 0) exitwith
		{
			_found = _atv nearobjects ["NDS_6x6_ATV_respawn_point", 5];
			
				//if (isNull _found) exitwith {};
			_sbdel = (_found select 0);
			if (isNil "_sbdel") exitwith {_atv animatesource ["Respawn",0];};
			deletevehicle _sbdel;
			_atv animatesource ["Respawn",0];
		};
	} else {
	[(_this select 0),_op,_mode] remoteExec ["NDS_fnc_6x6_respawnbag",_atv]; 
	};	
	
};













NDS_fnc_6x6_pose = {
    private ["_veh","_driver","_pose","_posestate"];
	
   
	_veh = _this select 0;
    _driver = driver _veh;
	_pose = _this select 1;
	_posestate = _veh animationSourcePhase "pose";
		
    if (local _veh) then 
	{	
		if (_pose == 1) then 
							{[_driver, "NDS_ATV_p_driver_out"] remoteExec ["switchMove", 0];
							_veh animatesource ["Pose",1];
							} else 
							{[_driver, "NDS_ATV_p_driver_in"] remoteExec ["switchMove", 0];
							_veh animatesource ["Pose",0];
							
							}
        
    } else {
        PV6x6_pose = _this;
        if (isDedicated) then {
            (owner _veh) publicVariableClient "PV6x6_pose";
        } else {
            publicVariableServer "PV6x6_pose";
        };
    };
};
"PV6x6_pose" addPublicVariableEventHandler {
    (_this select 1) call NDS_fnc_6x6_pose;
};





NDS_fnc_6x6_loadmedikit = {
    private ["_atv","_hasmedikit"];
	_atv = _this select 0;
    _hasmedikit = _this select 1;
	if (local _atv) then {
        _atv animatesource ["medikit", _hasmedikit];}
		
     else {
       [(_this select 0),_hasmedikit] remoteExec ["NDS_fnc_6x6_loadmedikit",_atv];
    };
};


NDS_fnc_6x6_loadtoolkit = {
    private ["_atv","_hastoolkit"];
    _atv = _this select 0;
    _hastoolkit = _this select 1;
    if (local _atv) then {
        _atv animatesource ["toolkit", _hastoolkit];}
		
     else {
       [(_this select 0),_hastoolkit] remoteExec ["NDS_fnc_6x6_loadtoolkit",_atv];
    };
};


NDS_fnc_6x6_loadlaser = {
    private ["_atv","_haslaser"];
    _atv = _this select 0;
    _haslaser = _this select 1;
    if (local _atv) then {
        _atv animate ["laser", _haslaser];}
		
     else {
       [(_this select 0),_haslaser] remoteExec ["NDS_fnc_6x6_loadlaser",_atv];
    };
};


NDS_fnc_6x6_loadlauncher = {
    private ["_atv","_haslauncher"];
    _atv = _this select 0;
    _haslauncher = _this select 1;
    if (local _atv) then {
        _atv animate ["ShowM136", _haslauncher];}
		
     else {
       [(_this select 0),_haslauncher] remoteExec ["NDS_fnc_6x6_loadlauncher",_atv];
    };
};


NDS_fnc_6x6_loadmortar = {
    private ["_atv","_hasmortar"];
    _atv = _this select 0;
    _hasmortar = _this select 1;
    if (local _atv) then {
        _atv animate ["mortar", _hasmortar];}
		
     else {
       [(_this select 0),_hasmortar] remoteExec ["NDS_fnc_6x6_loadmortar",_atv];
    };
};



NDS_fnc_6x6_load = {
 private ["_ATV", "_hascargo", "_hasmedikit", "_hastoolkit", "_haslaser", "_hasrifle", "_hasmortar", "_gameMedikits", "_gameToolkits", "_gameLasers", "_gameMortars", "_gameLaunchers", "_weapons", "_items", "_packs", "_gamemedikits", "_gametoolkits", "_veh"];
    _ATV = _this select 0;
	_hascargo = (_ATV animationPhase "HasCargo");
	

 if (local _ATV) then {
	if ( _hascargo == 1) exitwith 
		{
 //defines----------------------------------
 
_hasmedikit = 0;
_hastoolkit = 0;
_haslaser = 0;
_hasrifle = 0;
_hasmortar = 0;
_haslauncher = 0;

_gameMedikits = ["Medikit"];
_gameToolkits = ["ToolKit"];
_gameLasers = ["Laserdesignator","Laserdesignator_02","Laserdesignator_03","Laserdesignator_01_khk_F","Laserdesignator_02_ghex_F"];
_gameMortars = ["NDS_B_M224_mortar"];
_gameLaunchers = "getNumber( _x >> 'scope' ) isEqualTo 2 && { getNumber( _x >> 'type' ) isEqualTo 4 }"configClasses( configFile >> "CfgWeapons" ) apply { configName _x };


_weapons = weaponCargo _ATV;
_items = itemCargo _ATV;
_packs =  backpackCargo _ATV; 

 // end defines-------------------------------
 {
if (_x in _items) then 
 { 
  _hasmedikit = 1;
  };
 }forEach _gameMedikits; 
 
 {
if (_x in _items) then 
 { 
 _hastoolkit = 1; 
   };
 }forEach _gameToolkits;

 {
if (_x in _weapons) then 
 { 
 _haslaser = 1;
   };
 }forEach _gameLasers;
 
 
 
{
if (_x in _weapons) then 
 { 
  _haslauncher = 1; 
 };
 }forEach _gamelaunchers;
 
 {
if (_x in _packs) then 
 { 
 _hasmortar = 1; 
 };
 }forEach _gameMortars;
 [_ATV, _hasmedikit] call NDS_fnc_6x6_loadmedikit; 
 [_ATV, _hastoolkit] call NDS_fnc_6x6_loadtoolkit;
 [_ATV, _haslaser] call NDS_fnc_6x6_loadlaser; 
 [_ATV, _haslauncher] call NDS_fnc_6x6_loadlauncher;
 [_ATV, _hasmortar] call NDS_fnc_6x6_loadmortar;


}; //end of exitwith
	} else {
       [(_this select 0)] remoteExec ["NDS_fnc_6x6_load",_ATV];
    };
};





_ATV = _this;
if (local _ATV) then {
if ((_ATV animationPhase "Hascargo") == 1) then
		{
//_ATV additemcargoglobal ["Medikit", 1];
//_ATV additemcargoglobal ["Toolkit", 1];
//_ATV additemcargoglobal ["U_B_FullGhillie_sard", 1];
//_ATV addbackpackcargoglobal ["NDS_B_M224_mortar", 1];
//_ATV addmagazinecargoglobal ["Laserbatteries", 1];
//_ATV addweaponcargoglobal	["Laserdesignator_01_khk_F", 1];	
		
		
		
		
		
		
		
		
		
_hasmedikit = 0;
_hastoolkit = 0;
_haslaser = 0;
_hasmortar = 0;
_haslauncher = 0;

_gameMedikits = ["Medikit"];
_gameToolkits = ["ToolKit"];
_gameLasers = ["Laserdesignator","Laserdesignator_02","Laserdesignator_03","Laserdesignator_01_khk_F","Laserdesignator_02_ghex_F"];
_gameMortars = ["NDS_B_M224_mortar"];
_gameLaunchers = "getNumber( _x >> 'scope' ) isEqualTo 2 && { getNumber( _x >> 'type' ) isEqualTo 4 }"configClasses( configFile >> "CfgWeapons" ) apply { configName _x };


_weapons = weaponCargo _ATV;
_items = itemCargo _ATV;
_packs =  backpackCargo _ATV; 

 // end defines-------------------------------
 {
if (_x in _items) then 
 { 
  _hasmedikit = 1;
  };
 }forEach _gameMedikits; 
 
 {
if (_x in _items) then 
 { 
 _hastoolkit = 1; 
  };
 }forEach _gameToolkits;

 {
if (_x in _weapons) then 
 { 
 _haslaser = 1;
  };
 }forEach _gameLasers;
 
 
 
{
if (_x in _weapons) then 
 { 
  _haslauncher = 1; 
 };
 }forEach _gameLaunchers;
 
 {
if (_x in _packs) then 
 { 
 _hasmortar = 1; 
 };
 }forEach _gameMortars;
 
 [_ATV, _hasmedikit] call NDS_fnc_6x6_loadmedikit; 
 [_ATV, _hastoolkit] call NDS_fnc_6x6_loadtoolkit;
 [_ATV, _haslaser] call NDS_fnc_6x6_loadlaser; 
 [_ATV, _haslauncher] call NDS_fnc_6x6_loadlauncher;
 [_ATV, _hasmortar] call NDS_fnc_6x6_loadmortar;


};

if (_ATV animationphase "camnetdeploy" == 1) then
		{
			_ATV enableRopeAttach false;
			_ATV enableVehicleCargo false;
			if (isNull driver _ATV) then {} else
				{
					(driver _ATV) action ["getout", _ATV];
				};
			if (_ATV animationphase "isTransported" == 1) then {_ATV animatesource ["camnetdeploy",0];_ATV enableVehicleCargo true;};
		};

};

//_cargobp = getBackpackCargo _ATV;
//_cargom = getMagazineCargo _ATV;
//_cargow = getWeaponCargo _ATV;









//_mass3 = (_ATV animationPhase "Hidecargo") * 225;
//_newmass = 853 - _mass3;  //change this to max AUW fully loaded
//_ATV setmass _newmass;






