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
      " PlayCasterAnimation,animName=skill02; PlayAudio,audioID=291000102; "
    }
  },
  {
    2,
    2,
    60,
    1,
    1,
    700,
    {
      [1] = {
        gridPos = {x = 2, y = 2},
        effectID = 291000105
      }
    }
  },
  {
    3,
    3,
    60,
    1,
    1,
    550,
    {
      [1] = {
        gridPos = {x = 5, y = 1},
        effectID = 291000105
      }
    }
  },
  {
    4,
    4,
    60,
    1,
    1,
    900,
    {
      [1] = {
        gridPos = {x = 8, y = 2},
        effectID = 291000105
      }
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    650,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=291000104,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=170; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
