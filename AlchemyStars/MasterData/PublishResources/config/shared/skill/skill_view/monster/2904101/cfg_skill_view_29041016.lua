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
      " PlayCasterLegacyAnimation,animNames=eff_2904101_skill01_main_scene_born,playOnSuper=1; Wait,waitTime=3000; PlayCasterLegacyAnimation,animNames=eff_2904101_skill01_main_scene_idle,playOnSuper=1; "
    }
  }
}
return config, "ID", key
