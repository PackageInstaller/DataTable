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
      castEffectID = 135,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 50,
      longAtkEffectDelay = 150,
      hitPointDelay = 100,
      longHitPointDelay = 200,
      onHitAnimation = "Hit",
      hitEffectID = 136,
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
      audioID = 2068,
      atkSoundDelay = 50,
      longAtkSoundDelay = 150,
      audioType = 1
    }
  }
}
return config, "ID", key
