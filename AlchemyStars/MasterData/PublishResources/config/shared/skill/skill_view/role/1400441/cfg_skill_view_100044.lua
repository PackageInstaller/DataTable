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
      castEffectID = 779,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 60,
      longAtkEffectDelay = 160,
      hitPointDelay = 150,
      longHitPointDelay = 250,
      onHitAnimation = "Hit",
      hitEffectID = 780,
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
      audioID = 2128,
      atkSoundDelay = 60,
      longAtkSoundDelay = 160,
      audioType = 1
    }
  }
}
return config, "ID", key
