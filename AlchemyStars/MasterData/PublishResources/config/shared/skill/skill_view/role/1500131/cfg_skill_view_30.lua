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
      effectparam = "105,106",
      castAnimationName = "AtkChain",
      finishDelayTime = 0,
      buffDelayTime = 0
    },
    {"", "0,-1"}
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      "PlayAudio,audioID = 2141,audioType=1;"
    }
  },
  {
    3,
    3,
    64,
    1,
    1,
    1000,
    {
      gridEffectID = 107,
      intervalTime = 200,
      hitAnimName = "Hit",
      hitEffectID = 108,
      scopeHorizontalOrVertical = 1,
      gridEffectDirection = "Up"
    }
  }
}
return config, "ID", key
