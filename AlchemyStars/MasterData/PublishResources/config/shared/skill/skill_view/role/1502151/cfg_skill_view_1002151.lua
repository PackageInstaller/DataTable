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
      castEffectID = 150215109,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 50,
      hitPointDelay = 90,
      longHitPointDelay = 140,
      onHitAnimation = "Hit",
      hitEffectID = 150215110,
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
      audioID = 150215102,
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
      "PlayCasterSubMaterialAnim,nodeName=1502151_weapon,animName=effanim_1502151_atk01_mat;"
    }
  }
}
return config, "ID", key
