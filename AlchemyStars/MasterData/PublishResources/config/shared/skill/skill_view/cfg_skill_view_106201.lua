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
      " PlayCasterSacrificeTrapsLineRenderer,casterEffectID=3686,lineEffectID=3688,lineCasterBindPos=Bip001 R Hand,lineEffectWaitTime=1000,gridEffectID=3687,gridEffectWaitTime=900,lineEffectDuration=1300; PlaySacrificeTrapVisible,visible=0; Wait,waitTime=1600; "
    }
  }
}
return config, "ID", key
