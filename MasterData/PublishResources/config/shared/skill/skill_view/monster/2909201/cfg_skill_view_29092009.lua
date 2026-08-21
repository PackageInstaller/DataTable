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
      " PlayCasterAnimation,animName = Transform; PlayCasterBindEffect,effectID=290920102; PlayAudio,audioID=290920106,audioType=1; Wait,waitTime=1490; DataSelectSummonThing,index=1; PlayFlyEffectCasterToTarget,flyEffectID=290920103,flyTime=800,flyTrace=1,originalBoneName=Bone008,isBlock=0,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=960; PlayTransformation; PlaySwitchBodyAreaResult; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2300,
    {
      "DataSelectSummonThing,index=1; PlayEffectAtSummonPos,effectID=290920104,label=redoShow1; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow1; "
    }
  },
  {
    3,
    3,
    34,
    2,
    2,
    900,
    {
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  }
}
return config, "ID", key
