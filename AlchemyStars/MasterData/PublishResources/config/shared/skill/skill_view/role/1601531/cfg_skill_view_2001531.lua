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
      " PlayAudio,audioID = 2461,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=160153101; PlayCasterBindEffect,effectID=160153102; Wait,waitTime=1000; PlayShaderSetGlobalFloat,paramName=H3DDarkLevel,value=0.5,duration=200; Wait,waitTime=950; PlayCameraEffect,effectID=160153105; Wait,waitTime=1500; PlayModifyTimeScale,type=0; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1000,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayTargetBeHitEffect,hitEffectID=160153103,hitEffectIDBodyAreaMoreThanOne=160153104,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2400,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    2400,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    2300,
    {
      " PlayShaderSetGlobalFloat,paramName=H3DDarkLevel,value=0,duration=1200; "
    }
  }
}
return config, "ID", key
