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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2546,audioType=1; PlayCasterBindEffect,effectID=140169105; PlayCasterBindEffect,effectID=140169107; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    500,
    {
      "DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=140169106,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1; DataSelectNextScopeGridRange,label=selectNextGridRange; Wait,waitTime=100; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=3500; "
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
      " PlaySkillAttackRange,showTime=500,isEffectRange=0; "
    }
  }
}
return config, "ID", key
