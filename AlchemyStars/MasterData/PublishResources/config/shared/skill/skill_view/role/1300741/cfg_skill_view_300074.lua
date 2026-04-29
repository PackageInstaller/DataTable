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
    0,
    1,
    0,
    0,
    {
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1300741,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1000,
    {
      " PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=1000; PlayCasterBindEffect,effectID=1050; Wait,waitTime=400; PlayMultiTraction,moveSpeed=10,targetEffectID=1052; "
    },
    {"", "1,0"}
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " PlayAudio,audioID = 3006,audioType=1; "
    }
  },
  {
    4,
    4,
    31,
    2,
    1,
    1550,
    {
      gridEffectID = 1051,
      gridIntervalTime = 0,
      bestConvertTime = 0,
      finishDelayTime = 1000,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = 0
    }
  }
}
return config, "ID", key
