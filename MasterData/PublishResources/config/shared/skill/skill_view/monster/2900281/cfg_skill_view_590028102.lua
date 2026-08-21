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
    2,
    34,
    1,
    1,
    3000,
    {
      gridEffectID = 772,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 1000
    }
  }
}
return config, "ID", key
