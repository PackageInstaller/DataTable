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
      castEffectID = 3575,
      castAnimation = "Atk_01",
      castLongAnimation = "Atk_01_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 160,
      hitPointDelay = 100,
      longHitPointDelay = 260,
      onHitAnimation = "Hit",
      hitEffectID = 3576,
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
      audioID = 2460,
      atkSoundDelay = 0,
      longAtkSoundDelay = 160,
      audioType = 1
    }
  }
}
return config, "ID", key
