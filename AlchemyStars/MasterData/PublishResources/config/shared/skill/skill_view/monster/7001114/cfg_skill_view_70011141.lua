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
      " DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4; "
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
      "PlayCasterLegacyAnimation,animNames=eff_2909101_skill_out; PlaySummonTrap,trapID=2803501; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
