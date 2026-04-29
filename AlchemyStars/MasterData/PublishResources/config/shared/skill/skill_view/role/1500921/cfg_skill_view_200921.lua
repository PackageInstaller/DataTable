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
    2,
    1,
    0,
    0,
    {
      effectparam = "1737",
      castAnimationName = "AtkChain",
      finishDelayTime = 3400,
      buffDelayTime = 2200,
      buffNeedImmediatelyEffect = 0
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      "PlayAudio,audioID = 2210,audioType=1; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2000,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=1738,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=50; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
