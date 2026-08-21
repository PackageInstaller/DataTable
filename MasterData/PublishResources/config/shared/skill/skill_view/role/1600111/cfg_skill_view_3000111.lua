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
      " Wait,waitTime=100; "
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
      " PlayShowCasterOnPickUpGrid,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayEffectAtCasterPos, effectID=420; Wait,waitTime=1500; "
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
    2500,
    {
      "DataSelectScopeGridRange; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=422,isRotate=1,label=playRangeEffect; PlayPopStarResult; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    9,
    9,
    0,
    2,
    2,
    500,
    {
      "PlayCasterVisible,visible=0; PlayShowCasterOnPickUpGrid,reset=1;"
    }
  }
}
return config, "ID", key
