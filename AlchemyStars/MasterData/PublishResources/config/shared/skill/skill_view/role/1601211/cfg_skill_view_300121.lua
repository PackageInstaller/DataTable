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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601211,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=3050; PlayCasterBindEffect,effectID=3051; PlayAudio,audioID = 2340,audioType=1; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1000,
    {
      " PlayEffectAtPickUpIndexGrid,effectID=3052,pickUpIndex=1; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    3100,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=13; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=3053,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=3055,turnToTarget=1,deathClear=0; Wait,waitTime=33; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; PlaySummonTrap,trapID=14,effectID=0; "
    }
  }
}
return config, "ID", key
