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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1854; PlayCasterBindEffect,effectID=1855; PlayCasterBindEffect,effectID=1858; Wait,waitTime=800; PlayCasterVisible,visible=0; Wait,waitTime = 2500; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = AtkUlt1; PlayCasterBindEffect,effectID=1861; Wait,waitTime = 1800; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,label=checkbuff; PlayTargetAddBuff,buffEffectType =443028; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; "
    }
  },
  {
    3,
    3,
    43,
    2,
    1,
    0,
    {audioID = 2220, audioType = 1}
  },
  {
    4,
    4,
    60,
    2,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 4},
        effectID = 1859
      }
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2000,
    {
      " DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=10; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,label=playRangeEffect; PlayGridRangeEffect,effectID=1860; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  }
}
return config, "ID", key
