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
      " PlayCasterBindEffect,effectID=2922; Wait,waitTime=2300; PlayCasterAnimation,animName = Switch; PlayCasterBindEffect,effectID=2558; PlayCasterHUDVisible,visible=1; PlayCasterControlOutLine,enable=1; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
