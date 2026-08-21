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
      " PlayAttackAndSummonWithFarestBoard,time=1000,hitEffectID=0,flyEffectID=PARAM.effectatk; PlaySummonTrap,trapID=61; Wait,waitTime=100; "
    }
  }
}
return config, "ID", key
