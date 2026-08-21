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
      " PlayCasterAnimation,animName = skill01; PlayCasterBindEffect,effectID=150208108; PlayAudio,audioID = 8006,audioType=1; Wait,waitTime=2500; "
    }
  },
  {
    2,
    2,
    27,
    1,
    1,
    600,
    {
      hitAnim = "Hit",
      hitEffectID = 0,
      turnToTarget = 1
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap; Wait,waitTime=2500; "
    }
  }
}
return config, "ID", key
