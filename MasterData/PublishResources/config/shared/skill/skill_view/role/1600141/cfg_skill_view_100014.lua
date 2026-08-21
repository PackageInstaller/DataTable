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
      castEffectID = 447,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 33,
      longAtkEffectDelay = 233,
      hitPointDelay = 66,
      longHitPointDelay = 300,
      onHitAnimation = "Hit",
      hitEffectID = 448,
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
      audioID = 2173,
      atkSoundDelay = 33,
      longAtkSoundDelay = 233,
      audioType = 1
    }
  }
}
return config, "ID", key
