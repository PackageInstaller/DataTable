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
      " PlaySPPetPreviewEffectAnimationByEffectID,petID=1702361,,effectID=17023612,anim=eff_1702361_ult_scene_out,skillID=3302361; PlaySPPetPreviewEffectAnimationByEffectID,petID=1702361,effectID=17023613,anim=eff_1702361_ult_gezi_out,skillID=3302361; Wait,waitTime=500; DeleteSPPetPreviewEffectAnimation,petID=1702361,skillID=3302361; "
    }
  }
}
return config, "ID", key
