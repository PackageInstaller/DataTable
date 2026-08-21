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
      " PlayCasterBindEffect,effectID=PARAM.effectID1; Wait,waitTime=300; PlayCasterVisible,visible=1; PlayAudio,audioID =6103,audioType=1; PlayCasterAnimation,animName = birth; PlayCasterBindEffect,effectID=PARAM.effectID3; Wait,waitTime=2400; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=800; PlaySummonTrap,trapID=60; "
    }
  }
}
return config, "ID", key
