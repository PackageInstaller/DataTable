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
      " PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 6030,audioType=1; PlayCasterBindEffect,effectID=PARAM.Skill01ffectId; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    900,
    {
      "DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=PARAM.Skill01SlotffectId,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    0,
    {
      " DataSelectScopeGridRange,effectType=82; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=2; PlayIslandConvert,patternEffectID=PARAM.IslandEffectId; "
    }
  }
}
return config, "ID", key
