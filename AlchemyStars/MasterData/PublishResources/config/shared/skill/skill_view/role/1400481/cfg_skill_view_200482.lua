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
      effectparam = "497",
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
    2000,
    {
      scopeHorizontalOrVertical = 2,
      trajectoryEffectID = 498,
      trajectoryEffectOffset = 0,
      trajectoryTime = 100,
      totalTime = 1000,
      targetWaitTime = 100,
      targetEffectID = 50300,
      targetDelayTime = 0,
      hitAnimationName = "Hit",
      hitEffectID = 50300,
      hitEffectTime = 100,
      clearBodyNow = 0,
      damageIndex = 1,
      finishDelayTime = 1000,
      beginDelayTime = 1000,
      trajectoryFollowingEffectID = 499,
      trajectoryFinishEffectID = 500,
      trajectoryFinishEffectTime = 1000,
      tailDismissDelay = 3000
    }
  }
}
return config, "ID", key
