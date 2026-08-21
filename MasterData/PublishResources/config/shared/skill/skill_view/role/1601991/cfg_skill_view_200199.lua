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
      " Wait,waitTime=100; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =160199104; PlayAudio,audioID = 2633,audioType=1; PlayCasterLineToTarget,lineEffectID=160199105,lineOnCaster=Bip001 Prop1,lineOnTarget=Hit,lineEffectDuration=1600; Wait,waitTime=1850; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    100,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayTargetBeHitEffect,hitEffectID=160199106,label=doAgain; Wait,waitTime=1530; PlayTargetBeHitEffect,hitEffectID=160199107; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1450,
    {
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 160199111,flyTime = 130,flyTrace = 1,isBlock =0,targetPos=Hit; DataSelectNextDamage; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    1700,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
