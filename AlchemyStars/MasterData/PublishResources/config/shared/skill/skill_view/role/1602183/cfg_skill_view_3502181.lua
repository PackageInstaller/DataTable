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
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=4102181; PlayTargetAddBuff,buffID=4102182; PlayTargetAddBuff,buffID=4102183; PlayTargetAddBuff,buffID=4102184; PlayTargetAddBuff,buffID=4102185; PlayTargetAddBuff,buffID=4102186; "
    }
  }
}
return config, "ID", key
