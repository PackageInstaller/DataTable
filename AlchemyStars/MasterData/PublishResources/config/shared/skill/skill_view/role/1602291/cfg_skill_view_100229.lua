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
      castEffectID = 160229102,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 50,
      hitPointDelay = 180,
      longHitPointDelay = 230,
      onHitAnimation = "Hit",
      hitEffectID = 160229101,
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
      audioID = 160229101,
      atkSoundDelay = 0,
      longAtkSoundDelay = 50,
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
      "PlayCasterBindEffect,effectID =160229103;"
    }
  }
}
return config, "ID", key
