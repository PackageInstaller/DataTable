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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =150176103; PlayCasterBindEffect,effectID =150176104; PlayCasterBindEffect,effectID =150176105; PlayAudio,audioID = 2558,audioType=1; Wait,waitTime=3300; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    660,
    {
      " DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=150176106,randomDir=1,randomMin=0,randomMax=180,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2200,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
