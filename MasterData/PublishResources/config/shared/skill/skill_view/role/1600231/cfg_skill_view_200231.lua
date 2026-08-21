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
    26,
    1,
    0,
    0,
    {
      castEffectID = 430,
      castAnimationName = "AtkChain",
      hitDelayTime = 500,
      targetEffectID = 432,
      hitAnimationName = "Hit",
      finishDelayTime = 1500,
      hpDelay = 500
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
      "PlayAudio,audioID = 2180,audioType=1;"
    }
  }
}
return config, "ID", key
