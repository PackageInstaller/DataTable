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
      " PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=3377; PlayAudio,audioID=6173,audioType=1; Wait,waitTime=300; PlayRoleTeleport,type=3; PlayFlyEffectCasterToTarget,flyEffectID=3373,flySpeed=200,flyTrace=1,teleportPosAsTarget=1; PlayRoleTeleport,type=5; PlayCasterTurnToPlayer; PlayRoleTeleport,type=6; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=3378; "
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
  },
  {
    3,
    3,
    34,
    2,
    2,
    0,
    {
      showTimeDelay = 0,
      gridEffectID = 3372,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0
    }
  }
}
return config, "ID", key
