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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600891,waitTime = 2000; "
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterBindEffect,effectID =160199108; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2634,audioType=1; Wait,waitTime=5000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2500,
    {
      " PlayEffectAtPickUpIndexGrid,effectID=160199109,pickUpIndex=1; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    4340,
    {
      " DataSelectScopeGridRange,effectType=6; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160199110,label=playRangeEffect; Wait,waitTime=100; PlayGridRangeConvert,dataSource=6; PlaySummonTrap,trapID=621; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  }
}
return config, "ID", key
