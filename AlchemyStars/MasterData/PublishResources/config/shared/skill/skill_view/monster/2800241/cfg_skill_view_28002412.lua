local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayCasterAnimation,animName = Skill02; PlayAudio,audioID = 6090,audioType=1; Wait,waitTime=2333; PlayCasterBindEffect,effectID=2785; PlayTargetAddBuff,buffID=10011; Wait,waitTime=2000; PlayCasterBindEffect,effectID=2780; Wait,waitTime=2650; PlayCasterVisible,visible=0; Wait,waitTime=2350; "
    }
  }
}
return config, "ID", key
