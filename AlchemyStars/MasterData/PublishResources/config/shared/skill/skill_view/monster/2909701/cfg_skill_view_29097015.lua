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
    0,
    0,
    0,
    {
      " PlayDeleteWaringArea; PlayCasterAnimation,animName=Skill_3; PlayCasterBindEffect,effectID = 290970103; Wait,waitTime=300; PlayAudio,audioID = 29097014,audioType=1; Wait,waitTime=300; DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitBackUseDamagePos=1,hitEffectID=290970104,turnToTarget=1,deathClear=0; Wait,waitTime=300; DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitBackUseDamagePos=1,hitEffectID=290970104,turnToTarget=1,deathClear=0; Wait,waitTime=300; DataSelectDamage,damageIndex=1,damageStageIndex=3; PlayCommonBeHit,hitAnimName=Hit,hitBackUseDamagePos=1,hitEffectID=290970104,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
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
      " PlayCasterAnimation,animName=Skill_1; PlayCasterBindEffect,effectID = 290970108; Wait,waitTime=400; PlayAudio,audioID = 29097012,audioType=1; Wait,waitTime=400; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=29097013; "
    }
  },
  {
    3,
    3,
    29,
    2,
    2,
    0,
    {
      warningCenterPosType = 4,
      warningTextEffectID = 339,
      areaRes = ""
    }
  }
}
return config, "ID", key
