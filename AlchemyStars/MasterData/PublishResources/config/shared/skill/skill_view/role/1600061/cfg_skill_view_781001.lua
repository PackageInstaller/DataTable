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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600061,waitTime = 2000;"
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
      " PlayEffectAtCasterPos, effectID=215; PlayCasterAnimation,animName=AtkUlt; Wait,waitTime=500; PlayAudio,audioID = 3044,audioType=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=216; Wait,waitTime=333; Wait,waitTime=0; PlayShowCasterOnPickUpGrid,pickUpIndex=1; PlayCasterAnimation,animName=AtkUlt2; Wait,waitTime=3166; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1733,
    {
      "PlayCasterBindEffect,effectID=21700; Wait,waitTime=866; PlayCasterBindEffect,effectID=217; "
    }
  },
  {
    4,
    4,
    107,
    2,
    1,
    2600,
    {
      gridEffectIDs = {310, 311},
      gridEdgeEffectID = 312,
      gridIntervalTime = 60,
      bestConvertTime = 1000,
      finishDelayTime = 100,
      hasConvert = 1,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = -1,
      effScaleStart = 1,
      defaultScale = 1,
      layerScale = 0.1
    }
  },
  {
    5,
    5,
    0,
    2,
    2,
    500,
    {
      "PlayCasterVisible,visible=0; PlayShowCasterOnPickUpGrid,reset=1;"
    }
  }
}
return config, "ID", key
