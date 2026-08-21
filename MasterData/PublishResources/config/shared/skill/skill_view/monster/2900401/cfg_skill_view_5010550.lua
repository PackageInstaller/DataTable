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
      " PlayCasterRefreshAntiAttack; PlayCasterAnimation,animName = Skill05; Wait,waitTime=600; PlayCasterAddBuff, buffEffectType =3001; PlayCasterRefreshAntiAttack; "
    }
  }
}
return config, "ID", key
