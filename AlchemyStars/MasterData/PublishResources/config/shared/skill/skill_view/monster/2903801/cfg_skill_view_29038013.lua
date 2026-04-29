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
      " PlayCasterAnimation,animName=Skill03; PlayAudio,audioID=6223,audioType=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=290380105; Wait,waitTime=1200; PlayCoffinMusumeCandle,candleEffectID=290380106; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
