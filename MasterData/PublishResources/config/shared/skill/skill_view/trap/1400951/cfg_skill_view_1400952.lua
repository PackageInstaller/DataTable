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
      " PlayAudio,audioID = 5002,audioType=1; Wait,waitTime=210; PlayEffectAtCasterPos,effectID=2361; DataSelectDamage,damageIndex = 1; PlayCommonBeHit; Wait,waitTime=100; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,trapID=14009512; "
    }
  }
}
return config, "ID", key
