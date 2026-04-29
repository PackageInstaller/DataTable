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
      castEffectID = 474,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 100,
      longAtkEffectDelay = 300,
      hitPointDelay = 166,
      longHitPointDelay = 366,
      onHitAnimation = "Hit",
      hitEffectID = 475,
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
      audioID = 2182,
      atkSoundDelay = 100,
      longAtkSoundDelay = 300,
      audioType = 1
    }
  }
}
return config, "ID", key
