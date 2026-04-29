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
      " PlayCasterVisible,visible=1; PlayCasterAnimation,animName=Birth; Wait,waitTime=1000; "
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
      " PlayCasterAnimation,animName=Skill_1; PlayCasterBindEffect,effectID = 290970108; Wait,waitTime=400; PlayAudio,audioID = 29097012,audioType=1; Wait,waitTime=400; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=29097013; "
    }
  },
  {
    3,
    3,
    29,
    2,
    2,
    0,
    {
      warningCenterPosType = 4,
      warningTextEffectID = 339,
      areaRes = ""
    }
  }
}
return config, "ID", key
