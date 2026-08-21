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
      castEffectID = 140169103,
      castAnimation = "Atk02",
      castLongAnimation = "Atk_02_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 66,
      hitPointDelay = 250,
      longHitPointDelay = 310,
      onHitAnimation = "Hit",
      hitEffectID = 140169104,
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
      audioID = 2545,
      atkSoundDelay = 0,
      longAtkSoundDelay = 66,
      audioType = 1
    }
  }
}
return config, "ID", key
