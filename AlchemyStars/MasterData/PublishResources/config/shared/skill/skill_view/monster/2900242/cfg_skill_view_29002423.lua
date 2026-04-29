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
      " PlayCasterAnimation,animName=Skill03; PlayAudio,audioID = 6096,audioType=1; PlayCasterBindEffect,effectID=2764; Wait,waitTime=1200; DataSortSummonTrapResult,pattern=1; PlaySummonTrap,trapID=61,effectID=0; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    800,
    {
      " DataSelectResult,effectType=34,index=1; PlayFlyEffectCasterToTarget,flyEffectID=2765,flyTime=800,flyTrace=2; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    800,
    {
      " DataSelectResult,effectType=34,index=2; PlayFlyEffectCasterToTarget,flyEffectID=2765,flyTime=800,flyTrace=2; "
    }
  },
  {
    4,
    4,
    34,
    1,
    1,
    1500,
    {
      gridEffectDelayTime = 0,
      gridEffectID = 2766,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  }
}
return config, "ID", key
