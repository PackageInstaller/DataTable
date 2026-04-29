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
      " PlayCasterTurnToTargetGrid; PlayCasterAnimation,animName=Skill2; PlayCasterBindEffect,effectID = 2410; PlayAudio,audioID = 2279; Wait,waitTime=2000; PlayCasterAnimation,animName=Skill3; PlayChangeBuffLayer; PlayDeleteWaringArea; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    500,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
