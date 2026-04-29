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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400161,waitTime = 2000;"
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
      " PlayAudio,audioID = 2478,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =3680; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " PlayTrapToCasterTrajectoryEff,effectID=3681,flyTime=500,trapIDList=160156100|160156101|160156102|160156103|160156104|160156105|160156106|160156107|160156108|160156109|160156110|160156111; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    100,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=3682,randomRotate=2,label=playRangeEffect; Wait,waitTime=60; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    100,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; Wait,waitTime=60; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    0,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap; "
    }
  },
  {
    7,
    7,
    0,
    2,
    1,
    600,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =43001560; PlayTargetAddBuff,buffEffectType =43031560; PlayTargetAddBuff,buffEffectType =43061560; PlayTargetAddBuff,buffEffectType =43101560; PlayTargetAddBuff,buffEffectType =43131560; PlayTargetAddBuff,buffEffectType =43161560; PlayTargetAddBuff,buffEffectType =43201560; PlayTargetAddBuff,buffEffectType =43231560; PlayTargetAddBuff,buffEffectType =43261560; PlayTargetAddBuff,buffEffectType =43301560; PlayTargetAddBuff,buffEffectType =43331560; PlayTargetAddBuff,buffEffectType =43361560; PlayTargetAddBuff,buffEffectType =4001561; PlayTargetAddBuff,buffEffectType =410156; PlayTargetAddBuff,buffEffectType =430015602; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; "
    }
  }
}
return config, "ID", key
