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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601451,waitTime = 2000;"
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
      " PlayAudio,audioID = 160231103,audioType=1; PlayCasterAnimation,animName=AtkUlt; PlayCasterBindEffect,effectID=160231106; Wait,waitTime=3500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1700,
    {
      " DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160231108,randomRotateList=0|90|180|270,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=doAgain; PlayTargetAddBuff,buffID=10021; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2900,
    {
      " DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlaySummonTrap,trapID=2803501,label=playRangeEffect; PlayGridRangeConvert,dataSource=4; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
