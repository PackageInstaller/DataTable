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
    38,
    1,
    0,
    0,
    {
      effectIDList = {1836}
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=1000; PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 6057,audioType=1; PlayCasterBindEffect,effectID=1833; PlayCasterBindEffect,effectID=1834; Wait,waitTime=2000; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=3002; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
