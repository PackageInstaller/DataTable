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
    0,
    1,
    0,
    0,
    {
      " PlayCasterBindEffect,effectID =526; "
    }
  },
  {
    2,
    2,
    1,
    1,
    1,
    0,
    {
      castEffectID = 525,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 100,
      longAtkEffectDelay = 166,
      hitPointDelay = 300,
      longHitPointDelay = 366,
      onHitAnimation = "Hit",
      hitEffectID = 0,
      castTotalTime = 333,
      longCastTotalTime = 500,
      hpDelayTime = 0
    }
  },
  {
    3,
    3,
    43,
    1,
    1,
    0,
    {
      audioID = 2154,
      atkSoundDelay = 100,
      longAtkSoundDelay = 166,
      audioType = 1
    }
  }
}
return config, "ID", key
