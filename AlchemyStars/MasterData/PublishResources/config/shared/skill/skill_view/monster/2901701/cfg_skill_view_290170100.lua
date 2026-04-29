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
      " PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterAnimation,animName = Birth; PlayAudio,audioID=6153,audioType=1; PlayCasterBindEffect,effectID=3300; Wait,waitTime=3000; "
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
      " PlayCasterAnimation,animName = CallOut; PlayAudio,audioID=6155,audioType=1; PlayAddAttachment,attachResName=2901701; PlayCasterAttachmentVisible,visible=1; PlayCasterAttachmentAnimation,animName = CallOut; Wait,waitTime=3300; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Wait,waitTime=100; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    4,
    4,
    0,
    2,
    2,
    0,
    {
      "PlayIncreaseSan;"
    }
  }
}
return config, "ID", key
