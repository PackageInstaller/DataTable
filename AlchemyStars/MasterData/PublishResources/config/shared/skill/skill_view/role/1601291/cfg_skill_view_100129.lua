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
      castEffectID = 3088,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 200,
      longAtkEffectDelay = 250,
      hitPointDelay = 250,
      longHitPointDelay = 300,
      onHitAnimation = "Hit",
      hitEffectID = 3089,
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
      audioID = 2356,
      atkSoundDelay = 200,
      longAtkSoundDelay = 200,
      audioType = 1
    }
  }
}
return config, "ID", key
