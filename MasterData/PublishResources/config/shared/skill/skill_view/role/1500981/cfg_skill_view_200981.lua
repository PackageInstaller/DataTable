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
      " PlayCasterBindEffect,effectID=2263; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 2256,audioType=1; Wait,waitTime=1350; Wait,waitTime=1650; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1350,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2262,turnToTarget=1,deathClear=0,label=doAgain; PlayTargetAddBuff,buffID=410098; Wait,waitTime=60; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
