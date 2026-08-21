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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID =1601721,waitTime =2000; "
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
      " PlayAudio,audioID = 2542,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =160172107; Wait,waitTime=1300; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=300; PlayRoleTeleport,type=6, onlySelf=1; PlayRoleTeleport,type=9, onlySelf=1; PlayCasterAnimation,animName = AtkUlt1; PlayCasterBindEffect,effectID =160172108; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2300,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=0; PlayGridEffectByRandom,effectID=160172110,intervalTime=100,randomCount=3; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2300,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=100; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
