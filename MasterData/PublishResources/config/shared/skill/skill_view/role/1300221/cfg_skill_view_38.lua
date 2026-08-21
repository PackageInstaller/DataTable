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
      castEffectID = 118,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 33,
      longAtkEffectDelay = 120,
      hitPointDelay = 66,
      longHitPointDelay = 200,
      onHitAnimation = "Hit",
      hitEffectID = 119,
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
      audioID = 2089,
      atkSoundDelay = 33,
      longAtkSoundDelay = 200,
      audioType = 1
    }
  }
}
return config, "ID", key
