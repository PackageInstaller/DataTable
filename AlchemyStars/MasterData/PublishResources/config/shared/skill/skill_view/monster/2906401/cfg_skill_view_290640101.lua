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
      " PlayCasterTurnToPlayer; PlayCasterAnimation,animName=Atk1; PlayCasterBindEffect,effectID =290640102; PlayAudio,audioID = 290640101,audioType=1; Wait,waitTime=1000; DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=500; PlayCasterAddBuff,buffID=290640102; "
    }
  }
}
return config, "ID", key
