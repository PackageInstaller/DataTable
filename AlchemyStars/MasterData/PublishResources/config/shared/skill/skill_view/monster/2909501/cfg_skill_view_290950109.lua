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
      " PlayCasterAnimation,animName = Skill1_2; PlayAudio,audioID = 29095015,audioType=1; Wait,waitTime=1000; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=7; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=290950105,step=4,offset=0.5|0.5,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1950,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=7; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeHit; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeHit; "
    }
  }
}
return config, "ID", key
