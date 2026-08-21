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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600111,waitTime = 2000;"
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
      "PlayAudio,audioID = 2169,audioType=1;"
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
      "PlayRoleTeleport, type=3; PlayRoleTeleport, type=5"
    }
  },
  {
    4,
    4,
    38,
    2,
    1,
    133,
    {
      effectIDList = {417}
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    133,
    {
      "PlayEffectAtCasterPos, effectID=419,isGridPos=0;"
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    333,
    {
      " PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayCasterAnimation,animName = AtkUlt; PlayEffectAtCasterPos, effectID=420; Wait,waitTime=5500; "
    }
  },
  {
    7,
    7,
    0,
    2,
    1,
    333,
    {
      "PlayCameraEffect, effectID=421;"
    }
  },
  {
    8,
    8,
    0,
    1,
    4,
    2000,
    {
      "DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=422,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    9,
    9,
    0,
    1,
    4,
    2000,
    {
      "DataSelectRefreshBuff,Index=1; PlayTargetRefreshBuffView,buffEffectType=3029,label=doAgain; DataSelectRefreshNextBuff; Jump,condition=CheckBuffRefreshValid,goto=doAgain;"
    }
  }
}
return config, "ID", key
