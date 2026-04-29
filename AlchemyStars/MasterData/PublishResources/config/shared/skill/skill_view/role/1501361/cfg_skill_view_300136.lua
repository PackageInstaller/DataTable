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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1501361,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2386,audioType=1; PlayCasterBindEffect,effectID = 3243; PlayCameraEffect,effectID = 3245; Wait,waitTime=1200; PlayAddDarkCameraValue,addValue=0.15; Wait,waitTime=100; PlayAddDarkCameraValue,addValue=0.05; Wait,waitTime=100; PlayAddDarkCameraValue,addValue=0.05; Wait,waitTime=100; PlayAddDarkCameraValue,addValue=0.05; Wait,waitTime=1300; PlayAddDarkCameraValue,addValue=-0.05; Wait,waitTime=100; PlayAddDarkCameraValue,addValue=-0.05; Wait,waitTime=100; PlayAddDarkCameraValue,addValue=-0.05; Wait,waitTime=100; PlayClearDarkCameraValue; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2400,
    {
      " DataSelectDamage,damageIndex=1; PlayTargetBeHitEffect,hitEffectID=3244,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3246,turnToTarget=1,deathClear=0; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
