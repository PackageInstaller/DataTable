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
      " PlayCasterAnimation,animName=Skill02; Wait,waitTime=300; PlayCasterBindEffect,effectID=2781; PlayAudio,audioID = 6091,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1000,
    {
      " DataSelectResult,effectType=34,index=1; PlayFlyEffectCasterToTarget,flyEffectID=2782,flyTime=1000,flyTrace=2,offsety=1.891,offsetx=0.195,offsetz=0.036; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1000,
    {
      " DataSelectResult,effectType=34,index=2; PlayFlyEffectCasterToTarget,flyEffectID=2782,flyTime=1000,flyTrace=2,offsety=1.891,offsetx=0.195,offsetz=0.036; "
    }
  },
  {
    4,
    4,
    34,
    2,
    1,
    1700,
    {
      gridEffectDelayTime = 0,
      gridEffectID = 3654,
      fxNoRotation = 1,
      gridIntervalTime = 0,
      showTimeDelay = 300
    }
  },
  {
    5,
    5,
    0,
    2,
    4,
    0,
    {
      " Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
