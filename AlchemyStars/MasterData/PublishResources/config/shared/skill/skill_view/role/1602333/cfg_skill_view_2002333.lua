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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 160233302,audioType=1; PlayCasterBindEffect,effectID=160233303; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    900,
    {
      "DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=4,sortParam=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160233304,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1; Wait,waitTime=50; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500; "
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
      " PlaySkillAttackRange,showTime=200,isEffectRange=0; "
    }
  }
}
return config, "ID", key
