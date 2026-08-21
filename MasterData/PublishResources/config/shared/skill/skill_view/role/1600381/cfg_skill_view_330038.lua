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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600381,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    2,
    2,
    1,
    0,
    {
      effectparam = "40700",
      castAnimationName = "AtkUlt",
      finishDelayTime = 800,
      buffDelayTime = 0
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
        effectID = 1056
      }
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    0,
    {
      " PlayAudio,audioID =3040,audioType=1;"
    }
  },
  {
    5,
    5,
    0,
    1,
    2,
    2000,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4; PlayGridRangeEffect,effectID=408; Wait,waitTime=300; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4; PlayGridRangeEffect,effectID=408; Wait,waitTime=600; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlayGridRangeEffect,effectID=408; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    6,
    6,
    0,
    2,
    5,
    0,
    {
      " Wait,waitTime=2000;"
    }
  }
}
return config, "ID", key
