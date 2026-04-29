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
      " PlayCasterAnimation,animName = AtkChain1; PlayCasterBindEffect,effectID =3232; PlayAudio,audioID = 2388; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1200,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterTurnToTarget,label=doAgain; PlayFlyEffectCasterToTarget,flyEffectID=3234,flyTime=200,flyTrace=1,offsety=1,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3235,turnToTarget=1,deathClear=0; PlayCasterBindEffect,effectID =3233; PlayAudio,audioID = 2389; Wait,waitTime=100; PlayCasterAnimation,animName = AtkChain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlayCasterAnimation,animName = AtkChain3; Wait,waitTime=2000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1450,
    {
      " DataSelectResult,effectType=80,index=1,damageStageIndex=2; PlaySelectedSplashDamage,hitAnimName=Hit,hitEffectID=0,turnToTarget=true,gridEffectID=-1,label=splashAgain; DataSelectNextResult,effectType=80,damageStageIndex=2; Wait,waitTime=380; Jump,condition=CheckEffectResultIndex,param=80,goto=splashAgain; "
    }
  }
}
return config, "ID", key
