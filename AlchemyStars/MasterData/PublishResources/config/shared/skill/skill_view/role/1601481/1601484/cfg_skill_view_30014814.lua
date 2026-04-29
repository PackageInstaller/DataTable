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
      " PlayCasterBindEffect,effectID = 160148411; Wait,waitTime=350; PlayCasterBindEffect,effectID = 160148412; Wait,waitTime=1500; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2629, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    700,
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
    700,
    {
      " PlayCasterVisible,visible=0; Wait,waitTime = 500; PlayCasterVisible,visible=1; PlayEntityLegacyAnimation,animNames=eff_1601484_atkult01_box,trapID=16014841; PlayEntityLegacyAnimation,animNames=eff_1601484_atkult01_box,trapID=16014842; PlayEntityLegacyAnimation,animNames=eff_1601484_atkult01_box,trapID=16014843; PlayCasterBindEffect,effectID = 160148406; "
    }
  }
}
return config, "ID", key
