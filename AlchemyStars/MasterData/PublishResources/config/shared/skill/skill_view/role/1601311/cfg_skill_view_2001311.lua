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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2371,audioType=1; PlayCasterBindEffect,effectID =3190; PlayCasterBindEffect,effectID =3191; Wait,waitTime=900; PlaySkillAttackRange,showTime=600,isEffectRange=0; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1150,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3192,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1350; PlayAddHpText; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
