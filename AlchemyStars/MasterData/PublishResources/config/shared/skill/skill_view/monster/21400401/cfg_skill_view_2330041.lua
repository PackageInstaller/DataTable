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
    2,
    0,
    0,
    {
      " Wait,waitTime=700; PlayAudio,audioID = 2124,audioType=1;"
    }
  },
  {
    2,
    2,
    26,
    2,
    1,
    0,
    {
      castEffectID = 387,
      castAnimationName = "AtkUlt",
      hitDelayTime = 3500,
      targetEffectID = 0,
      hpDelay = 0,
      hitAnimationName = "Hit",
      hitEffectID = 0,
      finishDelayTime = 4200,
      clearBodyNow = 0
    },
    {"", "1,0"}
  },
  {
    3,
    3,
    2,
    2,
    1,
    0,
    {
      effectparam = "388",
      finishDelayTime = 0,
      buffDelayTime = 0
    }
  },
  {
    4,
    4,
    0,
    1,
    2,
    2700,
    {
      " PlaySkillAttackRange,showTime=600; "
    }
  },
  {
    5,
    5,
    0,
    1,
    2,
    3500,
    {
      "DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,isRotate=1,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  }
}
return config, "ID", key
