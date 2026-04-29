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
      effectparam = "391",
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
      "PlayAudio,audioID = 2144,audioType=1;"
    }
  },
  {
    3,
    3,
    64,
    1,
    1,
    1250,
    {
      gridEffectID = 392,
      intervalTime = 50,
      hitAnimName = "Hit",
      hitEffectID = 0,
      scopeHorizontalOrVertical = 2,
      gridEffectDirection = "",
      quadrantDiagonal = true
    }
  }
}
return config, "ID", key
