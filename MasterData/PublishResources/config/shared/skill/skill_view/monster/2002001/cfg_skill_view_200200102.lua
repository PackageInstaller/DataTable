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
      " PlayCasterAnimation,animName = skill01; Wait,waitTime=700; PlayFlyEffectCasterToTarget,flyEffectID=200200101,flyTrace=1,flySpeed = 300,offsety=0.4,targetPos=Hit,isBlock=0; Wait,waitTime=500; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1400,
    {
      " DataSelectResult,effectType=80,index=1; PlaySplashDamage,hitAnimName=Hit,hitEffectID=0,turnToTarget=true,gridEffectID=200200102,label=splashAgain; DataSelectNextResult,effectType=80; Jump,condition=CheckEffectResultIndex,param=80,goto=splashAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200200103,turnToTarget=1,deathClear=0; Wait,waitTime=500; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=20021,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
