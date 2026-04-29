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
      " PlayCasterBindEffect,effectID=3397; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 2413,audioType=1; PlayCameraEffect,effectID=3398; Wait,waitTime=4000; "
    },
    {"", "1,-1"}
  },
  {
    2,
    2,
    0,
    1,
    1,
    700,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayTargetBeHitEffect,hitEffectID=3399,label=doAgain; Wait,waitTime=150; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2100,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=150; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
