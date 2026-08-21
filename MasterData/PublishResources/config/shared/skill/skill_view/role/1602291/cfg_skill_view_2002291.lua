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
local common = {
  {"", "1,0"}
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
      " PlayAudio,audioID = 160229102,audioType=1; PlayCasterTurnToTarget; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =160229108; Wait,waitTime=3000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    933,
    {
      " Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 160229109,flyTime = 500,flyTrace = 1,isBlock = 0,beginFlyWaitTime=100,offsetWithRotate=1; Wait,waitTime=500; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160229110,turnToTarget=0,deathClear=0; "
    },
    common[1]
  },
  {
    3,
    3,
    0,
    1,
    1,
    933,
    {
      " Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; DataSelectDamage,damageIndex = 2; PlayFlyEffectCasterToTarget,flyEffectID = 160229109,flyTime = 500,flyTrace = 1,isBlock = 0,beginFlyWaitTime=100,offsetWithRotate=1; Wait,waitTime=500; DataSelectDamage,damageIndex = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160229110,turnToTarget=0,deathClear=0; "
    },
    common[1]
  },
  {
    4,
    4,
    0,
    1,
    1,
    933,
    {
      " Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; DataSelectDamage,damageIndex =3; PlayFlyEffectCasterToTarget,flyEffectID = 160229109,flyTime = 500,flyTrace = 1,isBlock = 0,beginFlyWaitTime=100,offsetWithRotate=1; Wait,waitTime=500; DataSelectDamage,damageIndex = 3; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160229110,turnToTarget=0,deathClear=0; "
    },
    common[1]
  },
  {
    5,
    5,
    0,
    1,
    1,
    933,
    {
      " Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; DataSelectDamage,damageIndex = 4; PlayFlyEffectCasterToTarget,flyEffectID = 160229109,flyTime = 500,flyTrace = 1,isBlock = 0,beginFlyWaitTime=100,offsetWithRotate=1; Wait,waitTime=500; DataSelectDamage,damageIndex = 4; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160229110,turnToTarget=0,deathClear=0; "
    },
    common[1]
  }
}
return config, "ID", key
