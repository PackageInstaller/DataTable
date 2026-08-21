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
      castEffectID = 150215107,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 60,
      hitPointDelay = 180,
      longHitPointDelay = 240,
      onHitAnimation = "Hit",
      hitEffectID = 150215108,
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
      audioID = 150215101,
      atkSoundDelay = 0,
      longAtkSoundDelay = 60,
      audioType = 1
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      "PlayCasterSubMaterialAnim,nodeName=1502151_weapon,animName=effanim_1502151_atk_mat;"
    }
  }
}
return config, "ID", key
