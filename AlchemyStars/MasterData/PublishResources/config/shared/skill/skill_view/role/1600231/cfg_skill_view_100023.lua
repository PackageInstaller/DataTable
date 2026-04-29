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
      castEffectID = 428,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 300,
      longAtkEffectDelay = 300,
      hitPointDelay = 300,
      longHitPointDelay = 300,
      onHitAnimation = "Hit",
      hitEffectID = 429,
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
      audioID = 2179,
      atkSoundDelay = 300,
      longAtkSoundDelay = 300,
      audioType = 1
    }
  }
}
return config, "ID", key
