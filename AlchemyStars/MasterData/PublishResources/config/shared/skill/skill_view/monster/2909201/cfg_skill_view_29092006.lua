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
      " PlayCasterAnimation,animName=Atk03_1; PlayAudio,audioID =290920105,audioType=1; PlayCasterBindEffect,effectID=290920115; Wait,waitTime=800; PlayEntityLineToEntity,trapID=290920101,targetTrapIndex=1,lineOnCaster=Bone034,lineOnTarget=Hit,lineEffectID=290920120,lineEffectDuration=900; Wait,waitTime=2100; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1100,
    {
      "PlayEntityLineToEntity,trapID=290920101,targetTrapIndex=2,lineOnCaster=Bone034,lineOnTarget=Hit,lineEffectID=290920121,lineEffectDuration=900;"
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    950,
    {
      "PlayEntityLineToEntity,trapID=290920101,lineOnCaster=Hit,lineOnTarget=Hit,lineEffectID=290920122,lineEffectDuration=900;"
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    1200,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290920119,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
