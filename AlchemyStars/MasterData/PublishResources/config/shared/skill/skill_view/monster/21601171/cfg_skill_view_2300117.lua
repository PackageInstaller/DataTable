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
    2,
    0,
    0,
    {
      " PlayAudio,audioID = 2330,audioType=1;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=2913; PlayCasterBindEffect,effectID=2914; Wait,waitTime=800; "
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    2800,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phase2; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect1; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect1; DataSelectScopeGridRange,effectType=1,damageInfoIndex=2,label=phase2; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=2,label=playRangeEffect2; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect2; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffEffectType=430117,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " PlayModifyTimeScale,type=0; "
    }
  }
}
return config, "ID", key
