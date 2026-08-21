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
      " PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID =1537; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2034, audioType = 1}
  },
  {
    3,
    3,
    0,
    2,
    1,
    369,
    {
      " DataSelectDamageInfo,damageInfoIndex = 1; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 1538,flySpeed = 100,flyTrace = 3,isBlock = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1539,turnToTarget=1,deathClear=0; Wait,waitTime=200; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1539,turnToTarget=1,deathClear=0;Wait,waitTime=966; "
    }
  }
}
return config, "ID", key
