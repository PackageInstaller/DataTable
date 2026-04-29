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
      " PlayCasterAnimation,animName = AtkUlt1; PlayEffectAtPickUpIndexGrid,effectID=160148409,pickUpIndex=1; Wait,waitTime=2000; PlayEffectAtPickUpIndexGrid,effectID=160148410,pickUpIndex=1; Wait,waitTime=550; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2628, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    2000,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    2100,
    {
      " PlayEntityVisible,visible=0,trapID=16014841; PlayEntityVisible,visible=0,trapID=16014842; PlayEntityVisible,visible=0,trapID=16014843; Wait,waitTime = 700; PlayEntityVisible,visible=1,trapID=16014841; PlayEntityVisible,visible=1,trapID=16014842; PlayEntityVisible,visible=1,trapID=16014843; PlayEntityLegacyAnimation,animNames=eff_1601484_atkult01_box,trapID=16014841; PlayEntityLegacyAnimation,animNames=eff_1601484_atkult01_box,trapID=16014842; PlayEntityLegacyAnimation,animNames=eff_1601484_atkult01_box,trapID=16014843; PlayEffectAtPickUpIndexGrid, effectID=160148406,pickUpIndex=1; "
    }
  }
}
return config, "ID", key
