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
      " PlayAudio,audioID = 2446,audioType=1; PlayCasterAnimation,animName = chain_skill; PlayCasterBindEffect,effectID=3493; Wait,waitTime=1100; PlayCasterBindEffect,effectID=3494; Wait,waitTime=1100; "
    }
  }
}
return config, "ID", key
