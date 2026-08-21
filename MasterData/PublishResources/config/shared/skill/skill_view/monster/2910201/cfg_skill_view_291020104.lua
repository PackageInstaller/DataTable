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
      " PlayCasterTurnToPlayer; PlayCasterAnimation,animName = skill1; PlayCasterBindEffect,effectID=291020103; PlayAudio,audioID = 29102013; "
    }
  },
  {
    2,
    3,
    0,
    1,
    1,
    800,
    {
      " DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Wait,waitTime=10; Jump,condition=CheckSummonThingValid,goto=redoShow; "
    }
  }
}
return config, "ID", key
