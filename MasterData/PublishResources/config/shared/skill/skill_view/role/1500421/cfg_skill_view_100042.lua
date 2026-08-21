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
      castEffectID = 1371,
      hitEffectID = 1372,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 100,
      longAtkEffectDelay = 266,
      hitPointDelay = 150,
      longHitPointDelay = 316,
      slantCastEffectID = 1373,
      slantHitEffectID = 1374,
      slantCastAnimation = "Atk2",
      slantCastLongAnimation = "Atk2_Long",
      slantAtkEffectDelay = 150,
      slantLongAtkEffectDelay = 266,
      slantHitPointDelay = 180,
      slantLongHitPointDelay = 300,
      onHitAnimation = "Hit",
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
      audioID = 3030,
      atkSoundDelay = 0,
      longAtkSoundDelay = 166,
      slantAudioID = 3031,
      slantAtkSoundDelay = 0,
      slantLongAtkSoundDelay = 166,
      audioType = 1
    }
  }
}
return config, "ID", key
