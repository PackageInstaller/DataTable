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
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop;"
    }
  },
  {
    2,
    2,
    36,
    1,
    0,
    500,
    {
      gridEffectID = 2908,
      gridEffectDelayTime = 1000,
      gridIntervalTime = 0,
      showTimeDelay = 0
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
      " Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
