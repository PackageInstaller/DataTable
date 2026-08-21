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
      " Jump,condition=CheckHasRotate,result=0,goto=phaseEnd; PlayCasterBindEffect,effectID =290500105; PlayCasterBindEffect,effectID =290500106; PlayCasterAnimation,animName=skill01; Wait,waitTime=2700; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayRotateResult; PlayChangeBodyArea; PlayRoleTeleport,type=6, onlySelf=1; PlayRoleTeleport,type=9, onlySelf=1; PlayCasterAnimation,animName=skill01(1); Wait,waitTime=2000; PlayCasterAnimation,animName=skill01(2); PlayCasterBindEffect,effectID =290500107; PlayCasterBindEffect,effectID =290500108; Wait,waitTime=2000; "
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
      " PlayAudio,audioID = 6274,audioType=1; PlayCasterAnimation,animName =skill02; PlayCasterBindEffect,effectID =290500111; Wait,waitTime=1100; PlayFlyEffectCasterToTeam,flyEffectID=290500110,offsety=0.5,flySpeed=50,targetPos=Hit,startWaitTime=0,hitEffectID=290500109; PlaySummonTrapBySummonEveryThing,trapID=29050014,effectID=290500104; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    1000,
    {
      " Wait,waitTime=1000; PlaySummonTrapBySummonEveryThing,trapID=29050012,effectID=0; "
    }
  }
}
return config, "ID", key
