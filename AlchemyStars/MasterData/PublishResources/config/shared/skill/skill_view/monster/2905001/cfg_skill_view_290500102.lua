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
      " Jump,condition=CheckHasTeleport,param=0,goto=phaseEnd; Wait,waitTime=1000; PlayCasterBindEffect,effectID =290500105; PlayCasterBindEffect,effectID =290500106; PlayCasterAnimation,animName=skill01; PlayAudio,audioID = 6273,audioType=1; Wait,waitTime=2000; PlayRoleTeleport,type=3, onlySelf=1; "
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
      " PlaySummonTrap,trapID=29050013,effectID=290500113,interval=100,waitFinish=1; "
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
      " Jump,condition=CheckHasTeleport,param=0,goto=phaseEnd; PlayRoleTeleport,type=5, onlySelf=1; PlayRotateResult; PlayChangeBodyArea; PlayRoleTeleport,type=6, onlySelf=1; PlayRoleTeleport,type=9, onlySelf=1; PlayCasterAnimation,animName=skill01(1); Wait,waitTime=2000; PlayCasterBindEffect,effectID =290500108; PlayCasterAnimation,animName=skill01(2); PlayCasterBindEffect,effectID =290500107; Wait,waitTime=2000; "
    }
  },
  {
    4,
    4,
    0,
    2,
    2,
    3000,
    {
      " PlayAudio,audioID = 5078,audioType=1; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200240103,turnToTarget=1,deathClear=0; Wait,waitTime=700; "
    }
  }
}
return config, "ID", key
