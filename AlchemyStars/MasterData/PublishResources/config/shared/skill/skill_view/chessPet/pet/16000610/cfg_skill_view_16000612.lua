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
      " PlayEffectAtCasterPos, effectID=215; PlayCasterAnimation,animName=Skill01; Wait,waitTime=500; PlayAudio,audioID = 3044,audioType=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=216; Wait,waitTime=333; PlayCasterAnimation,animName=AtkUlt2; Wait,waitTime=3166; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID=21700; Wait,waitTime=866; PlayCasterBindEffect,effectID=217; "
    }
  },
  {
    3,
    3,
    54,
    1,
    1,
    866,
    {
      gridEffectIDs = {310, 311},
      gridEdgeEffectID = 312,
      gridIntervalTime = 60,
      bestConvertTime = 1000,
      finishDelayTime = 100,
      hasConvert = 0,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = -1,
      effScaleStart = 1,
      defaultScale = 1,
      layerScale = 0.1
    }
  }
}
return config, "ID", key
