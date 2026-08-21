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
      " PlayCasterAnimation,animName = Birth; PlayAudio,audioID = 5075,audioType=1; PlayCasterBindEffect,effectID=756; PlaySummonTrap,trapID=40; "
    }
  }
}
return config, "ID", key
