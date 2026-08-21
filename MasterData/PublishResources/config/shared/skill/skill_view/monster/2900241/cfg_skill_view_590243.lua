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
      " PlayCasterAnimation,animName=Fire; PlayAudio,audioID = 6042,audioType=1; PlayCasterBindEffect,effectID=742; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1860,
    {
      " DataSelectResult,effectType=64,index=1; PlayFlyEffectCasterToTarget,flyEffectID=739,flyTime=500,flyTrace=2,offsetx=1.78,offsety=1.32,offsetz=0.79; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1890,
    {
      " DataSelectResult,effectType=64,index=2; PlayFlyEffectCasterToTarget,flyEffectID=739,flyTime=495,flyTrace=2,offsetx=0.08,offsety=1.15,offsetz=1.83; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    1920,
    {
      " DataSelectResult,effectType=64,index=3; PlayFlyEffectCasterToTarget,flyEffectID=739,flyTime=490,flyTrace=2,offsetx=-1.46,offsety=0.989,offsetz=0.35; "
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    1950,
    {
      " DataSelectResult,effectType=64,index=4; PlayFlyEffectCasterToTarget,flyEffectID=739,flyTime=485,flyTrace=2,offsetx=-1.11,offsety=2.59,offsetz=-0.56; "
    }
  },
  {
    6,
    6,
    0,
    1,
    1,
    1980,
    {
      " DataSelectResult,effectType=64,index=5; PlayFlyEffectCasterToTarget,flyEffectID=739,flyTime=480,flyTrace=2,offsetx=1.52,offsety=2.34,offsetz=-0.602; "
    }
  },
  {
    7,
    7,
    0,
    1,
    1,
    2450,
    {
      "PlaySummonTrap,trapID=2,effectID=741"
    }
  }
}
return config, "ID", key
