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
      " PlayAudio,audioID = 29091015,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2000,
    {
      " PlaySummonTrap,trapID=2809101; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2000,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=400080,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
