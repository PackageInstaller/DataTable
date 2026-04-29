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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID = 160148403; PlayCasterBindEffect,effectID = 160148416; PlayAudio,audioID = 2625,audioType=1; Wait,waitTime=750; PlayCasterBindEffect,effectID = 160148417; Wait,waitTime=2550; "
    }
  },
  {
    2,
    2,
    60,
    1,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 160148418
      }
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
      " PlaySkillAttackRange,showTime=600,isEffectRange=0; Wait,waitTime = 100; DataSelectDamageScopeGridRange; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime = 2600; "
    }
  }
}
return config, "ID", key
