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
      castEffectID = 329,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 66,
      longAtkEffectDelay = 165,
      hitPointDelay = 80,
      longHitPointDelay = 230,
      onHitAnimation = "Hit",
      hitEffectID = 330,
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
      audioID = 2146,
      atkSoundDelay = 66,
      longAtkSoundDelay = 165,
      audioType = 1
    }
  }
}
return config, "ID", key
