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
      castEffectID = 60,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 132,
      longAtkEffectDelay = 181,
      hitPointDelay = 166,
      longHitPointDelay = 220,
      onHitAnimation = "Hit",
      hitEffectID = 61,
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
      audioID = 2110,
      atkSoundDelay = 132,
      longAtkSoundDelay = 181,
      audioType = 1
    }
  }
}
return config, "ID", key
