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
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=80031612,remove=1,checkUnload=1,label=doAgain; PlayTargetAddBuff,buffID=80031612,checkUnload=1; PlayTargetAddBuff,buffID=80031613,remove=1,checkUnload=1; PlayTargetAddBuff,buffID=80031613,checkUnload=1; PlayTargetAddBuff,buffID=80031614,remove=1,checkUnload=1; PlayTargetAddBuff,buffID=80031614,checkUnload=1; PlayTargetAddBuff,buffID=80031615,remove=1,checkUnload=1; PlayTargetAddBuff,buffID=80031615,checkUnload=1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
