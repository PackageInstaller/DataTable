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
      " PlayCasterAnimation,animName = skill01; PlayAudio,audioID = 7038,audioType=1; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200200103,turnToTarget=1,deathClear=0,label=doDamageAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doDamageAgain; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    700,
    {
      " PlayAudio,audioID = 7039,audioType=1; PlaySplashDamageAndAddBuff,flyEffectID=200200101,flyTotalTime=300,flyEffectHeight=0.4,gridEffectDelayTime=200,gridEffectID=200200102,hitDelayTime=300,hitAnimName=Hit,hitEffectID=200200103,turnToTarget=1,deathClear=0,buffID=20021,buffEffectType=2002; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=20021,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
