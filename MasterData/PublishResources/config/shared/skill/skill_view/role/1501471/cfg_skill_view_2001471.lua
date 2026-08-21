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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID = 3458; PlayCasterBindEffect,effectID = 3459; PlayAudio,audioID = 2422,audioType=1; Wait,waitTime=3800; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2460,
    {
      " DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 3460,flyTime = 500,jumpPower= 3,flyTrace = 2,offsetx=-0.25,offsety=0.085,offsetz=0.1,isBlock=0 Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3461,turnToTarget=1,deathClear=0; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2560,
    {
      " DataSelectDamage,damageIndex=2; PlayFlyEffectCasterToTarget,flyEffectID = 3460,flyTime = 500,jumpPower= 3,flyTrace = 2,offsetx=-0.25,offsety=0.085,offsetz=0.1,isBlock=0; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3461,turnToTarget=1,deathClear=0; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    2660,
    {
      " DataSelectDamage,damageIndex=3; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayFlyEffectCasterToTarget,flyEffectID = 3460,flyTime = 500,jumpPower= 3,flyTrace = 2,offsetx=-0.25,offsety=0.085,offsetz=0.1,isBlock=0; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3461,turnToTarget=1,deathClear=0; "
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    2760,
    {
      " DataSelectDamage,damageIndex=4; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayFlyEffectCasterToTarget,flyEffectID = 3460,flyTime = 500,jumpPower= 3,flyTrace = 2,offsetx=-0.25,offsety=0.085,offsetz=0.1,isBlock=0; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3461,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
