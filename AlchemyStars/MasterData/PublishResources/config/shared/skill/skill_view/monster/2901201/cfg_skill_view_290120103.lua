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
      " PlayDeleteWaringArea; PlayEffectAGridPos,effectID=3173,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=0; PlayCasterHUDVisible,visible=0; PlayAudio,audioID=6132,audioType=1; PlayCasterAnimation,animName=Skill04; PlayCameraEffect, effectID=3171; PlayCasterMaterialAnim,animName=eff_2901201_skill04_main; PlayCasterBindEffect,effectID=3174; PlayGridDark,darkType=0; Wait,waitTime=200; PlayRoleTeleport,type=11; PlayRole2Pos,posX=5,posY=5; Wait,waitTime=2400; AbyssEffectSp,effectMask=1613,effectBottom=3176,effectSide=3177,type=1; Wait,waitTime=300; PlaySummonTrapBySummonEveryThing,trapID=2901201; PlaySummonTrapBySummonEveryThing,trapID=2901202; PlaySummonTrapBySummonEveryThing,trapID=2901203; PlaySummonTrapBySummonEveryThing,trapID=2901204; AbyssEffectSp,effectMask=1613,effectBottom=3176,effectSide=3177,type=2; PlayCasterAnimation,animName=Skill04_1; PlayCasterAddBuff,buffID=29012017,remove=1; PlayCasterAddBuff,buffID=29012018; Wait,waitTime=450; PlayCasterVisible,visible=0; PlayRoleTeleport, type=5, onlySelf=0; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=400; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; "
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
      " PlayAudio,audioID=6127,audioType=1; PlayCasterBindEffect,effectID=3161; Wait,waitTime=500; PlayCasterBindEffect,effectID=3160; PlayCasterAnimation,animName = birth; PlayRoleTeleport,type=6; PlayCasterHUDVisible,visible=1; Wait,waitTime=300; PlayEffectAGridPos,effectID=3170,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=0; PlayGridDark,darkType=1; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    550,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
