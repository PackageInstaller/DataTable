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
    2,
    1,
    0,
    0,
    {
      effectparam = "407",
      castAnimationName = "AtkUlt",
      finishDelayTime = 800,
      buffDelayTime = 0
    }
  },
  {
    2,
    2,
    60,
    1,
    0,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 1056
      }
    }
  },
  {
    3,
    3,
    0,
    1,
    0,
    0,
    {
      " PlayAudio,audioID =3040,audioType=1;"
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    2000,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4; PlayGridRangeEffect,effectID=408; Wait,waitTime=300; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4; PlayGridRangeEffect,effectID=408; Wait,waitTime=600; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlayGridRangeEffect,effectID=408; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    5,
    5,
    0,
    2,
    4,
    0,
    {
      " Wait,waitTime=2000;"
    }
  }
}
return config, "ID", key
