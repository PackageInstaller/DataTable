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
      " PlayTransposition, boardEffectID=291030110, anim1=idle, anim2=Atk2, casterMaterialAnim=eff_2910301_skill02_in, otherMaterialAnim=eff_2910301_skill02_shadow_in, fadeTime=500, hideTime=400, finishWaitTime=1500; "
    }
  }
}
return config, "ID", key
