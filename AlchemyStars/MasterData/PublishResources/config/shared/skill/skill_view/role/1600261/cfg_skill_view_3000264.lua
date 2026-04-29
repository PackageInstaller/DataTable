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
      " PlayGridDark,darkType=0; PlayTrapVisible,visible = 0; UiHudVisible,visible=0; UiBattleVisible,visible=0; PlayAudio,audioID = 160026403,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterMaterialAnim,animName=effanim_1600264_atkult_out01; PlayCasterBindEffect,effectID=160026402; PlayCasterVisible,visible=0; Wait,waitTime = 2700; PlayCameraEffect,effectID=160026409; "
    }
  },
  {
    3,
    3,
    60,
    1,
    2,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 160026401
      },
      [2] = {
        gridPos = {x = 5, y = 5},
        effectID = 160026410
      }
    }
  },
  {
    4,
    4,
    0,
    1,
    2,
    6600,
    {
      "DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=10; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,dataSourceHigher=62,label=playRangeEffect; Wait,waitTime=150; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    5,
    5,
    0,
    1,
    2,
    7100,
    {
      " PlayCasterBindEffect,effectID=160026403; Wait,waitTime = 100; PlayCasterVisible,visible=1; PlayCasterMaterialAnim,animName=effanim_1600264_atkult_in; PlayCasterAnimation,animName = AtkUlt02; "
    }
  },
  {
    6,
    6,
    0,
    1,
    2,
    7500,
    {
      " PlayTrapVisible,visible = 1; UiHudVisible,visible=1; UiBattleVisible,visible=1; Wait,waitTime = 1300; "
    }
  }
}
return config, "ID", key
