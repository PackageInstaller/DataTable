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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1300801,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1717; PlayAudio,audioID = 3052,audioType=1; Wait,waitTime=3000; DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=1718,label=playRangeEffect; Wait,waitTime=2000; PlaySummonTrap,trapID=800001; PlaySummonTrap,trapID=800002; PlaySummonTrap,trapID=800003; PlaySummonTrap,trapID=800004; PlaySummonTrap,trapID=800005; PlaySummonTrap,trapID=14; PlayTargetAddBuff,buffID=400080; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    3000,
    {
      " DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playConvert; PlayGridRangeEffect,effectID=480; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playConvert; "
    }
  }
}
return config, "ID", key
