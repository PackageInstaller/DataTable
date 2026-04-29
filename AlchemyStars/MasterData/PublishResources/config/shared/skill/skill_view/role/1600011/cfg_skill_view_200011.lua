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
      effectparam = "3",
      castAnimationName = "AtkChain",
      finishDelayTime = 1500,
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
    {audioID = 2004, audioType = 1}
  },
  {
    3,
    3,
    64,
    1,
    1,
    700,
    {
      gridEffectID = 5,
      intervalTime = 33,
      hitAnimName = "Hit",
      hitEffectID = 0,
      scopeHorizontalOrVertical = 1,
      gridEffectDirection = "Up"
    }
  }
}
return config, "ID", key
