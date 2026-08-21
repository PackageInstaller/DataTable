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
      castEffectID = 95,
      castAnimationName = "AtkChain",
      hitDelayTime = 0,
      targetEffectID = 96,
      hitAnimationName = "Hit",
      finishDelayTime = 1500,
      hpDelay = 1433
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2138, audioType = 1}
  }
}
return config, "ID", key
