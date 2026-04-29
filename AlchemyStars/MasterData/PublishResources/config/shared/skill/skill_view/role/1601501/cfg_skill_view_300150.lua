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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601451,waitTime = 2000;"
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
      " PlayAudio,audioID = 2450,audioType=1; PlayCasterAnimation,animName=AtkUlt; PlayCasterBindEffect,effectID=3540; PlayEffectAtRangeMathCenter,effectID=3541; Wait,waitTime=3500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1100,
    {
      " PlayCameraEffect,effectID=3544; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=4,sortParam=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=3542,isRotate=1,label=playRangeEffect; Wait,waitTime=4; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=3543,turnToTarget=1,deathClear=1; DataSelectNextScopeGridRange,label=selectNextGridRange; Wait,waitTime=40; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
