local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      castEffectID = 2392,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 140,
      hitPointDelay = 160,
      longHitPointDelay = 300,
      onHitAnimation = "Hit",
      hitEffectID = 2393,
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
      audioID = 2243,
      atkSoundDelay = 0,
      longAtkSoundDelay = 140,
      audioType = 1
    }
  }
}
return config, "ID", key
