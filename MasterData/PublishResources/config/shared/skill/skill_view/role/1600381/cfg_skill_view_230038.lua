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
      effectparam = "40500",
      castAnimationName = "AtkChain",
      finishDelayTime = 0,
      buffDelayTime = 0
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
      " Wait,waitTime=500; PlayAudio,audioID = 2189,audioType=1;"
    }
  },
  {
    3,
    3,
    31,
    1,
    1,
    1780,
    {
      gridEffectID = 40600,
      gridIntervalTime = 100,
      finishDelayTime = 500,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = 0,
      gridEffectDirection = "Up"
    }
  }
}
return config, "ID", key
