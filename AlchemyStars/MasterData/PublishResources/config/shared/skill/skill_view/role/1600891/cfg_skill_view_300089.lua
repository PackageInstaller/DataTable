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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600891,waitTime = 2000; "
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
      " PlayCasterBindEffect,effectID =1668; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 3116,audioType=1; "
    }
  },
  {
    3,
    3,
    60,
    2,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 1667
      }
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2730,
    {
      " DataSelectScopeGridRange,effectType=6; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=1666,label=playRangeEffect; Wait,waitTime=100; PlayGridRangeConvert,dataSource=6; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    5,
    5,
    23,
    2,
    4,
    0,
    {showTime = 0}
  }
}
return config, "ID", key
