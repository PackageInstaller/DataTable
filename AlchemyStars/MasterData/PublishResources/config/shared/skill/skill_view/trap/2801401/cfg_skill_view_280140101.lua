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
      " ReplacePrefabByUnderGrid,redPrefab=eff_2800522_skill_main_hong.prefab,yellowPrefab=eff_2800522_skill_main_huang.prefab,bluePrefab=eff_2800522_skill_main_lan.prefab,greenPrefab=eff_2800522_skill_main_lv.prefab; PlayCasterAnimationByUnderGrid,redAnim=eff_2800522_skill_main_birth_hongse,yellowAnim=eff_2800522_skill_main_birth_huangse,blueAnim=eff_2800522_skill_main_birth_lanse,greenAnim=eff_2800522_skill_main_birth_lvse; Wait,waitTime=1600; PlayCasterAnimationByUnderGrid,redAnim=eff_2800522_skill_main_idle_hongse,yellowAnim=eff_2800522_skill_main_idle_huangse,blueAnim=eff_2800522_skill_main_idle_lanse,greenAnim=eff_2800522_skill_main_idle_lvse;"
    }
  }
}
return config, "ID", key
