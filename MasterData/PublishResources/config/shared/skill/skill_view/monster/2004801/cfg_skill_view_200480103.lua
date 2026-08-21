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
      " PlayAudio,audioID = 6036,audioType=1; PlayCasterBindEffect,effectID=200480102; PlayCasterAnimation,animName=Skill_1; PlayRoleTeleport, type=3; PlayFlyEffectCasterToTarget,flyEffectID=200480104,flyTime=270,flyTrace=1,teleportPosAsTarget=1,finalWaitTime=100,isBlock=0; Wait,waitTime=260; PlayRoleTeleport, type=5,onlySelf=1; PlayRoleTeleport, type=6; PlayCasterAnimation,animName=Skill_2; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    200,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200480103,turnToTarget=1,deathClear=false,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
