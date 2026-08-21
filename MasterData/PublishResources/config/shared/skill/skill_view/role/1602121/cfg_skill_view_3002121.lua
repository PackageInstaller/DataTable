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
      " PlayAudio,audioID = 160212103,audioType=1; ScreenShotSetTestureForAnton,effectID=160212107,duration=5300,block=0; PlayGridDark,darkType=0; PlayHUDVisible,visible=0; PlayTeamHUDVisible,visible=0; UiBattleVisible,visible=0; PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=7000; PlayHUDVisible,visible=1; UiBattleVisible,visible=1; PlayTeamHUDVisible,visible=1; PlayGridDark,darkType=1; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    3600,
    {
      " PlayEffectAtPickUpIndexGrid,effectID=160212108,pickUpIndex=1; Wait,waitTime=100; PlayEffectAtPickUpIndexGrid,effectID=160212108,pickUpIndex=2; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    5000,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160212109,label=playRangeEffect; PlayGridRangeConvert,dataSource=4; PlaySummonTrap,trapID=14; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    5000,
    {
      " DataSelectResult,effectType=36,index=1; Jump,condition=IsAddBloodValueGreaterThan,param=0,result=0,goto=phaseEnd; PlayCasterMaterialAnim,animName=eff_1602121_atkult_main; PlayCasterBindEffect,effectID =160212110; PlayDisplayAddHP; "
    }
  }
}
return config, "ID", key
