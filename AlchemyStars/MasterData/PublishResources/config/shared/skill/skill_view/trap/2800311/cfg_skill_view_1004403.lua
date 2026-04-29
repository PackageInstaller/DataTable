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
      " Jump,condition=CheckEffectMultiResultIndex,param=79|1,result=0,goto=phaseEnd; PlayCasterLegacyAnimation,animNames=eff_2800311_skill_main; Wait,waitTime=500; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2658,turnToTarget=0,deathClear=0; Wait,waitTime=100; PlayCasterLegacyAnimation,animNames=eff_2800311_skill_idle; "
    }
  }
}
return config, "ID", key
