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
      castEffectID = 456,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 50,
      longAtkEffectDelay = 133,
      hitPointDelay = 100,
      longHitPointDelay = 180,
      onHitAnimation = "Hit",
      hitEffectID = 457,
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
      audioID = 2116,
      atkSoundDelay = 50,
      longAtkSoundDelay = 133,
      audioType = 1
    }
  }
}
return config, "ID", key
