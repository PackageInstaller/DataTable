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
      " PlayCasterLegacyAnimation,animNames=effanim_1602371_beidong_main_out; Wait,waitTime = 1000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    100,
    {
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 160237103,flyTime = 300,flyTrace = 1,offsety=0.77,targetoffsety=0.77,isBlock =0,label=hitAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=hitAgain; Wait,waitTime = 170; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160237104,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime = 200; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; "
    }
  }
}
return config, "ID", key
