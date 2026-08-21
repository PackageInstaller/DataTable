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
      " Wait,waitTime=500; PlayCasterAnimation,animName=Grenade; PlayCasterEffectHolder,effHolderType=Idle,isShow=0; PlayAudio,audioID = 5063,audioType=1; PlayCasterBindEffect,effectID=774; Wait,waitTime=1300; PlayCasterBindEffect,effectID=773; Wait,waitTime=250; PlayCasterBindEffect,effectID=773; Wait,waitTime=250; PlayCasterBindEffect,effectID=773; Wait,waitTime=250; PlayCasterBindEffect,effectID=773; Wait,waitTime=250; PlayCasterBindEffect,effectID=773; "
    }
  },
  {
    2,
    2,
    34,
    1,
    1,
    2100,
    {
      gridEffectID = 772,
      gridEffectDelayTime = 0,
      gridIntervalTime = 250,
      showTimeDelay = 1000
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " PlayCasterAnimation,animName=Charge; PlayCasterEffectHolder,effHolderType=Idle,isShow=0; PlayCasterEffectHolder,effHolderType=Charge,isShow=1; PlayCasterEffectHolder,effHolderType=Invincible,isShow=0; EffectHolderLegacyAnimation,effHolderType=Permanent,animNames=eff_2900391_red; Wait,waitTime=2000; "
    }
  },
  {
    4,
    4,
    51,
    1,
    3,
    0,
    {audioID = 5065}
  },
  {
    5,
    5,
    29,
    2,
    3,
    2000,
    {
      warningCenterPosType = 2,
      warningCenterPosParam = {
        [1] = {x = 1.5, y = 4.5},
        [2] = {x = 3.5, y = 6.5},
        [3] = {x = 3.5, y = 2.5},
        [4] = {x = 7.5, y = 6.5},
        [5] = {x = 6.5, y = 1.5},
        [6] = {x = 8.5, y = 3.5}
      },
      warningTextEffectID = 339,
      areaRes = ""
    }
  }
}
return config, "ID", key
