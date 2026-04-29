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
      " PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=3518; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; Wait,waitTime=1000; PlayAudio,audioID=6185,audioType=1; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
