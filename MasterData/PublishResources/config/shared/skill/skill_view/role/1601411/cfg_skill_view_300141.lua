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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1500421,waitTime = 2000; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=3293; PlayAudio,audioID = 2407,audioType=1; Wait,waitTime=4800; "
    }
  },
  {
    3,
    3,
    86,
    2,
    1,
    200,
    {
      bornEffectID = 3294,
      bornEffectDelayTime = 0,
      moveEffectID = 3295,
      moveEffectDelayTime = 1100,
      moveEffectFlyOneGirdMs = 400,
      disappearEffectID = 3296,
      disappearEffectTime = 560,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = 3299,
      hitEffectTime = 0,
      clearBodyNow = 0,
      damageIndex = 1
    }
  },
  {
    4,
    4,
    31,
    2,
    1,
    1350,
    {
      gridEffectID = 0,
      gridIntervalTime = 400,
      bestConvertTime = 50,
      finishDelayTime = 1000,
      hasConvert = 1,
      hasDamage = 0,
      hitAnimationName = "Hit",
      hitEffectID = -1,
      gridEffectDirection = "Up",
      backwardByPickNum = 1
    }
  }
}
return config, "ID", key
