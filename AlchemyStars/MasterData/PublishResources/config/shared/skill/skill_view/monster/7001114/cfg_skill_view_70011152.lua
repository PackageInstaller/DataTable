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
    30,
    1,
    0,
    0,
    {
      gridEffectID = 3892,
      bestEffectTime = 0,
      finishDelayTime = 0
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      "PlayCasterLegacyAnimation,animNames=eff_2909101_skill_out; PlaySummonTrap,trapID=2803501; Wait,waitTime=1000; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1000,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap; "
    }
  }
}
return config, "ID", key
