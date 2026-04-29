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
      " PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID=850; PlayAudio,audioID=5054; Wait,waitTime=499; PlaySummonTrap,trapID=10; PlaySummonTrap,trapID=11; Wait,waitTime=1266; "
    }
  }
}
return config, "ID", key
