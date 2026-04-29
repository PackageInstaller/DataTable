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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1600011,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    60,
    2,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 317
      }
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=315,316; PlayAudio,audioID = 2005,audioType=1; Wait,waitTime=10000; "
    },
    {"", "1,-1"}
  },
  {
    4,
    4,
    0,
    2,
    1,
    2750,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlayGridRangeEffect,effectID=318; PlaySummonTrap,trapID=14; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=3000;"
    }
  }
}
return config, "ID", key
