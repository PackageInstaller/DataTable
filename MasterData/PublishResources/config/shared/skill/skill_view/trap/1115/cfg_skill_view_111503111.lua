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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1717; PlayAudio,audioID = 3052,audioType=1; Wait,waitTime=3000; ; PlaySummonTrap,trapID=11150314; Wait,waitTime=1500; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayPetTrapMove; "
    }
  }
}
return config, "ID", key
