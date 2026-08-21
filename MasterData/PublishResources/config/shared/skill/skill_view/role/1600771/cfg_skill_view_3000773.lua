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
      " PlayAudio,audioID = 2566,audioType=1; PlayCasterBindEffect,effectID =160077307; PlayCasterAnimation,animName = AtkUlt; PlayCasterSubMaterialAnim,nodeName=1600773_weapon,animName=eff_1600773_atkult_weapon_s; PlayEffectAGridPos,effectID=160077306,gridPosX=5,gridPosY=4; PlayCameraEffect, effectID=160077308; Wait,waitTime=7800; "
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    3400,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlayAudio,audioID = 2567,audioType=1; PlayGridRangeEffect,effectID=160077305; Wait,waitTime=600; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
