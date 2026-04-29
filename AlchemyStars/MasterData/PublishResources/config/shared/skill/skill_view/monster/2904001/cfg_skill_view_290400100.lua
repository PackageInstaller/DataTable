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
      " PlayAudio,audioID=6241,audioType=1; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=290400108; Wait,waitTime=2900; "
    }
  }
}
return config, "ID", key
