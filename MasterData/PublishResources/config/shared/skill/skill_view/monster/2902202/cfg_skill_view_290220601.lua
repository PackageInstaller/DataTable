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
      " PlayCasterAnimation,animName=Skill01_L; PlayAudio,audioID=6264,audioType=1; PlayCasterBindEffect,effectID=290220215; Wait,waitTime=530; PlayCasterBindEffect,effectID=290220216; Wait,waitTime=300; DataSelectDamage,damageIndex=1,damageInfoIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290220213,turnToTarget=1,deathClear=0,label=doAgain; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    200,
    {
      " PlayCasterAnimation,animName=Skill01_LtoR; PlayAudio,audioID=6264,audioType=1; Wait,waitTime=530; DataSelectDamage,damageIndex=1,damageInfoIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290220214,turnToTarget=1,deathClear=0,label=doAgain; "
    }
  }
}
return config, "ID", key
