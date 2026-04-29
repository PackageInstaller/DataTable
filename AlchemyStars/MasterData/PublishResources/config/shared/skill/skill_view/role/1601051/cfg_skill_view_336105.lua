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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=2504; PlayAudio,audioID = 2298,audioType=1; Wait,waitTime=1300; "
    }
  },
  {
    3,
    3,
    51,
    2,
    1,
    1300,
    {audioID = 2299}
  },
  {
    4,
    4,
    0,
    2,
    1,
    1300,
    {
      " PlayHighFrequencyDamageAndTraction,damageFxID=2505,hitAnimName=Hit,eachDamageTime=50; "
    }
  },
  {
    5,
    5,
    51,
    2,
    4,
    250,
    {audioID = 2299, isPlay = false}
  },
  {
    6,
    6,
    0,
    2,
    4,
    0,
    {
      " PlayEntityLegacyAnimation,animNames=eff_1601052_atkult_main_end,casterEffectID=2504; PlayCasterBindEffect,effectID=2497; PlayCameraEffect,effectID=2498; Wait,waitTime=560; PlayCasterAnimation,animName = AtkUlt1; DataSelectBuff,buffIndex=1,damageStageIndex=1; PlayTargetAddBuff,buffID=43001051,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=250; PlayAudio,audioID = 229900,audioType=1; Wait,waitTime=5000; "
    }
  },
  {
    7,
    7,
    0,
    2,
    6,
    500,
    {
      " PlayDeleteCasterEffect,effectIDList=2504; "
    }
  }
}
return config, "ID", key
