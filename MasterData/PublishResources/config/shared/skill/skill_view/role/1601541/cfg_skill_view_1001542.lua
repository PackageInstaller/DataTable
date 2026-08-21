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
      castEffectID = 2294,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 166,
      hitPointDelay = 120,
      longHitPointDelay = 286,
      hitPointDelaySecond = 170,
      longHitPointDelaySecond = 334,
      onHitAnimation = "Hit",
      hitEffectID = 2252,
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
      audioID = 2251,
      atkSoundDelay = 0,
      longAtkSoundDelay = 166,
      audioType = 1
    }
  }
}
return config, "ID", key
