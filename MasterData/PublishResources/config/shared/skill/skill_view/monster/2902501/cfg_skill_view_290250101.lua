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
      " PlayMonsterMoveGridN18Minos,ghostEffectID=3655,ghostAttackWaitTime=600,lastCastEffectID=3656,ghostLineEffectID=3657,castLineEffectID=3658,castAttackWaitTime=900,ghostHitEffectID=3659,castHitEffectID=3660,lineSpeed=150,attackAnimName=Skill01,ghostAttackAudioID=6199,ghostAttackAudioWaitTime=250,castAttackAudioID=6200,castAttackAudioWaitTime=0,ghostLineOffsetX=0.057,ghostLineOffsetY=0.972,ghostLineOffsetZ=0.86,castLineOffsetX=0.114,castLineOffsetY=1.004,castLineOffsetZ=0.778; "
    }
  }
}
return config, "ID", key
