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
    60,
    1,
    0,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 52300111
      }
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayAudio,audioID = 9050,audioType=1; PlayCameraEffect,effectID=52300112; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    300,
    {
      "DataSelectScopeGridRangeByResultIndex,effectType=4,index=1; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=52300113,label=playRangeEffect; Wait,waitTime=33; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500;"
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    300,
    {
      "DataSelectScopeGridRangeByResultIndex,effectType=4,index=2; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=2; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=52300113,label=playRangeEffect; Wait,waitTime=33; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500;"
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    800,
    {
      "DataSelectScopeGridRangeByResultIndex,effectType=4,index=1; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; Wait,waitTime=33; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500;"
    }
  },
  {
    6,
    6,
    0,
    1,
    1,
    800,
    {
      "DataSelectScopeGridRangeByResultIndex,effectType=4,index=2; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=2; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; Wait,waitTime=33; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500;"
    }
  }
}
return config, "ID", key
