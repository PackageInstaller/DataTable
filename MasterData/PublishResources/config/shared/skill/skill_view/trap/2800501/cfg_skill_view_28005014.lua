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
      " PlayCasterBoneTurnToPlayer,bone=2800502_body_d02,duration=1000,block=0; Wait,waitTime=1000; PlayCasterBindEffect,effectID=3254; PlayAudio,audioID = 8006,audioType=1; "
    }
  },
  {
    2,
    2,
    27,
    2,
    1,
    0,
    {
      hitAnim = "Hit",
      hitEffectID = 0,
      turnToTarget = 1
    }
  }
}
return config, "ID", key
