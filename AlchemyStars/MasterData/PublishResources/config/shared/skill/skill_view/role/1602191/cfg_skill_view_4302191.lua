local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID = 160219104,audioType=1; DataSelectResult,effectType=64,index=1; PlaySummonTrap,trapID=16021911; PlaySummonTrap,trapID=16021912; PlaySummonTrap,trapID=16021913; PlaySummonTrap,trapID=16021914; PlaySummonTrap,trapID=16021915; PlaySummonTrap,trapID=16021916; PlaySummonTrap,trapID=16021917; PlaySummonTrap,trapID=16021918; PlaySummonTrap,trapID=16021919; PlaySummonTrap,trapID=160219110; PlaySummonTrap,trapID=160219111; PlaySummonTrap,trapID=160219112; PlaySummonTrap,trapID=160219113; PlaySummonTrap,trapID=160219114; PlaySummonTrap,trapID=160219115; PlaySummonTrap,trapID=160219116; PlaySummonTrap,trapID=160219117; PlaySummonTrap,trapID=160219118; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
