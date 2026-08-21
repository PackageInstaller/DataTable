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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600141,waitTime = 2000; "
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
      " PlayAudio,audioID = 160233303,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterBindEffect,effectID =160233305; PlayCasterBindEffect,effectID =160233307; Wait,waitTime=10500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1600,
    {
      " PlayEffectAtPickUpIndexGrid,effectID=160233306,pickUpIndex=1; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    6000,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=0; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    6080,
    {
      " PlayAbsorbMainColorGrid,notifyTrapSkillTrapIDList=2803501,notifySecondPieceType=2; DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  }
}
return config, "ID", key
