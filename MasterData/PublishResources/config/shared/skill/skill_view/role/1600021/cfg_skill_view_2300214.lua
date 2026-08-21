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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID = 160002403; Wait,waitTime = 800; PlaySkillAttackRange,showTime=600,isEffectRange=0; Wait,waitTime = 800; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160002404,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime = 1500; "
    },
    {"", "1,0"}
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 160002403, audioType = 1}
  }
}
return config, "ID", key
