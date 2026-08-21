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
      " PlayCasterBindEffect,effectID=3020; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 2336,audioType=1; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayPeacockChainHit,casterEffectID=3021,characterSlots=-0.82/3.05/0.32|1.03/3.11/-0.34|0.2/3.14/-1.47|0.43/2.72/0.42,hitPosTrailEffectID=3022,trailDelay=900,hitAnimName=Hit,hitGridEffectID=3023,hitDelay=100,turnToTarget=1,deathClear=0,label=Hit; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=Hit; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
