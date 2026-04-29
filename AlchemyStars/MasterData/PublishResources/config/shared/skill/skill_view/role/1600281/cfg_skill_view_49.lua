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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600281,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt01; Wait,waitTime=2300; PlayDisplayAddHP; Wait,waitTime=2700; "
    }
  },
  {
    3,
    3,
    43,
    2,
    1,
    0,
    {audioID = 2202, audioType = 1}
  },
  {
    4,
    4,
    0,
    2,
    1,
    0,
    {
      "PlayCasterBindEffect,effectID=223; PlayCasterBindEffect,effectID=1775; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2500,
    {
      " DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,label=playRangeEffect; PlayGridRangeEffect,effectID=224; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  }
}
return config, "ID", key
