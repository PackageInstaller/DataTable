local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayCasterTurnToTarget; PlayCasterAnimation,animName = AtkChain2; PlayCasterBindEffect,effectID =160182106; PlayCasterBindEffect,effectID = 160182107; PlayCasterBindEffect,effectID = 160182110; PlayCasterMaterialAnim,animName=eff_1601821_chain2_mat; PlayAudio,audioID = 2590,audioType=1; Wait,waitTime = 3800; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayPet1601821ChainJumpDamage, casterAnimateTrigger=AtkChain2, jumpTimeMs=460, landingTimeMs=1000, centerGridEffectID=160182109, gridRangeWaitTimeMs=50, damageGridEffectID=160182108, waitDamageTimeMs=230; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1000,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =4001821; PlayTargetAddBuff,buffEffectType =4001822; PlayTargetAddBuff,buffEffectType =4001823; PlayTargetAddBuff,buffEffectType =4001820; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff;"
    }
  }
}
return config, "ID", key
