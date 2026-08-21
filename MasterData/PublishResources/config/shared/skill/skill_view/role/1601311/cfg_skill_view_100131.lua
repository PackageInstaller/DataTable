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
      castEffectID = 3187,
      castAnimation = "Atk01",
      castLongAnimation = "Atk_Long01",
      atkEffectDelay = 0,
      longAtkEffectDelay = 66,
      hitPointDelay = 200,
      longHitPointDelay = 266,
      onHitAnimation = "Hit",
      hitEffectID = 3189,
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
      audioID = 2369,
      atkSoundDelay = 0,
      longAtkSoundDelay = 66,
      audioType = 1
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID =3188; "
    }
  }
}
return config, "ID", key
