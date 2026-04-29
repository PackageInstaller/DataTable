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
      effectparam = "1543",
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
    {audioID = 2034, audioType = 1}
  },
  {
    3,
    3,
    26,
    2,
    1,
    369,
    {
      hitDelayTime = 0,
      hitAnimationName = "Hit",
      hitEffectID = 1545,
      finishDelayTime = 300,
      trajectoryType = 3,
      trajectoryEffectID = 1544,
      trajectoryTime = 50
    }
  }
}
return config, "ID", key
