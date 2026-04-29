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
    100,
    {
      " PlaySummonDeadTrap,trapID=29050012,interval=0,effectID=0; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    2000,
    {
      " PlayEntityAnimation,animName=birth,trapID=29050012; PlayEntityBindEffect , effectID=290500114,trapID=29050012; PlayAudio,audioID = 6256,audioType=1; PlayTargetMaterialAnim,animName=effanim_29050012_birth; Wait,waitTime=2500; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,delay=0,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2000,
    {
      " PlaySummonMonsterBySummonEveryThing,monsterID=20024013,interval=0; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " PlayCasterBindEffect,effectID =290500105; PlayCasterBindEffect,effectID =290500106; PlayCasterAnimation,animName=skill01; PlayAudio,audioID = 6273,audioType=3; Wait,waitTime=2000; PlayStageTeleport,type=3, onlySelf=1,stageIndex=3; PlayCasterControlGridDown,enable=0; "
    }
  },
  {
    5,
    5,
    100,
    2,
    4,
    0,
    {
      stageIndex = 2,
      teleportAnim = "skill03",
      teleportStartWaitTime = 300,
      jumpEffectID = 200240104,
      teleportTime = 300,
      teleportFinishWaitTime = 733,
      moveAnim = "skill04",
      moveEffectID = 200240105,
      moveSpeed = 16,
      flyOneTime = 50,
      hitEffectID = 200240106
    }
  },
  {
    6,
    6,
    0,
    2,
    4,
    0,
    {
      " Wait,waitTime=500; PlayAudio,audioID = 6258,audioType=1; "
    }
  },
  {
    7,
    7,
    0,
    2,
    5,
    0,
    {
      " PlayStageTeleport,type=5, onlySelf=1,stageIndex=3; PlayRotateResult; PlayChangeBodyArea; PlayStageTeleport,type=6, onlySelf=1,stageIndex=3; PlayCasterBindEffect,effectID =290500107; PlayCasterBindEffect,effectID =290500108; PlayCasterAnimation,animName=skill01(2); PlayCasterControlGridDown,enable=1; Wait,waitTime=1700; PlayStageTeleport,type=9, onlySelf=1,stageIndex=3; "
    }
  }
}
return config, "ID", key
