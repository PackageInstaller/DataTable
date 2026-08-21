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
    43,
    1,
    1,
    0,
    {audioID = 2037, audioType = 1}
  },
  {
    2,
    2,
    43,
    2,
    1,
    300,
    {audioID = 2038, audioType = 1}
  },
  {
    3,
    3,
    34,
    2,
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
