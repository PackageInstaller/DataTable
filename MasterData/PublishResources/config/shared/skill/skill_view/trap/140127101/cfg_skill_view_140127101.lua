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
      " PlayAudio,audioID = 9037,audioType=1; Wait,waitTime =2000;"
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
      " PlayCasterTurnToTarget; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=2793; PlayAudio,audioID = 2310,audioType=1; PlaySummonTrap,trapID=140127102; Wait,waitTime=3333; "
    }
  }
}
return config, "ID", key
