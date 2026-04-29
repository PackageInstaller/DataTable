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
      castEffectID = 0,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 170,
      hitPointDelay = 130,
      longHitPointDelay = 300,
      onHitAnimation = "Hit",
      hitEffectID = 3056,
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
      audioID = 2338,
      atkSoundDelay = 0,
      longAtkSoundDelay = 160,
      audioType = 1
    }
  }
}
return config, "ID", key
