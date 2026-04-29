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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterMaterialAnim,animName=eff_1601201_atkchain_skin; PlayCasterBindEffect,effectID = 3133; Wait,waitTime = 1000; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2364, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    1500,
    {
      "DataSelectDamage,damageIndex = 1,damageStageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3132,turnToTarget=0,deathClear=0,label=doAgain; Wait,waitTime=20; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;"
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      "DataSelectDamage,damageIndex = 1,damageStageIndex = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3132,turnToTarget=0,deathClear=0,label=doAgain; Wait,waitTime=20; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;"
    }
  }
}
return config, "ID", key
