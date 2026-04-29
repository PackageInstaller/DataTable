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
    2,
    1,
    0,
    0,
    {
      effectparam = "1467",
      castAnimationName = "Atk",
      finishDelayTime = 0,
      buffDelayTime = 0
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2037, audioType = 1}
  },
  {
    3,
    3,
    43,
    1,
    1,
    0,
    {audioID = 2038, audioType = 1}
  },
  {
    4,
    4,
    34,
    2,
    1,
    300,
    {
      gridEffectDelayTime = 900,
      gridIntervalTime = 100,
      showTimeDelay = 1000
    }
  }
}
return config, "ID", key
