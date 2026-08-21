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
      " PlayAudio,audioID = 2477,audioType=1; PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =3673; Wait,waitTime=700; PlayCasterBindEffect,effectID =3672; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1900,
    {
      " PlayCasterToPickupTrajectory,effectID=3674,flyTime=500; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1950,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=3675,randomRotate=2,label=playRangeEffect; Wait,waitTime=60; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    1950,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; Wait,waitTime=60; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    2000,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =4300156; PlayTargetAddBuff,buffEffectType =4303156; PlayTargetAddBuff,buffEffectType =4306156; PlayTargetAddBuff,buffEffectType =4310156; PlayTargetAddBuff,buffEffectType =4313156; PlayTargetAddBuff,buffEffectType =4316156; PlayTargetAddBuff,buffEffectType =4320156; PlayTargetAddBuff,buffEffectType =4323156; PlayTargetAddBuff,buffEffectType =4326156; PlayTargetAddBuff,buffEffectType =4330156; PlayTargetAddBuff,buffEffectType =4333156; PlayTargetAddBuff,buffEffectType =4336156; PlayTargetAddBuff,buffEffectType =4001560; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff;"
    }
  },
  {
    7,
    7,
    0,
    2,
    1,
    2400,
    {
      " PlaySummonTrap,trapID=160156100; PlaySummonTrap,trapID=160156101; PlaySummonTrap,trapID=160156102; PlaySummonTrap,trapID=160156103; PlaySummonTrap,trapID=160156104; PlaySummonTrap,trapID=160156105; PlaySummonTrap,trapID=160156106; PlaySummonTrap,trapID=160156107; PlaySummonTrap,trapID=160156108; PlaySummonTrap,trapID=160156109; PlaySummonTrap,trapID=160156110; PlaySummonTrap,trapID=160156111; PlayEffectAtPickUpIndexGrid,effectID=3676,pickUpIndex=1; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =403156; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; "
    }
  }
}
return config, "ID", key
