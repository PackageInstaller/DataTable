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
      " PlayCasterBindEffect,effectID = 160148413; PlayAudio,audioID = 2630,audioType=1; "
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
      " DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Wait,waitTime=700; PlayGridRangeConvert,dataSource=4,isRotate=1,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
