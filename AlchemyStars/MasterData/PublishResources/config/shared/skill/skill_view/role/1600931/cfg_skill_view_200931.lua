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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =2308; PlayCasterBindEffect,effectID =2346; PlayAudio,audioID = 2284,audioType=1; Wait,waitTime=2900; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1000,
    {
      " DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=2309,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1666,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    1000,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2318,turnToTarget=1,label=doAgain; PlayAudio,audioID = 2288,audioType=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    0,
    2,
    4,
    1000,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=3; Jump,condition=CheckDamageIndexValid,result=0,goto=phase3End; PlayTargetBeHitEffect,hitEffectID=2319,label=zhanshatexiao; PlayAudio,audioID = 2287,audioType=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=zhanshatexiao; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1,damageStageIndex=3; Jump,condition=CheckDamageIndexValid,result=0,goto=phase3End; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=demage3; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=demage3; Wait,waitTime=33,label=phase3End; "
    }
  }
}
return config, "ID", key
