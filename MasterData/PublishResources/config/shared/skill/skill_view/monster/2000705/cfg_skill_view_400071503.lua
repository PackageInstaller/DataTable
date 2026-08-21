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
    2,
    0,
    0,
    {
      " PlayCasterAnimation,animName = Skill02; PlayAudio,audioID = 7032,audioType=1; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2041, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop;"
    }
  },
  {
    4,
    4,
    0,
    1,
    3,
    0,
    {
      " Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
