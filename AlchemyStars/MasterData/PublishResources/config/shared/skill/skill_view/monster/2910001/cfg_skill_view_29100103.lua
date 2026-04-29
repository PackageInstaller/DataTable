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
      " PlayCasterAnimation,animName=skill03; PlayCasterBindEffect,effectID=291000111; PlayCasterBindEffect,effectID=291000113; PlayAudio,audioID=291000103; PlayGridDark,darkType=0; PlayShaderSetGlobalFloat,paramName=H3DDarkLevel,value=0.5,duration=100; Wait,waitTime=4000; PlayGridDark,darkType=1; PlayShaderSetGlobalFloat,paramName=H3DDarkLevel,value=0,duration=100; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; DataSelectDamageInfo,damageInfoIndex = 1; PlayTargetBeHitEffect,hitEffectID=291000112,; Wait,waitTime=350; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1350,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; DataSelectDamageInfo,damageInfoIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=350; "
    }
  }
}
return config, "ID", key
