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
      " PlayCasterAnimation,animName = skill01; PlayCasterBindEffect,effectID=150208111; PlayCasterMaterialAnim,animName=effanim_15020811_skill_03_m; PlayAudio,audioID = 2678,audioType=1; Wait,waitTime=900; PlayMultiTraction; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2100,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=150208110,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime = 2000; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; "
    }
  }
}
return config, "ID", key
