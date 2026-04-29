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
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3,sortParam=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayAudio,audioID=8009,audioType=1; PlayGridRangeEffect,effectID=3473; Wait,waitTime=150; PlayGridRangeEffect,effectID=3474,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=1; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
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
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=2; DataSortScopeGridRange,sortType=3,sortParam=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; Wait,waitTime=400; PlayAudio,audioID=8009,audioType=1; PlayGridRangeEffect,effectID=3473; Wait,waitTime=150; PlayGridRangeEffect,effectID=3474,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=2; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=3; DataSortScopeGridRange,sortType=3,sortParam=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; Wait,waitTime=800; PlayAudio,audioID=8009,audioType=1; PlayGridRangeEffect,effectID=3473; Wait,waitTime=150; PlayGridRangeEffect,effectID=3474,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=3; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    0,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=4; DataSortScopeGridRange,sortType=3,sortParam=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; Wait,waitTime=1200; PlayAudio,audioID=8009,audioType=1; PlayGridRangeEffect,effectID=3473; Wait,waitTime=150; PlayGridRangeEffect,effectID=3474,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=4; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    0,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=5; DataSortScopeGridRange,sortType=3,sortParam=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; Wait,waitTime=1600; PlayAudio,audioID=8009,audioType=1; PlayGridRangeEffect,effectID=3473; Wait,waitTime=150; PlayGridRangeEffect,effectID=3474,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=5; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    0,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=6; DataSortScopeGridRange,sortType=3,sortParam=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; Wait,waitTime=2000; PlayAudio,audioID=8009,audioType=1; PlayGridRangeEffect,effectID=3473; Wait,waitTime=150; PlayGridRangeEffect,effectID=3474,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=6; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    7,
    7,
    0,
    2,
    1,
    0,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=7; DataSortScopeGridRange,sortType=3,sortParam=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; Wait,waitTime=2400; PlayAudio,audioID=8009,audioType=1; PlayGridRangeEffect,effectID=3473; Wait,waitTime=150; PlayGridRangeEffect,effectID=3474,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=7; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    8,
    8,
    0,
    2,
    1,
    0,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=8; DataSortScopeGridRange,sortType=3,sortParam=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; Wait,waitTime=2800; PlayAudio,audioID=8009,audioType=1; PlayGridRangeEffect,effectID=3473; Wait,waitTime=150; PlayGridRangeEffect,effectID=3474,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=8; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    9,
    9,
    0,
    2,
    1,
    0,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=9; DataSortScopeGridRange,sortType=3,sortParam=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; Wait,waitTime=3200; PlayAudio,audioID=8009,audioType=1; PlayGridRangeEffect,effectID=3473; Wait,waitTime=150; PlayGridRangeEffect,effectID=3474,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=9; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
