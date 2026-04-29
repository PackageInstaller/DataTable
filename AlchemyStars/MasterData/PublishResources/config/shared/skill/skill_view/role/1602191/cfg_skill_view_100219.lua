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
      castEffectID = 160219104,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 100,
      longAtkEffectDelay = 100,
      hitPointDelay = 300,
      longHitPointDelay = 300,
      onHitAnimation = "Hit",
      hitEffectID = 160219105,
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
      audioID = 160219101,
      atkSoundDelay = 0,
      longAtkSoundDelay = 0,
      audioType = 1
    }
  }
}
return config, "ID", key
