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
      " PlayEffectAtCasterPos, effectID=160006101; PlayCasterAnimation,animName=AtkUlt; Wait,waitTime=500; PlayAudio,audioID = 3044,audioType=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=160006102; Wait,waitTime=150; PlayRoleTeleport, type=3; PlayRoleTeleport, type=5, onlySelf=0; Wait,waitTime=350; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayCasterAnimation,animName=AtkUlt2; PlayCasterBindEffect,effectID=160006104; Wait,waitTime=3166; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1950,
    {
      "PlayEffectAtCasterPos,effectID=160006105; Wait,waitTime=800; PlayCasterBindEffect,effectID=160006103; "
    }
  },
  {
    4,
    4,
    54,
    2,
    1,
    2800,
    {
      gridEffectIDs = {160006106, 160006107},
      gridEdgeEffectID = 160006108,
      gridIntervalTime = 50,
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
  }
}
return config, "ID", key
