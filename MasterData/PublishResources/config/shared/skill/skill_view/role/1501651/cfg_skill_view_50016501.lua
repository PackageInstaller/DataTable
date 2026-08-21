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
      " PlayAudio,audioID = 2506,audioType=1; Wait,waitTime=210; PlayEffectAtCasterPos,effectID=3804; DataSelectDamage,damageIndex = 1; PlayCommonBeHit; Wait,waitTime=100; DataSelectResult,effectType=79,index=1; "
    }
  }
}
return config, "ID", key
