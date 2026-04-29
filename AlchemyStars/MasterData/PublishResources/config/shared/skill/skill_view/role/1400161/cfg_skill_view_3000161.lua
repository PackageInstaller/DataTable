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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400161,waitTime = 2000;"
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
      " DataSelectResult,effectType=81,index=1; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 3009; Wait,waitTime=800; PlayAngleFreeLine,hitAnimName=Hit,turnToTarget=true,deathClear=true,lineEffectID=1066,hitTime=1100; Wait,waitTime=800; DataSelectScopeGridRange; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayPopStarResult; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
