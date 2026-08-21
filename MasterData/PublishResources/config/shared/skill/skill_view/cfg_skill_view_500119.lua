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
      " PlayCasterAnimation,animName = Death; PlayCasterBindEffect,effectID=585; PlayCasterBindEffect,effectID=586; Wait,waitTime=4000; "
    }
  }
}
return config, "ID", key
