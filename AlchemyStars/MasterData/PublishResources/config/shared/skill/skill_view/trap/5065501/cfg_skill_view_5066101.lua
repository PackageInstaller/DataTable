local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID = 9040,audioType=1; "
    }
  },
  {
    2,
    2,
    30,
    1,
    1,
    1000,
    {
      gridEffectID = 3476,
      bestEffectTime = 0,
      finishDelayTime = 0,
      notifyPreview = 1
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    100,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=doAgain; PlayTargetAddBuff,buffID=5066101; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
