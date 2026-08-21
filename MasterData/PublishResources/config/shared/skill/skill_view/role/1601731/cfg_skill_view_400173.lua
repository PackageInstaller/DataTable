local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayPetMinosGhostDamage, ghostEffectID=160173109, ghostAttackWaitTime=600, ghostLineEffectID=160173110, ghostHitEffectID=160173111, lineSpeed=150, hitAnimName=Hit, ghostAttackAudioID=6199, ghostAttackAudioWaitTime=150, ghostLineOffsetX=0.057,ghostLineOffsetY=0.972,ghostLineOffsetZ=0.86; "
    }
  }
}
return config, "ID", key
