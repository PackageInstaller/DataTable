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
      castEffectID = 2995,
      castAnimation = "Atk02",
      castLongAnimation = "Atk_Long02",
      atkEffectDelay = 0,
      longAtkEffectDelay = 200,
      hitPointDelay = 150,
      longHitPointDelay = 350,
      onHitAnimation = "Hit",
      hitEffectID = 2996,
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
      audioID = 2332,
      atkSoundDelay = 0,
      longAtkSoundDelay = 200,
      audioType = 1
    }
  }
}
return config, "ID", key
