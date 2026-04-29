local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID =160238102,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =160238102; Wait,waitTime = 3000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1000,
    {
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 160238103,flyTime = 160 ,offsetx=0,offsety=0.5,offsetz=0,flyTrace = 1,isBlock = 0,targetPos=Hit; Wait,waitTime=150; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160238104,turnToTarget=1; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1500,
    {
      " DataSelectDamage,damageIndex = 2; PlayFlyEffectFromLastTargetToTarget,flyEffectID = 160238103,flyTime =160,flyTrace = 1,isBlock = 0,originalBoneName=Hit,targetPos=Hit,label=doAgain; Wait,waitTime=150; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160238104,turnToTarget=1; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
