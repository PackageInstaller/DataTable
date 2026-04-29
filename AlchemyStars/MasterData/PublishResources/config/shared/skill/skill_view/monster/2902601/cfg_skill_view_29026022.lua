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
      " PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID=3566; PlayAudio,audioID=5030,audioType=1; Wait,waitTime=500; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=29026022; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
