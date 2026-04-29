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
    36,
    1,
    0,
    500,
    {
      gridEffectID = 2908,
      gridEffectDelayTime = 1000,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  }
}
return config, "ID", key
