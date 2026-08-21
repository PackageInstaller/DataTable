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
      " PlayAudio,audioID = 2171,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayEffectAtCasterPos, effectID=423; Wait,waitTime=500; PlayCasterVisible,visible=0; Wait,waitTime=700; PlayEffectAtCasterPos, effectID=424; Wait,waitTime=800; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = AtkChain2; Wait,waitTime=1667; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2300,
    {
      "DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=422,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=60; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  }
}
return config, "ID", key
