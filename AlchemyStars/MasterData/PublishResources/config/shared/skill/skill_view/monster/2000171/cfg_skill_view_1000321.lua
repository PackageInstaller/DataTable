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
      effectparam = "304,305",
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
    {audioID = 7010, audioType = 1}
  },
  {
    3,
    3,
    36,
    2,
    1,
    600,
    {
      gridEffectID = 306,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 1000
    }
  }
}
return config, "ID", key
