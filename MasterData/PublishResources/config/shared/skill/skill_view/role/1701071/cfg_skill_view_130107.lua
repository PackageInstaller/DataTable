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
      castEffectID = 2465,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 133,
      longAtkEffectDelay = 266,
      hitPointDelay = 166,
      longHitPointDelay = 300,
      onHitAnimation = "Hit",
      hitEffectID = 2463,
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
      audioID = 2271,
      atkSoundDelay = 133,
      longAtkSoundDelay = 266,
      audioType = 1
    }
  }
}
return config, "ID", key
