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
      castEffectID = 1097,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 33,
      longAtkEffectDelay = 166,
      hitPointDelay = 66,
      longHitPointDelay = 266,
      onHitAnimation = "Hit",
      hitEffectID = 1098,
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
    0,
    0,
    {
      audioID = 3019,
      atkSoundDelay = 0,
      longAtkSoundDelay = 130,
      audioType = 1
    }
  }
}
return config, "ID", key
