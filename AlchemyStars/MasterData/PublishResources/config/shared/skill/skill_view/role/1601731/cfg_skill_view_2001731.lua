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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2544,audioType=1; PlayCasterBindEffect,effectID = 160173102; Wait,waitTime = 1100; PlayCasterBindEffect,effectID = 160173103; Wait,waitTime = 250; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " DataSelectDamage,damageIndex = 1; PlayCasterTurnToTarget; Wait,waitTime=1100; DataSelectNextDamage; PlayCasterTurnToTarget; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1000,
    {
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 160173104,flyTime = 150,flyTrace = 1,isBlock =0,offsetx=0.114,offsety=1.004,offsetz=0.778,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160173105,turnToTarget=1,deathClear=0; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    1150,
    {
      " DataSelectDamage,damageIndex = 2; PlayFlyEffectCasterToTarget,flyEffectID = 160173104,flyTime = 150,flyTrace = 1,isBlock =0,offsetx=0.114,offsety=1.004,offsetz=0.778,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160173105,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
