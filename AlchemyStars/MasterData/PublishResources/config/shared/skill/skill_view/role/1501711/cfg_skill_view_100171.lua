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
      castEffectID = 150171101,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 100,
      longAtkEffectDelay = 334,
      hitPointDelay = 140,
      longHitPointDelay = 374,
      onHitAnimation = "Hit",
      hitEffectID = 150171102,
      castTotalTime = 333,
      longCastTotalTime = 550,
      hpDelayTime = 0
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID = 150171103; "
    }
  },
  {
    3,
    3,
    43,
    1,
    0,
    0,
    {
      audioID = 2533,
      atkSoundDelay = 100,
      longAtkSoundDelay = 334,
      audioType = 1
    }
  }
}
return config, "ID", key
