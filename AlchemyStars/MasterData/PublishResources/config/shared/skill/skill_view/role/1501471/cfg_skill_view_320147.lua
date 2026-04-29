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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 16001051,waitTime = 2000; "
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
      " PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 2423,audioType=1; PlayCameraEffect,effectID=3464; Wait,waitTime=3700; PlayCasterBindEffect,effectID=3463; Wait,waitTime=1500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayTargetBeHitEffect,hitEffectID=3462; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1300,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=33; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=33; DataSelectDamage,damageIndex = 1,damageStageIndex=3; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=33; DataSelectDamage,damageIndex = 1,damageStageIndex=4; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=33; DataSelectDamage,damageIndex = 1,damageStageIndex=5; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=33; DataSelectDamage,damageIndex = 1,damageStageIndex=6; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=33; DataSelectDamage,damageIndex = 1,damageStageIndex=7; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=33; DataSelectDamage,damageIndex = 1,damageStageIndex=8; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2900,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=9; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain2; "
    }
  }
}
return config, "ID", key
