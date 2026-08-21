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
      " PlayCasterBindEffect,effectID=3526; PlayAudio,audioID=6177,audioType=1; PlayCasterAnimation,animName=Birth; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; Wait,waitTime=1300; "
    }
  }
}
return config, "ID", key
