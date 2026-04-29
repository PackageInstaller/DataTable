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
      " PlayCasterAnimation,animName = Skill01; PlayAudio,audioID =6061,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayCasterBindEffect,effectID=PARAM.effectID4; PlayCasterBindEffect,effectID=PARAM.effectID5; Wait,waitTime=1900; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=PARAM.effectID2,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=50; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; PlayMultiTraction; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    3400,
    {
      " DataSelectScopeGridRange,effectType=82; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=2; PlayIslandConvert,patternEffectID=PARAM.effectID3; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
