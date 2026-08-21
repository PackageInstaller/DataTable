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
      " PlaySummonTrap,trapID=11150722; PlayTrapAurasState,effectName=eff_2900263_gezi_red.prefab,state=1; "
    }
  }
}
return config, "ID", key
