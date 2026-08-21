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
    1,
    1,
    0,
    0,
    {
      castEffectID = 514,
      castAnimation = "Atk",
      hitPointDelay = 363,
      onHitAnimation = "Hit",
      hitEffectID = 510,
      castTotalTime = 700,
      hpDelayTime = 0
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 5080, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID =506; "
    }
  }
}
return config, "ID", key
