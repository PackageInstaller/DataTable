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
      " PlayCasterAnimation,animName = Death; PlayAudio,audioID = 5076,audioType=1; "
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
      " DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " PlayCasterBindEffect,effectID=3277; PlayCasterMaterialAnim,animName=eff_2800531_death_main01; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    500,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
