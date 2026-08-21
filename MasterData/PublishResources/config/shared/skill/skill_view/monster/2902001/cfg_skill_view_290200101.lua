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
      " PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=3371; PlayAudio,audioID=6170,audioType=1; Wait,waitTime=300; PlayRoleTeleport,type=3; PlayFlyEffectCasterToTarget,flyEffectID=3373,flyTime=500,flyTrace=1,teleportPosAsTarget=1; PlayRoleTeleport,type=5; PlayCasterTurnToPlayer; PlayRoleTeleport,type=6; PlayCasterBindEffect,effectID=3372; "
    }
  },
  {
    2,
    2,
    0,
    2,
    0,
    300,
    {
      " DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; "
    }
  },
  {
    3,
    3,
    27,
    2,
    2,
    0,
    {
      hitAnim = "Hit",
      hitEffectID = 0,
      turnToTarget = 1
    }
  }
}
return config, "ID", key
