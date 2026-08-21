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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2643,audioType=1; PlayCasterBindEffect,effectID = 150203102; Wait,waitTime = 4000; "
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
      "DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=150203103,label=hitAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=hitAgain; "
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
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
