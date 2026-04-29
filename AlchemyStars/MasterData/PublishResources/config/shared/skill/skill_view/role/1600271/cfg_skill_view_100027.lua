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
      castEffectID = 1808,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 80,
      hitPointDelay = 180,
      longHitPointDelay = 260,
      onHitAnimation = "Hit",
      hitEffectID = 1809,
      castTotalTime = 333,
      longCastTotalTime = 500,
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
      " PlayCasterBindEffect,effectID=1810; PlayCasterBindEffect,effectID=1811; "
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
      audioID = 3106,
      atkSoundDelay = 0,
      longAtkSoundDelay = 80,
      audioType = 1
    }
  }
}
return config, "ID", key
