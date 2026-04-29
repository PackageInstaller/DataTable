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
      castEffectID = 79,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 100,
      longAtkEffectDelay = 200,
      hitPointDelay = 133,
      longHitPointDelay = 264,
      onHitAnimation = "Hit",
      hitEffectID = 80,
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
      audioID = 2161,
      atkSoundDelay = 100,
      longAtkSoundDelay = 264,
      audioType = 1
    }
  }
}
return config, "ID", key
