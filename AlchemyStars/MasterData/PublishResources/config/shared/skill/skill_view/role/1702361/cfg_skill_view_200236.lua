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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 170236102,audioType=1; PlayCasterBindEffect,effectID=17023616; PlayCasterBindEffect,effectID=17023618; Wait,waitTime=4600; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2500,
    {
      "DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=17023617,turnToTarget=1,deathClear=1,label=playRangeEffect; Wait,waitTime=150; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlaySkillAttackRange,showTime=1200,isEffectRange=0; "
    }
  }
}
return config, "ID", key
