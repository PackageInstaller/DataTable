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
      " PlayCasterAnimation,animName=Skill03; PlayAudio,audioID=6180,audioType=1; PlayCasterBindEffect,effectID=3416; PlayAddHpText; Wait,waitTime=200; "
    }
  },
  {
    2,
    2,
    34,
    2,
    1,
    200,
    {
      showTimeDelay = 20,
      gridEffectID = 0,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0
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
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=52120101,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
