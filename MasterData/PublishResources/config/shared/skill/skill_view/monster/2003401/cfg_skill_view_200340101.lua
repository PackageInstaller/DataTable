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
      " PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterBindEffect,effectID=200340101; PlayCasterBindEffect,effectID=200340102; PlayCasterAnimation,animName=Birth; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
