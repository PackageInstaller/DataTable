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
      castEffectID = 160006401,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 66,
      longAtkEffectDelay = 231,
      hitPointDelay = 100,
      longHitPointDelay = 264,
      onHitAnimation = "Hit",
      hitEffectID = 160006402,
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
      audioID = 16000641,
      atkSoundDelay = 0,
      longAtkSoundDelay = 200,
      audioType = 1
    }
  }
}
return config, "ID", key
