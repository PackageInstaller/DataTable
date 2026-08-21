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
      " PlayCasterBindEffect,effectID=PARAM.effectID1; PlayAudio,audioID = 6019,audioType=1; Wait,waitTime=1000; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = Birth; Wait,waitTime=100; PlayCasterBindEffect,effectID=PARAM.effectID2; PlaySummonTrap,trapID=40; "
    }
  }
}
return config, "ID", key
