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
      " PlayRoleTeleport,type=9, onlySelf=1,stageIndex=1; PlayCasterVisible,visible=1; PlayAudio,audioID = 6034,audioType=1; PlayCasterAnimation,animName=moveup; Wait,waitTime=830; PlayRoleTeleport,type=9, onlySelf=1,stageIndex=2; PlayRoleTeleport,type=5, onlySelf=1,stageIndex=2; PlayRoleTeleport,type=6, onlySelf=1,stageIndex=2; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=0; PlayCasterAnimation,animName=movedown; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
