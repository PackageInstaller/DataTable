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
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterBindEffect,effectID=501; PlayCasterAnimation,animName=AtkUlt; "
    }
  },
  {
    2,
    3,
    43,
    1,
    1,
    66,
    {audioID = 3041, audioType = 1}
  },
  {
    3,
    4,
    0,
    1,
    1,
    900,
    {
      " DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 1055,flyTime = 150,flyTrace = 1,originalBoneName= Bone070,targetPos= EffectSlot; Wait,waitTime=150; PlayEffectAtTargetPos,effectID=503; Wait,waitTime=1150; PlayEffectAtTargetPos,effectID=50301; Wait,waitTime=100; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=50300,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
