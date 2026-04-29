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
      castEffectID = 469,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 80,
      longAtkEffectDelay = 130,
      hitPointDelay = 110,
      longHitPointDelay = 160,
      onHitAnimation = "Hit",
      hitEffectID = 470,
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
      audioID = 2095,
      atkSoundDelay = 80,
      longAtkSoundDelay = 130,
      audioType = 1
    }
  }
}
return config, "ID", key
