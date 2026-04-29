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
      " Wait,waitTime=100; PlayCasterBindEffect,effectID=3807 Wait,waitTime=950; PlayCasterBindEffect,effectID=3808; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
