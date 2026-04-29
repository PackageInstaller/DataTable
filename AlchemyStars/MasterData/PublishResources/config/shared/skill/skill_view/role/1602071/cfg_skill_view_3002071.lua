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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1601201,waitTime = 2000;"
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
      " PlayAudio,audioID = 2673,audioType=1; PlayCasterBindEffect,effectID=160207104; PlayCasterBindEffect,effectID=160207105; PlayCasterAnimation,animName=AtkUlt; PlayCasterSubMaterialAnim,nodeName=1602071_body02,animName=effanim_1602071_atkult; Wait,waitTime=1800; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1900,
    {
      " PlayEffectAtPickUpDirByCount,effectID=160207107,pickUpIndex=1,dirX=-1|0,dirY=0|1; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1800,
    {
      " DataSelectScopeGridRange,effectType=211; DataSortScopeGridRange,sortType=18; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160207106,isRotate=0,label=playRangeEffect; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=650; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2400,
    {
      " PlayPickUpGridTogetherEffect; "
    }
  }
}
return config, "ID", key
