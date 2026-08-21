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
      castEffectID = 160230103,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 20,
      longAtkEffectDelay = 180,
      hitPointDelay = 70,
      longHitPointDelay = 230,
      onHitAnimation = "Hit",
      hitEffectID = 160230104,
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
      audioID = 160230101,
      atkSoundDelay = 10,
      longAtkSoundDelay = 50,
      audioType = 1
    }
  }
}
return config, "ID", key
