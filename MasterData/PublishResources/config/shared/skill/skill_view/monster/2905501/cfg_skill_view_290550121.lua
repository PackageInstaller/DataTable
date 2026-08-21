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
      " PlayCasterTurnToPlayer; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID=2615,audioType=1; PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=160191103; PlayCasterMaterialAnim,animName=eff_1601911_atkchain_chuxian; Wait,waitTime=410; PlayRoleTeleport, type=5; PlayCasterBindEffect,effectID=160191104; PlayCasterTurnToPlayer; Wait,waitTime=50; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; Wait,waitTime=430; PlayAudio,audioID=2616,audioType=1; Wait,waitTime=300; "
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
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=600; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    100,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex = 2; DataSelectScopeGridRange,effectType=1,damageInfoIndex=2; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160191105,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,damageStageIndex = 2; Wait,waitTime=150; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
