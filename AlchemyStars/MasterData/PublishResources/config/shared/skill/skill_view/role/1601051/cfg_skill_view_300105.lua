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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=2494; PlayAudio,audioID = 2298,audioType=1; "
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
      " PlayHighFrequencyDamageAndTraction,damageFxID=2495,hitAnimName=Hit,eachDamageTime=50; "
    }
  },
  {
    5,
    5,
    51,
    2,
    4,
    0,
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
      " PlayEntityLegacyAnimation,animNames=eff_1601051_atkult_main_end,casterEffectID=2494; PlayCasterAnimation,animName = AtkUlt2; Wait,waitTime=500; PlayDeleteCasterEffect,effectIDList=2494; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
