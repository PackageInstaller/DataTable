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
      " DataSelectResult,effectType=120,index=1; Jump,condition=CheckEffectResultIndex,param=120,result=0,goto=phaseEnd; PlayDestroyMonster,label=foreach; DataSelectNextResult,effectType=120; Jump,condition=CheckEffectResultIndex,param=120,goto=foreach; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=0; PlayCasterAnimation,animName = Skill01; Wait,waitTime=700; PlayAudio,audioID = 7004,audioType=1; PlayCasterBindEffect,effectID=1075; Wait,waitTime=100; DataSelectSummonThing,index=1; ShowSummonThing,label=foreach; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=foreach; Wait,waitTime=1000; "
    }
  },
  {
    3,
    3,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=800; DataSelectScopeGridRange,effectType=34; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=1076,label=doAgain; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=doAgain; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
