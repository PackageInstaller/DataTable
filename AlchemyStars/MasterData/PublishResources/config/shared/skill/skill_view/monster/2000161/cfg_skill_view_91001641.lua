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
    2,
    1,
    0,
    0,
    {
      effectparam = "1516,1517",
      castAnimationName = "Skill01",
      finishDelayTime = 0,
      buffDelayTime = 0
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2040, audioType = 1}
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=PARAM.buffID1,label=doAgain; PlayTargetAddBuff,buffID=PARAM.buffID2; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
