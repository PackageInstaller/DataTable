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
    26,
    1,
    0,
    0,
    {
      castEffectID = 616,
      castAnimationName = "Atk",
      hitDelayTime = 1050,
      trajectoryType = 1,
      trajectoryEffectID = 614,
      trajectoryTime = 50,
      targetEffectID = 615,
      hpDelay = 0,
      hitAnimationName = "Hit",
      hitEffectID = 615,
      finishDelayTime = 500
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 5086, audioType = 1}
  }
}
return config, "ID", key
