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
      effectparam = "331",
      castAnimationName = "AtkChain",
      finishDelayTime = 0,
      buffDelayTime = 1500,
      buffNeedImmediatelyEffect = 0
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      "PlayAudio,audioID = 2147,audioType=1;"
    }
  },
  {
    3,
    3,
    57,
    1,
    1,
    1000,
    {beginDelay = 0, showType = 0}
  },
  {
    4,
    4,
    31,
    1,
    1,
    1000,
    {
      gridEffectID = 332,
      gridIntervalTime = 33,
      finishDelayTime = 1000,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = 0
    }
  },
  {
    5,
    5,
    57,
    2,
    1,
    2500,
    {beginDelay = 0, showType = 1}
  }
}
return config, "ID", key
