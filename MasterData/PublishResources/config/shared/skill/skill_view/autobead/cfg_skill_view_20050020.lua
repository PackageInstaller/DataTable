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
    43,
    1,
    0,
    0,
    {audioID = 2444, audioType = 1}
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 160167107,flyTime = 150,flyTrace = 1,isBlock =0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=800; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    150,
    {
      " DataSelectDamage,damageIndex=1; PlayTargetBeHitEffect,hitEffectID=160167106,; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160167106,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
