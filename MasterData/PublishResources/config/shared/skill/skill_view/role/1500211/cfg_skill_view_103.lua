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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1500211,waitTime = 2000;"
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
      "PlayAudio,audioID = 2148,audioType=1;"
    }
  },
  {
    3,
    3,
    2,
    2,
    1,
    0,
    {
      effectparam = "333,33300",
      castAnimationName = "AtkUlt",
      finishDelayTime = 4300,
      buffDelayTime = 0
    },
    {"", "0,-1"}
  },
  {
    4,
    4,
    62,
    2,
    1,
    0,
    {darkType = 0}
  },
  {
    5,
    5,
    0,
    2,
    1,
    2300,
    {
      "DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,label=playRangeEffect; PlayGridRangeEffect,effectID=334; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  }
}
return config, "ID", key
