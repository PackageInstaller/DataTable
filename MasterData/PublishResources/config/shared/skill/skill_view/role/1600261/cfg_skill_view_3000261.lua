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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600261,waitTime = 2000; "
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
      " PlayGridDark,darkType=0; PlayTrapVisible,visible = 0; PlayShowLineRenderer,show=0,isTrap=1,selfAll=1; UiHudVisible,visible=0; UiBattleVisible,visible=0; PlayAudio,audioID = 2181,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=727; Wait,waitTime = 600; PlayCasterVisible,visible=0; Wait,waitTime = 600; PlayCasterAnimation,animName = AtkUlt01; "
    }
  },
  {
    3,
    3,
    60,
    1,
    2,
    1200,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 3393
      }
    }
  },
  {
    4,
    4,
    0,
    1,
    2,
    6300,
    {
      " PlayCasterBindEffect,effectID=479; "
    }
  },
  {
    5,
    5,
    0,
    1,
    2,
    9500,
    {
      "DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=10; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,dataSourceHigher=62,label=playRangeEffect; PlayGridRangeEffect,effectID=480; Wait,waitTime=150; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    6,
    6,
    0,
    1,
    2,
    10500,
    {
      " PlayCasterAnimation,animName = AtkUlt02; PlayCasterBindEffect,effectID=3394; Wait,waitTime = 1000; "
    }
  },
  {
    7,
    7,
    0,
    1,
    2,
    11400,
    {
      " PlayCasterVisible,visible=1; PlayTrapVisible,visible = 1; PlayShowLineRenderer,show=1,isTrap=1,selfAll=1; UiHudVisible,visible=1; UiBattleVisible,visible=1; Wait,waitTime = 1300; "
    }
  }
}
return config, "ID", key
