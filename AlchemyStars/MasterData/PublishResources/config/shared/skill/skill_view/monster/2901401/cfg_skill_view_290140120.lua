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
      " PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID=3302; PlayAudio,audioID=6163,audioType=1; Wait,waitTime=1000; PlayCasterAttachmentAnimation,animName = Skill02; "
    }
  },
  {
    2,
    2,
    87,
    2,
    1,
    0,
    {
      prerollDelay = 1000,
      rolloutTime = 200,
      standEdgeTime = 100,
      rollbackTime = 200,
      postrollDelay = 850,
      rollEffectID = 3312,
      hitAnimName = "Hit",
      summonTrapIDs = {102011, 102021}
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
      " PlayCasterAnimation,animName = Skill022; PlayCasterBindEffect,effectID=3303; Wait,waitTime=1200; "
    }
  },
  {
    4,
    4,
    0,
    1,
    2,
    0,
    {
      " PlayAudio,audioID=6147,audioType=1; PlayAudio,audioID=6148,audioType=1; "
    }
  }
}
return config, "ID", key
