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
      " PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 2419; PlayCasterBindEffect,effectID=3448; "
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
        effectID = 3450
      }
    }
  },
  {
    3,
    3,
    54,
    2,
    1,
    250,
    {
      gridEffectIDs = {3449},
      gridEdgeEffectID = 3449,
      gridIntervalTime = 40,
      finishDelayTime = 100,
      hasDamage = 0,
      hitAnimationName = "Hit",
      hitEffectID = -1,
      effScaleStart = 1,
      defaultScale = 1,
      layerScale = 0.1,
      effectIgnore = 1,
      needRotateEff = -1
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1600,
    {
      "DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,label=doAgain; Wait,waitTime=40; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=doAgain; Wait,waitTime=1800; "
    }
  }
}
return config, "ID", key
