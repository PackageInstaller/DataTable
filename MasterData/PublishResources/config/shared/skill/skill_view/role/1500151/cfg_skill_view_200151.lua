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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =3145; PlayAudio,audioID = 2366,audioType=1; Wait,waitTime=5000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1800,
    {
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 3146,flyTime = 50 ,offsetx=-0.816,offsety=0.856,offsetz=-3.56,flyTrace = 1,isBlock = 1,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3147,turnToTarget=1; DataSelectDamage,damageIndex = 2; PlayFlyEffectFromLastTargetToTarget,flyEffectID = 3146,flyTime = 50,flyTrace = 1,isBlock = 1,originalBoneName=Hit,targetPos=Hit,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3147,turnToTarget=1; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
