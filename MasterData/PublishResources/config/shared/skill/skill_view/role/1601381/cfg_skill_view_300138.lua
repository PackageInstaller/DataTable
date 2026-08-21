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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601381,waitTime = 2000; "
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
      " PlayCasterBindEffect,effectID =3270; PlayCasterBindEffect,effectID =3273; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2397,audioType=1; Wait,waitTime=3000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1350,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurScopeRangeOnCrossLine,result=0,goto=phaseEnd; DataSortScopeGridRange,sortType=15; PlayEffectAtPickUpIndexGrid,effectID=3274,pickUpIndex=1; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlayGridRangeEffect,effectID=3271; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1350,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurScopeRangeOnCrossLine,result=1,goto=phaseEnd; DataSortScopeGridRange,sortType=15; PlayEffectAtPickUpIndexGrid,effectID=3274,pickUpIndex=1; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlayGridRangeEffect,effectID=3272,step=4,offset=0.5|0.5,randomRotate=0; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    5,
    5,
    23,
    2,
    4,
    0,
    {showTime = 0}
  }
}
return config, "ID", key
