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
    47,
    1,
    0,
    0,
    {
      castEffectID = 0,
      castAnimationStr = "Atk_l,Atk_r",
      blurDelay = {0, 0},
      blurEffectId = "636,635",
      hitPointDelay = {360, 360},
      onHitAnimation = "Hit",
      hitEffectID = {0, 0},
      overDelay = {790, 690}
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 5083, audioType = 1}
  }
}
return config, "ID", key
