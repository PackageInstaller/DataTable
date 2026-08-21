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
    0,
    1,
    0,
    0,
    {
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,petID = 1300221,waitTime = 2000;"
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
      "PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2091,audioType=1; PlayCasterBindEffect,effectID=122,123; Wait,waitTime=1700; "
    }
  },
  {
    3,
    3,
    54,
    2,
    2,
    0,
    {
      gridEffectIDs = {124},
      gridEdgeEffectID = 124,
      gridIntervalTime = 100,
      bestConvertTime = 0,
      finishDelayTime = 1500,
      hasConvert = 0,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = -1,
      effScaleStart = 1,
      defaultScale = 0.8,
      layerScale = 0.1
    }
  }
}
return config, "ID", key
