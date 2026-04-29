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
      effectparam = "49700",
      castAnimationName = "AtkChain",
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
    {audioID = 2132, audioType = 1}
  },
  {
    3,
    3,
    72,
    1,
    1,
    1150,
    {
      scopeHorizontalOrVertical = 2,
      trajectoryEffectID = 49800,
      trajectoryEffectOffset = 0,
      trajectoryTime = 75,
      hitAnimationName = "Hit",
      hitEffectID = 50300,
      hitEffectTime = 0,
      clearBodyNow = 0,
      damageIndex = 1,
      beginDelayTime = 100,
      trajectoryFollowingEffectID = 49900,
      trajectoryFinishEffectID = 50000,
      trajectoryFinishEffectTime = 1000,
      tailDismissDelay = 3000
    }
  }
}
return config, "ID", key
