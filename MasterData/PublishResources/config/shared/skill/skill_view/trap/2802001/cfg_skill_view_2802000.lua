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
      " PlayCasterLegacyAnimation,animNames=eff_2802001_skill_main_gezi_birth|eff_2802001_skill_main_gezi_idle; PlayAudio,audioID =8017,audioType=1; "
    }
  }
}
return config, "ID", key
