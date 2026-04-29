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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1600021,waitTime = 2000; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID =493; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2157,audioType=1; "
    },
    {"", "1,0"}
  },
  {
    3,
    3,
    69,
    2,
    1,
    3000,
    {
      effectID = 494,
      hitEffectID = -1,
      hitAnimName = "Hit",
      intervalTime = 50
    }
  },
  {
    4,
    4,
    30,
    2,
    1,
    5000,
    {
      gridEffectID = 321,
      bestEffectTime = 500,
      finishDelayTime = 1000
    }
  },
  {
    5,
    5,
    23,
    2,
    4,
    0,
    {showTime = 0}
  }
}
return config, "ID", key
