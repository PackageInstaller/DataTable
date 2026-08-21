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
      " PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID=868; PlayCasterBindEffect,effectID=869; PlayAudio,audioID=5048; Wait,waitTime=1033; PlaySummonTrap,trapID=10; PlaySummonTrap,trapID=11; Wait,waitTime=801; "
    }
  }
}
return config, "ID", key
