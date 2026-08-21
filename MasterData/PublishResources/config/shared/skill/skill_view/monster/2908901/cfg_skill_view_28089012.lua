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
      " PlayCasterLegacyAnimation,animNames=eff_2908901_skill_01_death; PlayAudio,audioID = 290890103,audioType=1; Wait,waitTime=1500; "
    }
  },
  {
    2,
    2,
    30,
    1,
    1,
    1000,
    {
      gridEffectID = 0,
      bestEffectTime = 0,
      finishDelayTime = 1000
    }
  },
  {
    3,
    3,
    23,
    1,
    1,
    1000,
    {showTime = 0}
  }
}
return config, "ID", key
