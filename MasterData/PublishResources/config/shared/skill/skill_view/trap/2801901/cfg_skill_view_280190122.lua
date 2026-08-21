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
      " PlayCasterLegacyAnimation,animNames=effanim_28019001_end; Wait,waitTime=1200; PlaySummonTrap,trapID=490064021; PlaySummonTrap,trapID=490064022; PlaySummonTrap,trapID=490064023; PlaySummonTrap,trapID=490064024; "
    }
  }
}
return config, "ID", key
