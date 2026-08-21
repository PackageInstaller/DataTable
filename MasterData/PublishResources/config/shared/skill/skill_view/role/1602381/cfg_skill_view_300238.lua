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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601551,waitTime = 2000;"
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
        gridPos = {x = 5, y = 4},
        effectID = 160238106
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
      " PlayAudio,audioID = 160238105,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterMaterialAnim,animName=eff_1602381_atkult_main_out; PlayCasterBindEffect,effectID=160238109; PlayCameraEffect,effectID=160238107; Wait,waitTime=1300; UiHudVisible,visible=0; UiBattleVisible,visible=0; Wait,waitTime=3900; UiHudVisible,visible=1; UiBattleVisible,visible=1; Wait,waitTime=2000; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    5300,
    {
      " PlayCasterAnimation,animName = Atkult1; PlayCasterMaterialAnim,animName=eff_1602381_atkult_main_in; PlayCasterBindEffect,effectID=160238108; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    5300,
    {
      " DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160238105,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    5500,
    {
      " PlaySummonTrap,trapID=14; "
    }
  }
}
return config, "ID", key
