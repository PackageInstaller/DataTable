local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7
}
local common = {
  {
    effectIDList = {3281}
  }
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
      " PlayCasterTurnToPlayer; PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID=3281; PlayAudio,audioID=6141,audioType=1; "
    }
  },
  {
    2,
    2,
    38,
    2,
    1,
    800,
    common[1]
  },
  {
    3,
    3,
    0,
    2,
    2,
    1,
    {
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID=3281,flyTime=600,flyTrace=1,targetPos=Hit,originalBoneName=Bip001 L Hand; "
    }
  },
  {
    4,
    4,
    38,
    2,
    3,
    1,
    common[1]
  },
  {
    5,
    5,
    0,
    2,
    4,
    0,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3282,turnToTarget=1,deathClear=0; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
