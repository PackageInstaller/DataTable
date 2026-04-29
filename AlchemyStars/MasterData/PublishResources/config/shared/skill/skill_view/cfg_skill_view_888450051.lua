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
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; PlayTargetAddBuff,buffID=PARAM.buffID2; PlayTargetAddBuff,buffID=PARAM.buffID3; PlayTargetAddBuff,buffID=PARAM.buffID4; PlayTargetAddBuff,buffID=PARAM.buffID5; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; "
    }
  }
}
return config, "ID", key
