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
      " PlayAudio,audioID = 2625,audioType=1; Wait,waitTime = 640; PlayCasterBindEffect,effectID = 160148405; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime = 1500; "
    },
    {"", "0,1"}
  },
  {
    2,
    2,
    0,
    1,
    1,
    800,
    {
      " PlayCasterVisible,visible=0; Wait,waitTime = 500; PlayEntityLegacyAnimation,animNames=eff_1601484_atkult01_box,trapID=16014841; PlayEntityLegacyAnimation,animNames=eff_1601484_atkult01_box,trapID=16014842; PlayEntityLegacyAnimation,animNames=eff_1601484_atkult01_box,trapID=16014843; PlayCasterBindEffect, effectID=160148406; PlayCasterVisible,visible=1;"
    }
  }
}
return config, "ID", key
