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
      " PlayDeleteWaringArea; PlayAudio,audioID = 6025,audioType=1; Wait,waitTime=1500; DataSelectScopeGridRange,effectType=1,damageStageIndex=1; DataSortScopeGridRange,sortType=7; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=1235,step=4,offset=0.5|0.5,label=playRangeEffect; Wait,waitTime=200; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=1; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=500; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    100,
    {
      " PlayCasterAnimation,animName=Land; Wait,waitTime=500; PlayEffectAtCasterPos, effectID=1236; "
    }
  }
}
return config, "ID", key
