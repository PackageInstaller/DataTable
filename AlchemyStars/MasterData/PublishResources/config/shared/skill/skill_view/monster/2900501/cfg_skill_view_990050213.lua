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
      " Wait,waitTime=200; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = Birth; PlayAudio,audioID = 6029,audioType=1; PlayCasterBindEffect,effectID=PARAM.BirthEffectId; PlayCasterBindEffect,effectID=PARAM.BirthBoneEffectId; Wait,waitTime=4400; PlayIslandConvert,patternEffectID=290050106; Wait,waitTime=1600; "
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
      " DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playConvert; PlayGridRangeEffect,effectID=480; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playConvert; "
    }
  }
}
return config, "ID", key
