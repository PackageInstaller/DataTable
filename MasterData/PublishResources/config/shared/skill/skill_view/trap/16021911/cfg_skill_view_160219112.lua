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
      " PlayEffectAtCasterPos,effectID=160219119; PlayAudio,audioID = 160219105,audioType=1; Wait,waitTime=500; PlaySummonTrap,trapID=2803501; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
