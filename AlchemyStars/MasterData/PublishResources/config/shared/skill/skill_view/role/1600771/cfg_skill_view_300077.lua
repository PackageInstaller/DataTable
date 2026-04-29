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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600771,waitTime = 2000; "
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
      " PlayCasterMaterialAnim,animName=eff_1600771_atkult_main; PlayCameraEffect,effectID = 160077101; PlayCasterBindEffect,effectID =1087; PlayEffectAGridPos,effectID=1088,gridPosX=5,gridPosY=5; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 3003,audioType=1; Wait,waitTime=4500; "
    }
  },
  {
    3,
    3,
    31,
    1,
    2,
    1500,
    {
      gridEffectID = 1089,
      bestConvertTime = 2000,
      finishDelayTime = 1000,
      gridIntervalTime = 100,
      hasConvert = 1
    }
  }
}
return config, "ID", key
