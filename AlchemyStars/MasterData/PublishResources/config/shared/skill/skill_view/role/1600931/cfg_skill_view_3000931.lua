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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600111,waitTime = 2000;"
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
      " PlayCasterAnimation,animName =AtkUlt; PlayAudio,audioID = 3015,audioType=1; PlayEffectAtCasterPos, effectID=2311; Wait,waitTime=500; PlayShowCasterOnPickUpGrid,pickUpIndex=1; PlayCasterAnimation,animName =AtkUltAOE; PlayEffectAtCasterPos, effectID=2312; PlayEffectAtCasterPos, effectID=2316; PlayEffectAtCasterPos, effectID=2310; Wait,waitTime=1166; DataSelectScopeGridRange; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayPopStarResult; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1833; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    500,
    {
      "PlayCasterVisible,visible=0; PlayShowCasterOnPickUpGrid,reset=1;"
    }
  }
}
return config, "ID", key
