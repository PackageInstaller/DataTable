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
      " Jump,condition=CheckOnAbyss,param=1,goto=phaseEnd; PlayCasterBindEffect,effectID=2795; DataSelectResult,effectType=79,index=1; DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " Jump,condition=CheckOnAbyss,param=0,goto=phaseEnd; PlayCasterBindEffect,effectID=2795; DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4; PlayGridVisible,visible=0; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; "
    }
  }
}
return config, "ID", key
