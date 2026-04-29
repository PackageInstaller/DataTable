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
      " PlayCasterBindEffect,effectID=2340; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 2236,audioType=1; Wait,waitTime = 800; PlaySkillAttackRange,showTime=600,isEffectRange=0; Wait,waitTime = 3000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1500,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2341,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
