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
    38,
    1,
    0,
    0,
    {
      effectIDList = {2354}
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
      " PlayCasterBindEffect,effectID=2355; PlayCasterBindEffect,effectID=2351; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 2247,audioType=1; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1800,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=2349,turnToTarget=1,deathClear=0,label=playRangeEffect; PlayGridRangeEffect,effectID=2348,isRotate=1; DataSelectNextScopeGridRange; Wait,waitTime=50; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; PlayConductDamage,hitEffectID=2349,hitAnimName=Hit,turnToTarget=1,deathClear=0,chainEffectID=2350; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " PlayCasterBindEffect,effectID=2354; "
    }
  }
}
return config, "ID", key
