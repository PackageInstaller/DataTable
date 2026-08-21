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
      " PlayAudio,audioID=290600123,audioType=1; PlayCasterBindEffect,effectID=290600113; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    34,
    1,
    1,
    0,
    {
      showTimeDelay = 800,
      gridEffectID = 290600114,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " Jump,condition=CheckCurrentRoundCount,param=1,result=0,goto=phaseEnd; PlayCasterBindEffect,effectID=290600113; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
