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
      " PlayCasterAnimation,animName = skill03; PlayCasterBindEffect,effectID=2730; PlayAudio,audioID = 6106,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " Wait,waitTime=1500; "
    }
  },
  {
    3,
    3,
    38,
    2,
    2,
    0,
    {
      effectIDList = {2727, 2729}
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
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=2; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=PARAM.effectID3,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,bodyArea=4; Wait,waitTime=150; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
