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
      " DataSelectSummonThing,index=1; PlayCasterTurnToTargetGrid,label=redoShow; PlayCasterAnimation,animName=Skill03; PlayCasterBindEffect,effectID=3283; PlayAudio,audioID=6142,audioType=1; Wait,waitTime=1000; PlayFlyEffectCasterToTarget,flyEffectID=3285,flyTime=600,flyTrace=1,originalBoneName=Bip001 L Hand,isBlock=1; PlayEffectAtSummonPos,effectID=3284; PlayAudio,audioID=6143,audioType=1; Wait,waitTime=500; ShowSummonThing; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    100,
    {
      " PlayCasterTurnToPlayer; "
    }
  }
}
return config, "ID", key
