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
      " PlayCasterAnimation,animName = Skill01; PlayAudio,audioID=29101011,audioType=1; Wait,waitTime=1900; PlayCasterBindEffect,effectID= 291010102; Wait,waitTime=400; DataSelectSummonThing,index=1; ShowSummonThing,label=foreach; Wait,waitTime=100; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=foreach; "
    }
  }
}
return config, "ID", key
