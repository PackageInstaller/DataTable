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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=3068; PlayAudio,audioID = 2348,audioType=1; Wait,waitTime=600; PlayCasterBindEffect,effectID=3070; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1100,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=3069,randomRotate=10,label=playRangeEffect; PlayGridRangeTrapVisble,visible=0,trapID=16012611; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=150; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2500; PlayMoveTrap; PlayEntityVisible,trapID=16012611,visible=1; "
    }
  }
}
return config, "ID", key
