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
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=1113; PlayAudio,audioID = 3029,audioType=1; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=playbehit; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playbehit; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
