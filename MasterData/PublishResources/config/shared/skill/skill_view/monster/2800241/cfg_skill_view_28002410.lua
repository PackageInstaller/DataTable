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
      " PlayCasterVisible,visible=1; PlayCasterAnimation,animName = Birth; PlayAudio,audioID = 6089,audioType=1; PlayCasterBindEffect,effectID=2779; Wait,waitTime=3666; PlayCasterBindEffect,effectID=2781; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    5216,
    {
      " PlayAudio,audioID = 6091,audioType=1; DataSelectResult,effectType=34,index=1; PlayFlyEffectCasterToTarget,flyEffectID=2782,flyTime=1000,flyTrace=2,offsety=1.891,offsetx=0.195,offsetz=0.036; "
    }
  },
  {
    3,
    3,
    34,
    1,
    1,
    6216,
    {
      gridEffectDelayTime = 0,
      gridEffectID = 2783,
      fxNoRotation = 1,
      gridIntervalTime = 0,
      showTimeDelay = 300
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
