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
      " PlayCasterControlGridDown,enable=0; PlayCasterControlOutLine,enable=0; PlayEffectAGridPos,effectID=290340110,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=0; Wait,waitTime=400; PlayMonsterTrajectoryBirth,effectID=290340114,pos=5|5,offset=0|0.7|0,flyTime=1000,block=0; Wait,waitTime=800; PlayCasterBindEffect,effectID=290340111; PlayCasterBindEffect,effectID=290340106; PlayCasterVisible,visible=1; PlayCasterMaterialAnim,animName=effanim_2903401_birth; PlayCasterAnimation,animName = Birth; Wait,waitTime=350; PlayCasterHUDVisible,visible=1; PlayCasterControlGridDown,enable=1; PlayCasterControlOutLine,enable=1; DataSelectBuff,buffIndex=1; Wait,waitTime=2000; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; PlayTargetAddBuff,buffID=PARAM.buffID2; PlayTargetAddBuff,buffID=PARAM.buffID3; PlayTargetAddBuff,buffID=PARAM.buffID4; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=1000; "
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
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    200,
    {
      " PlayAudio,audioID =6240,audioType=1; DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=290340104,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    500,
    {
      " PlaySummonTrap,trapID=PARAM.trapID1; PlayTrapAreaOutline,effectID=3601,trapType=17; "
    }
  }
}
return config, "ID", key
