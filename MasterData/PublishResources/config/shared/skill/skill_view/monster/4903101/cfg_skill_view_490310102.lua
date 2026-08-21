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
  }
}
return config, "ID", key
