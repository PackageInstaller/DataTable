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
      " PlayCasterTurnToTargetGrid; PlayCasterAnimation,animName = Skill01; PlayCasterBindEffect,effectID =200380101; PlayAudio,audioID = 5081,audioType=1; Wait,waitTime=1100; PlayCasterBindEffect,effectID =200380104; Wait,waitTime=500; "
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
      " DataSelectDamage,damageIndex=1,damageStageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayTargetBeHitEffect,hitEffectID=200380102,label=doAgain; Wait,waitTime=1100; PlayTargetBeHitEffect,hitEffectID=200380103; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    600,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; DataSelectDamageInfo,damageInfoIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=350; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
