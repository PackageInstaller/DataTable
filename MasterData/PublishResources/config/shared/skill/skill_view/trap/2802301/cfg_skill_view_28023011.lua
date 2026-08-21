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
      " PlayDeleteWaringArea; "
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
        effectID = 280230101
      }
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    100,
    {
      " PlayDeleteWaringArea; PlayMonster2802301CentralEffect,effectID=280230104,posY=5,offset=0|0; Wait,waitTime=1850; PlayAudio,audioID = 8022,audioType=1; "
    }
  },
  {
    4,
    4,
    0,
    1,
    2,
    100,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=17; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=0,label=playRangeEffect1; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect1; "
    }
  }
}
return config, "ID", key
