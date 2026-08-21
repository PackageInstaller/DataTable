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
      " PlayAudio,audioID=7040,audioType=1; "
    }
  },
  {
    2,
    2,
    95,
    1,
    0,
    0,
    {
      casterAnim = "Skill01",
      casterEffectID = 200210101,
      bulletStartDelay = 830,
      bulletEffectID = 200210102,
      bulletBeginBindBone = "Bone001",
      bulletEndBindBone = "Hit",
      bulletFlyTotalTime = 200,
      hitAnim = "Hit",
      hitDelayTime = 1030,
      hitEffectID = 200210103,
      totalTime = 2000
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
      " PlayCasterBindEffect,effectID=200210104; "
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
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1,remove=1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; "
    }
  }
}
return config, "ID", key
