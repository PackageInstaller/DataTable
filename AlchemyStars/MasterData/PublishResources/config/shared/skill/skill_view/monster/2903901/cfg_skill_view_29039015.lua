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
      "DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=30016,label=doAgain; Wait,waitTime=1200; DataSelectNextBuff; Wait,waitTime=100; Jump,condition=CheckBuffIndexValid,goto=doAgain;"
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayMonsterMoveFrontAttack; "
    }
  }
}
return config, "ID", key
