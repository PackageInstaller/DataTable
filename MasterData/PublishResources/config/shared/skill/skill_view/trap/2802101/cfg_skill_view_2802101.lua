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
      " PlayCasterLegacyAnimation,animNames=effanim_2802101_huode; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    633,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlayAudio,audioID =8021,audioType=1; "
    }
  }
}
return config, "ID", key
