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
      " PlayCasterHUDVisible,visible=0; PlayCasterVisible,visible=1; PlayCasterAnimation,animName=birth; PlayAudio,audioID = 6032,audioType=1; Wait,waitTime=0; PlayCasterBindEffect,effectID=PARAM.effectidle; PlayCasterBindEffect,effectID=PARAM.effectmove; PlayCasterBindEffect,effectID=PARAM.effectbirth; Wait,waitTime=2000; PlayEffectAtCasterPos,effectID=PARAM.effectfogin,offsetZ=2; Wait,waitTime=250; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayRoleTeleport,type=6, onlySelf=1; PlayRoleTeleport,type=9, onlySelf=1; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; Wait,waitTime=900; "
    }
  }
}
return config, "ID", key
