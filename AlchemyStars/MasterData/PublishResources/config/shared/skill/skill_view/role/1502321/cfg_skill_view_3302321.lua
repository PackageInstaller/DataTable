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
      " DataSelectResult,effectType=85,index=1; PlayCostCasterHP; PlayCasterBindEffect,effectID =150232101; PlayCasterMaterialAnim,animName=effanim_1502321_ult_body_m; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 150232103,audioType=1; Wait,waitTime=4500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1500,
    {
      " DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=150232103,label=playRangeEffect; PlaySummonTrap,trapID=2803501; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1500,
    {
      " DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect1; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect1; "
    }
  }
}
return config, "ID", key
