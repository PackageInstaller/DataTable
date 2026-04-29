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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=3694; PlayCasterBindEffect,effectID=3695; PlayCasterBindEffect,effectID=3696; PlayCameraEffect,effectID=3697; PlayAudio,audioID = 2480,audioType=1; Wait,waitTime=1000; PlaySkillAttackRange,showTime=600,isEffectRange=0; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1700,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3698,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1200; "
    }
  }
}
return config, "ID", key
