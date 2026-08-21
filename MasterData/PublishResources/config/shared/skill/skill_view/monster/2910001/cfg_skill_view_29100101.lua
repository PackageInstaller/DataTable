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
      " PlayCasterAnimation,animName=skill01; PlayAudio,audioID=291000101; PlayCasterBindEffect,effectID=291000101; PlayCasterBindEffect,effectID=291000102; Wait,waitTime=1000; PlayCasterBindEffect,effectID=291000103; Wait,waitTime=2500; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1250,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; DataSelectDamageInfo,damageInfoIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
