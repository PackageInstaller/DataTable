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
      "PlayCasterAnimationByUnderGrid,redAnim=eff_2800522_skill_main_death_hongse,yellowAnim=eff_2800522_skill_main_death_huangse,blueAnim=eff_2800522_skill_main_death_lanse,greenAnim=eff_2800522_skill_main_death_lvse,deadPlay=1; Wait,waitTime=2200;"
    }
  }
}
return config, "ID", key
