local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7
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
      " PlayMoveBoard,dirX=1,dirY=0,times=2; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1000,
    {
      " DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2000,
    {
      " DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
