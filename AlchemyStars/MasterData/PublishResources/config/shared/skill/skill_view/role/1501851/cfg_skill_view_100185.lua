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
      castEffectID = 150185101,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 100,
      hitPointDelay = 0,
      longHitPointDelay = 100,
      onHitAnimation = "Hit",
      hitEffectID = 150185102,
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
      audioID = 2596,
      atkSoundDelay = 0,
      longAtkSoundDelay = 100,
      audioType = 1
    }
  }
}
return config, "ID", key
