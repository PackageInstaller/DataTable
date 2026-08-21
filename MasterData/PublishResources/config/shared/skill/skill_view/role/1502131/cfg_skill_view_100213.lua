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
      castEffectID = 150213101,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 60,
      hitPointDelay = 110,
      longHitPointDelay = 170,
      onHitAnimation = "Hit",
      hitEffectID = 150213102,
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
      audioID = 150213101,
      atkSoundDelay = 0,
      longAtkSoundDelay = 60,
      audioType = 1
    }
  }
}
return config, "ID", key
