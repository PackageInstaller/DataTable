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
      castEffectID = 3486,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 50,
      longAtkEffectDelay = 0,
      hitPointDelay = 100,
      longHitPointDelay = 100,
      onHitAnimation = "Hit",
      hitEffectID = 3487,
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
      audioID = 2443,
      atkSoundDelay = 0,
      longAtkSoundDelay = 0,
      audioType = 1
    }
  }
}
return config, "ID", key
