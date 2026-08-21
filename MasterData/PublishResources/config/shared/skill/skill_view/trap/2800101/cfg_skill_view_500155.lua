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
      " PlayCasterAnimation,animName = Victory; PlayAudio,audioID = 5072,audioType=1; PlayCasterBindEffect,effectID=762; PlayCasterBindEffect,effectID=763; PlayCasterBindEffect,effectID=764; Wait,waitTime=4000; "
    }
  }
}
return config, "ID", key
