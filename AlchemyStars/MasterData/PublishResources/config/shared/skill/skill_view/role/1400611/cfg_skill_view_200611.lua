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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =1099; PlayAudio,audioID = 3020; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    800,
    {
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 1100,flySpeed = 66,flyTrace = 1,offsety = 0.5,isBlock = 0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=166; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1101,turnToTarget=1,deathClear=0,label=doAgain1; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
