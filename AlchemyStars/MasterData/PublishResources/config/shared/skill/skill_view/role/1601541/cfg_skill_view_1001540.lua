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
      castEffectID = 3591,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 20,
      longAtkEffectDelay = 180,
      hitPointDelay = 70,
      longHitPointDelay = 230,
      onHitAnimation = "Hit",
      hitEffectID = 3590,
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
      audioID = 2463,
      atkSoundDelay = 20,
      longAtkSoundDelay = 180,
      audioType = 1
    }
  }
}
return config, "ID", key
