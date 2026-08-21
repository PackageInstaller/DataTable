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
      "PlayMonsterMoveGridByParam, attackAnimName=Skill01, attackEffectID=2438, attackAudioID=2280, attackAudioWaitTime=0, hitDelayTime=100, hitAnimName=Hit, hitEffectID=2439; "
    }
  }
}
return config, "ID", key
