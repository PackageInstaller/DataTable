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
      " PlayCasterTurnToPlayer; PlayCasterAnimation,animName = skill3; PlayCasterBindEffect,effectID=291020108; PlayAudio,audioID = 29102014; "
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
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 291020109,flyTime = 100,flyTrace = 1,offsetx = -1.5,offsety = 0.85,offsetz = -0.5,isBlock = 0,finalWaitTime=500,targetPos=Hit,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=300; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayFlyEffectCasterToTarget,flyEffectID = 291020109,flyTime = 100,flyTrace = 1,offsetx = 1.5,offsety = 0.85,offsetz = -0.5,isBlock = 0,finalWaitTime=300,targetPos=Hit,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=250; DataSelectDamage,damageIndex = 1,damageStageIndex=3; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayFlyEffectCasterToTarget,flyEffectID = 291020109,flyTime = 100,flyTrace = 1,offsety =1.65,offsetz = -1.07,isBlock = 0,finalWaitTime=500,targetPos=Hit,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1100,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=291020110,turnToTarget=1,deathClear=0,hitBackUseDamagePos=1,damageStageIndex=1; Wait,waitTime=300; DataSelectDamage,damageIndex = 1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=291020110,turnToTarget=1,deathClear=0,hitBackUseDamagePos=1,damageStageIndex=2; Wait,waitTime=250; DataSelectDamage,damageIndex = 1,damageStageIndex=3; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=291020111,turnToTarget=1,deathClear=0,hitBackUseDamagePos=1,damageStageIndex=3; "
    }
  }
}
return config, "ID", key
