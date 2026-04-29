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
      " PlayCasterAnimation,animName = skill01; PlayCasterBindEffect,effectID = 150208109; PlayCasterMaterialAnim,animName=effanim_15020811_skill_02_m; Wait,waitTime = 1100; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=150208110,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime = 2000; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2677, audioType = 1}
  }
}
return config, "ID", key
