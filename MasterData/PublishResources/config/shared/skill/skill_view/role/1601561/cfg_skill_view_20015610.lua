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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2475,audioType=1; PlayCasterBindEffect,effectID=3670; Wait,waitTime = 250; DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=3671,randomDir=1,randomMin=0,randomMax=360,label=hitAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=hitAgain; Wait,waitTime = 2100; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1250,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
