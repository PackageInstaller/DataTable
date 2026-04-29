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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2430,audioType=1; PlayCasterBindEffect,effectID=3443; PlayCasterBindEffect,effectID=3444; PlayCasterBindEffect,effectID=3445; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2150,
    {
      "DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=3446,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,damageStageIndex=1; DataSelectNextScopeGridRange,label=selectNextGridRange; Wait,waitTime=100; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1200; "
    }
  }
}
return config, "ID", key
