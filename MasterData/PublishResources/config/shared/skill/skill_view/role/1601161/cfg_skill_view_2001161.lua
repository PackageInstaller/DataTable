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
      " PlayCasterBindEffect,effectID=2574; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 2324,audioType=1; Wait,waitTime=4200; "
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
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayTargetBeHitEffect,hitEffectID=2575,label=doAgain; PlayAudio,audioID = 2325,audioType=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2500; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain2; DataSelectResult,effectType=80,index=1,damageStageIndex=2; PlaySelectedSplashDamage,hitAnimName=Hit,hitEffectID=0,turnToTarget=true,gridEffectID=0,label=splashAgain; DataSelectNextResult,effectType=80,damageStageIndex=2; Jump,condition=CheckEffectResultIndex,param=80,goto=splashAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1000,
    {
      " Play215AndSplashPreDamage,damageStageIndex=3,splashDamageStageIndex=4,damageHitEffect=2575,damageWaitTime=0,hitAnimName=Hit,beHitAudioID=2325,hitEffectWaitTime=2500; "
    }
  }
}
return config, "ID", key
