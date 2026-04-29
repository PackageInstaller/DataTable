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
    85,
    1,
    0,
    0,
    {
      castEffectID = 3186,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 66,
      hitPointDelay = 233,
      longHitPointDelay = 300,
      hitEffectID = 0,
      castTotalTime = 333,
      longCastTotalTime = 500,
      hpDelayTime = 0,
      normalDoubleHitEffectID = 140169102,
      normalDoubleHitAnimation = "Hit"
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
      audioID = 2370,
      atkSoundDelay = 0,
      longAtkSoundDelay = 66,
      audioType = 1
    }
  }
}
return config, "ID", key
