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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1300491,waitTime = 2000;"
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
      " PlayAudio,audioID = 2100,audioType=1; "
    }
  },
  {
    3,
    3,
    2,
    2,
    1,
    0,
    {
      effectparam = "1000",
      castAnimationName = "AtkUlt",
      finishDelayTime = 6200,
      buffDelayTime = 0
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
      " PlayCasterBindEffect,effectID=1002; Wait,waitTime=1000; PlayCasterBindEffect,effectID=1001; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2400,
    {
      "PlaySkillAttackRange,showTime=600;"
    }
  },
  {
    6,
    6,
    31,
    2,
    1,
    4400,
    {
      gridEffectID = 0,
      gridIntervalTime = 0,
      bestConvertTime = 0,
      finishDelayTime = 1000,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = 0
    }
  },
  {
    7,
    7,
    0,
    2,
    1,
    4400,
    {
      "DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  }
}
return config, "ID", key
