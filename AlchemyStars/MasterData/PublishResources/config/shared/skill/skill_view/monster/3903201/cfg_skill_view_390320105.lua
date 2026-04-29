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
      " PlayCasterLegacyAnimation,animNames=eff_390320101_death; Wait,waitTime=100; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; Wait,waitTime=100; DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=58; "
    }
  }
}
return config, "ID", key
