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
      gridEffectID = 1510,
      gridEffectDelayTime = 266,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    2300,
    {audioID = 2042, audioType = 1}
  }
}
return config, "ID", key
