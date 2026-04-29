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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2573,audioType=1; PlayCasterBindEffect,effectID =160178108; Wait,waitTime=2000; "
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
      " DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=result2; PlayTargetBeHitEffect,hitEffectID=160178105; DataSelectDamage,damageIndex = 2,label=result2; Jump,condition=CheckDamageIndexValid,result=0,goto=result3; PlayTargetBeHitEffect,hitEffectID=160178106; DataSelectDamage,damageIndex = 3,label=result3; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayTargetBeHitEffect,hitEffectID=160178107,label=doAgain3; "
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
      " DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=result2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,deathClear=0; DataSelectDamage,damageIndex = 2,label=result2; Jump,condition=CheckDamageIndexValid,result=0,goto=result3; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,deathClear=0; DataSelectDamage,damageIndex = 3,label=result3; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,deathClear=0,label=doAgain3; "
    }
  }
}
return config, "ID", key
