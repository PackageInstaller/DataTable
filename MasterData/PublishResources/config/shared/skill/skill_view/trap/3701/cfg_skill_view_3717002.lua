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
      " DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=20031,label=doAgain; Wait,waitTime=66; DataSelectNextBuff; Wait,waitTime=100; Jump,condition=CheckBuffIndexValid,goto=doAgain;"
    }
  }
}
return config, "ID", key
