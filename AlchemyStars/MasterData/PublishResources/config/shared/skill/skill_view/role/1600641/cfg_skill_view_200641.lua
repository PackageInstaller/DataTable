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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =1790; PlayAudio,audioID = 2213; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1500,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1791,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=200; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2000; "
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
      " DataSelectResult,effectType=80,index=1; PlaySplashDamage,hitAnimName=Hit,hitEffectID=0,turnToTarget=true,gridEffectID=1791,label=splashAgain; DataSelectNextResult,effectType=80; Jump,condition=CheckEffectResultIndex,param=80,goto=splashAgain; "
    }
  },
  {
    4,
    4,
    0,
    1,
    3,
    1000,
    {
      "PlayAudio,audioID = 7003;"
    }
  }
}
return config, "ID", key
