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
      " PlaySummonTrap,trapID=14,interval=0,effectID=480; PlaySummonDeadTrap,trapID=29050012,interval=0,effectID=0; "
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
      " PlaySummonMonsterBySummonEveryThing,monsterID=70011322,interval=0; "
    }
  }
}
return config, "ID", key
