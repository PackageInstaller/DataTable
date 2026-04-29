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
      " PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterAnimation,animName = Birth; PlayAudio,audioID=6089,audioType=1; PlayCasterBindEffect,effectID=2779; Wait,waitTime=3666; "
    }
  },
  {
    2,
    2,
    27,
    1,
    0,
    2000,
    {
      hitAnim = "Hit",
      hitEffectID = 0,
      turnToTarget = 1
    }
  }
}
return config, "ID", key
