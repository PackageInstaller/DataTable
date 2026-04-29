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
      castEffectID = 160181101,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 133,
      hitPointDelay = 66,
      longHitPointDelay = 200,
      onHitAnimation = "Hit",
      hitEffectID = 0,
      castTotalTime = 333,
      longCastTotalTime = 500,
      hpDelayTime = 0,
      usePermanentEffectPlayAnim = 1,
      permanentEffSpecialAnimRoot = "1601811_weapon02_skin"
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
      audioID = 2583,
      atkSoundDelay = 0,
      longAtkSoundDelay = 133,
      audioType = 1
    }
  }
}
return config, "ID", key
