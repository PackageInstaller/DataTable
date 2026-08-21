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
    1000,
    {
      gridEffectID = 873,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 300
    }
  }
}
return config, "ID", key
