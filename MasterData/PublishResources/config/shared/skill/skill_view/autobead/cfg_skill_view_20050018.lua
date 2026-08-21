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
    2,
    43,
    1,
    0,
    0,
    {audioID = 2444, audioType = 1}
  },
  {
    2,
    3,
    0,
    1,
    1,
    0,
    {
      " DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 3594,flyTrace = 1,offsetx=0,offsety=0,offsetz=0,flyTime=100,isBlock=0,label=doAgain; PlayAudio,audioID = 2396,audioType=1; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=800; "
    }
  },
  {
    3,
    4,
    0,
    1,
    1,
    100,
    {
      " DataSelectDamage,damageIndex=1; PlayTargetBeHitEffect,hitEffectID=3592,; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3592,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
