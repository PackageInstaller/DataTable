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
      castEffectID = 3664,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 150,
      longAtkEffectDelay = 250,
      hitPointDelay = 150,
      longHitPointDelay = 250,
      onHitAnimation = "Hit",
      hitEffectID = 3665,
      castTotalTime = 333,
      longCastTotalTime = 700,
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
      audioID = 2472,
      atkSoundDelay = 0,
      longAtkSoundDelay = 150,
      audioType = 1
    }
  }
}
return config, "ID", key
