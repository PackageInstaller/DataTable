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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID = 3266; PlayCasterBindEffect,effectID = 3268; Wait,waitTime=3800; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2395, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    1100,
    {
      " DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 3269,flyTime = 500,flyTrace = 2,offsetx=0.13,offsety=1.13,offsetz=0.74,isBlock=0,label=doAgain; PlayAudio,audioID = 2396,audioType=1; Wait,waitTime=150; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    1450,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3267,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=150; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
