local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7
}
local config = {
  {
    1,
    1,
    0,
    1,
    0,
    0,
    {
      " PlayAudio,audioID = 29021313,audioType=1; PlayCasterBindEffect,effectID=290213105; PlayCasterAnimation,animName=Atk03; Wait,waitTime=500; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=300; PlayCasterBindEffect,effectID=290213106; PlayRoleTeleport,type=6, onlySelf=1; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
