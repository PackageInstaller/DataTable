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
      castEffectID = 103,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 66,
      longAtkEffectDelay = 180,
      hitPointDelay = 110,
      longHitPointDelay = 233,
      onHitAnimation = "Hit",
      hitEffectID = 104,
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
      audioID = 2140,
      atkSoundDelay = 66,
      longAtkSoundDelay = 180,
      audioType = 1
    }
  }
}
return config, "ID", key
