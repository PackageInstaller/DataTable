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
      " PlayCasterVisible,visible=0; Wait,waitTime=1; PlayCasterVisible,visible=1; PlayEffectAtCasterPos, effectID=3897; PlayCasterMaterialAnim,animName=eff_1501301_atkchain_shigao; "
    }
  }
}
return config, "ID", key
