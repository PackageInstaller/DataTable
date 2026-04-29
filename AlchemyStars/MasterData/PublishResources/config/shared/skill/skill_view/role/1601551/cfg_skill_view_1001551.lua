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
      castEffectID = 3641,
      castAnimation = "Atk2",
      castLongAnimation = "Atk2_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 100,
      hitPointDelay = 150,
      longHitPointDelay = 250,
      onHitAnimation = "Hit",
      hitEffectID = 3642,
      castTotalTime = 333,
      longCastTotalTime = 500,
      hpDelayTime = 0,
      skillStageIndex = 2
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
      audioID = 2467,
      atkSoundDelay = 0,
      longAtkSoundDelay = 150,
      audioType = 1
    }
  }
}
return config, "ID", key
