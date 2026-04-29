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
      " PlayEntityLegacyAnimation,animNames=eff_2909401_skill03_out,casterEffectID=290940105; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1500,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain1; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1500,
    {
      " DataSelectResult,effectType=64,index=1; PlaySummonTrap,trapID=78,label=foreach; PlaySummonTrap,trapID=2000903; DataSelectNextResult,effectType=64; Jump,condition=CheckEffectResultIndex,param=64,goto=foreach; PlayDeleteCasterEffect,effectIDList=290940105; "
    }
  }
}
return config, "ID", key
