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
      " PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID=PARAM.Disappear; PlayAudio,audioID = 7034,audioType=1; Wait,waitTime=400; PlayCasterShowLineRenderer,show=0; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=400; PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=PARAM.Appear; Wait,waitTime=200; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterShowLineRenderer,show=1; PlayCasterAnimation,animName=Skill01_1; Wait,waitTime=200; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterAnimation,animName = Skill02; PlayAudio,audioID = 7035,audioType=1; Wait,waitTime=700; PlayCasterBindEffect,effectID=PARAM.Atk01; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID=PARAM.Atk02,flyTime=400,flyTrace=1,offsety=0.4,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.Atk03,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
