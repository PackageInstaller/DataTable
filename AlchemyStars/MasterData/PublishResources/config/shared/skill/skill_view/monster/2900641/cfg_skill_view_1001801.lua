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
      " PlayCasterAnimation,animName = birth; PlayCasterVisible,visible=1; PlayCasterBindEffect,effectID=PARAM.effectID1; Wait,waitTime=300; PlayAudio,audioID = 6097,audioType=1; Wait,waitTime=1900; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=950; PlayCasterBindEffect,effectID=PARAM.effectID3; PlaySummonTrap,trapID=61; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
