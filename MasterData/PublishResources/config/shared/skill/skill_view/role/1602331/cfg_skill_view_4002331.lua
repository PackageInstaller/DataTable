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
      " PlayAudio,audioID = 160234104,audioType=1; PlaySummonTrap,trapID=2803501,effectID=160234105; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
