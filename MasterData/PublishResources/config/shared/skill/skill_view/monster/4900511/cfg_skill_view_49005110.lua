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
    34,
    1,
    0,
    0,
    {
      gridEffectDelayTime = 900,
      gridIntervalTime = 100,
      showTimeDelay = 1000
    }
  }
}
return config, "ID", key
