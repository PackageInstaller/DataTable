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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =3288; PlayAudio,audioID = 2405,audioType=1; Wait,waitTime=300; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1500,
    {
      " PlayModifyTimeScale,type=0; "
    }
  }
}
return config, "ID", key
