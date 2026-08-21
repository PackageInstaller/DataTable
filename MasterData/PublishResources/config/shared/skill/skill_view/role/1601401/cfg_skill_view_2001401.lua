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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2402,audioType=1; PlayCasterBindEffect,effectID = 3338; PlayCasterBindEffect,effectID = 3339; Wait,waitTime = 1300; PlaySkillAttackRange,showTime=600,isEffectRange=0; Wait,waitTime = 1400; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1600,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
