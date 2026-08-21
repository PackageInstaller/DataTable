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
      castEffectID = 160202104,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 100,
      hitPointDelay = 180,
      longHitPointDelay = 280,
      onHitAnimation = "Hit",
      hitEffectID = 160202105,
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
      audioID = 2649,
      atkSoundDelay = 0,
      longAtkSoundDelay = 100,
      audioType = 1
    }
  }
}
return config, "ID", key
