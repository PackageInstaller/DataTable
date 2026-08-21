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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1500151,waitTime = 2000;"
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
      " DataSelectResult,effectType=1,index=1; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName=AtkUlt; PlayCasterBindEffect,effectID=3148; PlayCasterBindEffect,effectID=3149; PlayCreateCasterGhost,DisableAlpha=1,Type=PickUpRotate,Prefab=1500152.prefab,Anim=AtkUlt,BornEffectID=3150; PlayAudio,audioID = 2368; Wait,waitTime=3900; PlayDeleteGhost; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2500,
    {
      " DataSelectResult,effectType=1,index=1; PlayCasterToPickupToReflect,effectID=3151,flyTime=260,flySpeed=33; PlayAudio,audioID = 3009; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2500,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3152,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
