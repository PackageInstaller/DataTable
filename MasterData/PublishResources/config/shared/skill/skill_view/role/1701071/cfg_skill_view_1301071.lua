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
      castEffectID = 2466,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 100,
      longAtkEffectDelay = 200,
      hitPointDelay = 160,
      longHitPointDelay = 260,
      onHitAnimation = "Hit",
      hitEffectID = 2464,
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
      audioID = 2271,
      atkSoundDelay = 100,
      longAtkSoundDelay = 200,
      audioType = 1
    }
  }
}
return config, "ID", key
