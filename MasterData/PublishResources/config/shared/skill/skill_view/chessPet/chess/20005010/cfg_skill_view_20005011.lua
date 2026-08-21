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
      " PlayCasterAnimation,animName = Skill01; PlayCasterBindEffect,effectID=2004; PlayAudio,audioID = 7014,audioType=1; Wait,waitTime=500; DataSelectResult,effectType=67,index=1; Jump,condition=CheckEffectResultIndex,param=67,result=0,goto=phaseEnd; DataSelectDamage,damageIndex=1; PlayHookTractionTarget,hookEffectID=2008,chainEffectID=2016,hookUnitGridTime=70,tractionUnitGridTime=70,hitAnimName=Hit,hitEffectID=2012,turnToTarget=1,deathClear=0,moveSpeed=9; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
