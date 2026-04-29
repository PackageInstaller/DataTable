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
      " PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterAnimation,animName = Birth; PlayCasterBindEffect,effectID=3300; Wait,waitTime=600; PlayAudio,audioID=6144,audioType=1; Wait,waitTime=2400; "
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
      " PlayCasterAnimation,animName = CallOut; PlayAddAttachment,attachResName=2901401; PlayCasterAttachmentVisible,visible=1; PlayCasterAttachmentAnimation,animName = CallOut; Wait,waitTime=600; PlayAudio,audioID=6145,audioType=1; Wait,waitTime=600; PlaySummonTrap,trapID=102011; Wait,waitTime=1800; "
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
      "PlayIncreaseSan;"
    }
  }
}
return config, "ID", key
