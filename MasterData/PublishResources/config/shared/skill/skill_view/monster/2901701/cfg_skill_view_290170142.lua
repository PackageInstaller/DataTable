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
      " PlayCasterAttachmentAnimation,animName = Skill01; PlayAudio,audioID=6159,audioType=1; Wait,waitTime=2000; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; Wait,waitTime=50; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; "
    }
  }
}
return config, "ID", key
