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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1500761,waitTime = 2000;"
    },
    {"", "1,0"}
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1369; PlayAudio,audioID = 3012,audioType=1; Wait,waitTime=2500; DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlayGridRangeEffect,effectID=1368; PlaySummonTrap,trapID=14; DataSelectNextScopeGridRange; Wait,waitTime=100; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=3000; "
    }
  },
  {
    3,
    3,
    60,
    1,
    2,
    2400,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 1370
      }
    }
  }
}
return config, "ID", key
