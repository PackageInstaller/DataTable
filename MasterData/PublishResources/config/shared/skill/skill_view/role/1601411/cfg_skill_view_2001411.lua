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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =3288; PlayAudio,audioID = 2405,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " Jump,condition=CheckDamageSkillResultTargetCount,param=2|1,goto=phaseEnd; DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=3290; Jump,condition=CheckDamageIndexValid; Wait,waitTime=1300; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3291,turnToTarget=1,deathClear=0; PlayAudio,audioID = 2406,audioType=1; Wait,waitTime=300; DataSelectNextDamage; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3292,turnToTarget=1,deathClear=0; PlayAudio,audioID = 2406,audioType=1; Wait,waitTime=1000; PlayModifyTimeScale,type=0; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " Jump,condition=CheckDamageSkillResultTargetCount,param=2|2,goto=phaseEnd; DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=3289,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1300; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3291,turnToTarget=1,deathClear=0,label=hitAgain; PlayAudio,audioID = 2406,audioType=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=hitAgain; Wait,waitTime=1000; PlayModifyTimeScale,type=0; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2500,
    {
      " PlayModifyTimeScale,type=0; "
    }
  }
}
return config, "ID", key
