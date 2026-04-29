local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayCasterAnimation,animName = Skill04; PlayAudio,audioID = 6091,audioType=1; DataSelectResult,effectType=34,index=1; PlayFlyEffectCasterToTarget,flyEffectID=2782,flyTime=1000,flyTrace=2,offsety=1.891,offsetx=0.195,offsetz=0.036; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
