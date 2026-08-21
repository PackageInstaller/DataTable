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
      " PlayEffectAtCasterPos, effectID=1206; PlayLayerHPAnimation,animClipNameMap=1|eff_2900443_skill01_shitou_02_a|0|eff_2900443_skill01_shitou_04_a; "
    }
  }
}
return config, "ID", key
