local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      effectparam = "62",
      castAnimationName = "AtkChain",
      finishDelayTime = 3000,
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
    {audioID = 2111, audioType = 1}
  },
  {
    3,
    3,
    61,
    1,
    1,
    250,
    {
      gridEffectID = 63,
      hitAnimName = "Hit",
      hitEffectID = 61,
      spreadIntervalTime = 250,
      spreadShape = 1
    }
  }
}
return config, "ID", key
