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
    37,
    1,
    0,
    0,
    {
      castEffectID = 748,
      castAnimation = "Disappear",
      castDuration = 600,
      stealthDuration = 750,
      appearEffectID = 743,
      appearAnimation = "Appear",
      appearDuration = 1300
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      "PlayAudio,audioID = 6043,audioType=1;"
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlayCasterTurnToPlayer; Wait,waitTime=1350; PlayCasterBindEffect,effectID=834; Wait,waitTime=1000; PlayCasterBindEffect,effectID=833; "
    }
  },
  {
    4,
    4,
    29,
    1,
    3,
    0,
    {
      warningCenterPosType = 3,
      warningCenterPosParam = 5,
      warningTextEffectID = 339,
      areaRes = ""
    }
  },
  {
    5,
    5,
    0,
    1,
    3,
    0,
    {
      "PlayCasterTurnToPlayer,force=1; DataSortSummonTrapResult,pattern=1; PlaySummonTrap,trapID=4,interval=100; DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; PlayCasterTurnToPlayer,force=1; "
    }
  },
  {
    6,
    6,
    45,
    1,
    3,
    0,
    {
      prob = 100,
      tipsList = {290024101}
    }
  },
  {
    7,
    7,
    0,
    1,
    0,
    0,
    {
      " PlayCasterRenderState,renderState=1; PlayCasterTurnToPlayer,force=1; "
    }
  }
}
return config, "ID", key
