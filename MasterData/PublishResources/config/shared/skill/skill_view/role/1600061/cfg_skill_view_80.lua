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
      effectparam = "212",
      castAnimationName = "AtkChain",
      finishDelayTime = 2933,
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
    {audioID = 3043, audioType = 1}
  },
  {
    3,
    3,
    54,
    1,
    1,
    1700,
    {
      gridEffectIDs = {313, 314},
      gridEdgeEffectID = 213,
      gridIntervalTime = 0,
      finishDelayTime = 100,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = -1,
      effScaleStart = 1,
      defaultScale = 1,
      layerScale = 0.1,
      effectIgnore = 1
    }
  }
}
return config, "ID", key
