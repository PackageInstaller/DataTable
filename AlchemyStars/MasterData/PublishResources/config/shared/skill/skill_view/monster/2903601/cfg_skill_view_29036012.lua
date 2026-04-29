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
      " PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID=290360104; PlayCasterBindEffect,effectID=290360106; Wait,waitTime=2400; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 6081, audioType = 1}
  }
}
return config, "ID", key
