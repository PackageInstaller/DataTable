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
      " PlayMonsterMoveGridByParam, attackAnimName=Skill01, attackEffectID=2465, attackAudioID=2271, attackAudioWaitTime=33, hitDelayTime=133, hitAnimName=Hit, hitEffectID=2463; "
    }
  }
}
return config, "ID", key
