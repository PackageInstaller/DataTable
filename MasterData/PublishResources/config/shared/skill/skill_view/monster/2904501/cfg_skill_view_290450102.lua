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
      " PlayCasterTurnToTargetGrid; PlayCasterAnimation,animName=Skill2; PlayCasterBindEffect,effectID = 2461; PlayAudio,audioID = 2276; PlayChangeBuffLayer; PlayDeleteWaringArea; Wait,waitTime=5333; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    3300,
    {
      " PlayEffectOffsetScopeCenter,effectID=2462,offset=0|0; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    4300,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
