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
      castEffectID = 395,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 85,
      longAtkEffectDelay = 165,
      hitPointDelay = 150,
      longHitPointDelay = 215,
      onHitAnimation = "Hit",
      hitEffectID = 365,
      castTotalTime = 333,
      longCastTotalTime = 500,
      hpDelayTime = 0
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {
      audioID = 2143,
      atkSoundDelay = 85,
      longAtkSoundDelay = 165,
      audioType = 1
    }
  }
}
return config, "ID", key
