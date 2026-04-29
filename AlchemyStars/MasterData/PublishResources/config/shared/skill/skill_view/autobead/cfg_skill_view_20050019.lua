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
      " DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID=3234,flyTime=200,flyTrace=1,offsety=1,targetPos=Hit,label=doAgain; PlayAudio,audioID = 2396,audioType=1; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=800; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    200,
    {
      " DataSelectDamage,damageIndex=1; PlayTargetBeHitEffect,hitEffectID=3235,; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3235,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=20011,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
