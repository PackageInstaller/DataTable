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
      effectparam = "825,826",
      finishDelayTime = 0,
      buffDelayTime = 3200
    }
  },
  {
    2,
    2,
    26,
    1,
    1,
    0,
    {
      castAnimationName = "Skill",
      hitDelayTime = 3200,
      targetEffectID = 0,
      hitAnimationName = "Hit",
      finishDelayTime = 1820,
      hpDelay = 0
    }
  },
  {
    3,
    3,
    43,
    1,
    1,
    300,
    {audioID = 5090, audioType = 1}
  }
}
return config, "ID", key
