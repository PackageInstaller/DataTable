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
      " PlayCasterVisible,visible=1; PlayCasterAnimation,animName = Birth; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    3500,
    {
      " PlayCasterAnimation,animName = Skill03; PlayCasterBindEffect,effectID=2433; PlayCasterBindEffect,effectID=2434; Wait,waitTime=3200; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=2000; "
    }
  },
  {
    3,
    3,
    43,
    1,
    2,
    0,
    {audioID = 5091, audioType = 1}
  }
}
return config, "ID", key
