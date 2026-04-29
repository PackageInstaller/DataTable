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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =160231103; PlayAudio,audioID = 160231102,audioType=1; Wait,waitTime=2900; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1630,
    {
      " DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=160231104,randomDir=1,randomMin=1,randomMax=360,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160231105,deathClear=0; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
