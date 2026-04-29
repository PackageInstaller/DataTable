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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600141,waitTime = 2000; "
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
      " PlayAudio,audioID = 2498,audioType=1; PlayCameraEffect,effectID=3715; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =3713; PlayCasterBindEffect,effectID =3714; Wait,waitTime=4800; "
    },
    {"5,5", ""}
  },
  {
    3,
    3,
    0,
    2,
    1,
    2000,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2000,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4001595,label=doAgain; PlayTargetAddBuff,buffID=4001597; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
