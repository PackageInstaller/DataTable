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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1300521,waitTime = 2000;"
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
      " PlayAudio,audioID = 2106,audioType=1;"
    }
  },
  {
    3,
    3,
    37,
    2,
    1,
    200,
    {
      castEffectID = 0,
      castAnimation = "AtkUlt",
      castDuration = 66,
      stealthDuration = 1500,
      appearEffectID = 0,
      appearAnimation = "AtkUlt1",
      appearDuration = 2200
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    200,
    {
      " PlaySelectCenterGridEffect,effectID=542,intervalTime=0; PlaySelectCenterGridEffect,effectID=543,intervalTime=0,overrideScopeByEffectType=1; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    700,
    {
      " PlaySkillAttackRange,showTime=600; "
    }
  },
  {
    6,
    6,
    26,
    2,
    1,
    1833,
    {
      castEffectID = 0,
      castAnimationName = "",
      hitDelayTime = 0,
      targetEffectID = 0,
      hitAnimationName = "Hit",
      finishDelayTime = 1500,
      hpDelay = 0
    }
  }
}
return config, "ID", key
