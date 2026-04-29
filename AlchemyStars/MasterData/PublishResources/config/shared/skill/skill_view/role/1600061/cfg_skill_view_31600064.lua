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
    60,
    2,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 4},
        effectID = 160006407
      }
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " PlayTurnToSpecifiedDir,dirX=1,dirY=0; PlayCameraEffect,effectID=160006406; PlayEffectAtCasterPos,effectID = 160006403; PlayCasterMaterialAnim,animName=effanim_1600064_ult_m_01; PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 2420; Wait,waitTime=700; PlayRoleTeleport, type=3; PlayRoleTeleport, type=5, onlySelf=0; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    1200,
    {
      " PlayTurnToSpecifiedDir,dirX=1,dirY=0; PlayEffectAtCasterPos,effectID = 160006404; Wait,waitTime=100; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayCasterAnimation,animName=AtkUlt2; Wait,waitTime=5000; PlayTurnToSpecifiedDir,dirX=1,dirY=0; "
    }
  },
  {
    5,
    5,
    54,
    2,
    1,
    4500,
    {
      gridEffectIDs = {160006405},
      gridEdgeEffectID = 160006405,
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
