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
      " PauseMove, matchers=MonsterID|PetPstID, moveAnim=1; DataSelectDamage,damageIndex = 1; PlayCasterLegacyAnimation,animNames=eff_2800311_skill_main; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2658,turnToTarget=0,deathClear=0; Wait,waitTime=200; ResumeMove, matchers=MonsterID|PetPstID, moveAnim=1; "
    }
  }
}
return config, "ID", key
