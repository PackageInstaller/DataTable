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
      " PlaySummonTrap,trapID=8004033; PlaySummonTrap,trapID=8004034; PlaySummonTrap,trapID=8004035; PlaySummonTrap,trapID=8004036; PlaySummonTrap,trapID=8004037; PlaySummonTrap,trapID=8004038; PlaySummonTrap,trapID=8004039; PlaySummonTrap,trapID=8004040; Wait,waitTime=300; "
    }
  }
}
return config, "ID", key
