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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1600291,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=440; PlayAudio,audioID = 3039,audioType=1; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    500,
    {
      "DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=441,label=playRangeEffect; Wait,waitTime=50; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2900,
    {
      "DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=442,label=playRangeEffect; Wait,waitTime=50; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    3200,
    {
      "DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,label=playRangeEffect; Wait,waitTime=50; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  }
}
return config, "ID", key
