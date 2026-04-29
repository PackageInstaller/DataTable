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
      " PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 20054011,audioType=1; PlayCasterBindEffect,effectID=20054011; Wait,waitTime=700; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Wait,waitTime=100; Jump,condition=CheckSummonThingValid,goto=redoShow; "
    }
  }
}
return config, "ID", key
