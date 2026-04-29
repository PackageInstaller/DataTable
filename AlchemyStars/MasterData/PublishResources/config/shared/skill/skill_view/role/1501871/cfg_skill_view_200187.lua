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
      " PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 150187102,audioType=1; Wait,waitTime=200; PlayCasterBindEffect,effectID=150187104; Wait,waitTime=3000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1600,
    {
      " DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=150187103,label=doAgain; Wait,waitTime=30; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2700; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1600,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=30; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
