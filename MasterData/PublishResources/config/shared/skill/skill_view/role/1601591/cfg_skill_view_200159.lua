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
      " PlayAudio,audioID = 2497,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=3710; PlayCasterBindEffect,effectID=3711; Wait,waitTime=3700;"
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
      " PlaySkillAttackRange,showTime=1000,isEffectRange=0; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1700,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex = 1; DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=3712,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1;DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    1850,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex = 2; DataSelectScopeGridRange,effectType=1,damageInfoIndex=2; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=3712,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,damageStageIndex = 2; Wait,waitTime=150; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    1700,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4001593,label=doAgain; PlayTargetAddBuff,buffID=4001595; PlayTargetAddBuff,buffID=4001592; PlayTargetAddBuff,buffID=4001594; PlayTargetAddBuff,buffID=4001596; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
