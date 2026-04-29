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
    2,
    0,
    0,
    {
      " PlayAudio,audioID = 2364,audioType=1; PlayCasterBindEffect,effectID=3137; PlayCasterMaterialAnim,animName=eff_1601201_atkult_skin; PlayCasterAnimation,animName=AtkUlt; Wait,waitTime=950; PlayRoleTeleport, type=5, onlySelf=0; Wait,waitTime=3500; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; "
    }
  },
  {
    2,
    2,
    0,
    2,
    0,
    1000,
    {
      " PlayCasterBindEffect, effectID=3138; "
    }
  },
  {
    3,
    3,
    54,
    2,
    0,
    1100,
    {
      gridEffectIDs = {3140},
      gridEdgeEffectID = 3140,
      gridIntervalTime = 50,
      bestConvertTime = 0,
      finishDelayTime = 0,
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
