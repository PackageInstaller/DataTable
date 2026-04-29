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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600961,waitTime = 2000;"
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
      " PlayGridDark,darkType=0; PlayAudio,audioID = 160223104,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =160223301; Wait,waitTime=700; PlayChenNiGridEffect,effectID=160223302; Wait,waitTime=3100; PlayGridDark,darkType=1; Wait,waitTime=1500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    900,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=19; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160223303,randomRotateList=0|90|180|270,label=playRangeEffect; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1400,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=19; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    1400,
    {
      "DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=20; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160223304,randomRotateList=0|90|180|270,label=playRangeEffect; PlaySummonTrap,trapID=2803501; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  }
}
return config, "ID", key
