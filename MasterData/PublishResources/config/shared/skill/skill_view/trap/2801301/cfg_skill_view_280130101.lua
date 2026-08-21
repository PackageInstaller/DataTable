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
      " PlayCasterLegacyAnimation,animNames=eff_2801301_skill_main_birth; Wait,waitTime=1200; PlayCasterLegacyAnimation,animNames=eff_2801301_skill_main_idle; Wait,waitTime=1610; PlayTrapAurasState,effectName=eff_2801301_skill_gezi.prefab,state=1;"
    }
  }
}
return config, "ID", key
