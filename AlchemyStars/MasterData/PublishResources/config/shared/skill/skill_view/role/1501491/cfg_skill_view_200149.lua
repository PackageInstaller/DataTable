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
      " PlayCasterAnimation,animName = AtkChain; Wait,waitTime=450; PlayCasterBindEffect,effectID = 3488; Wait,waitTime=3800; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2444, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    500,
    {
      " DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 3490,flyTrace = 2,offsetx=0,offsety=0.3,offsetz=0,flyTime=230,isBlock=0,label=doAgain; PlayAudio,audioID = 2396,audioType=1; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    730,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3489,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
