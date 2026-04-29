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
      " PlayCasterTurnToPlayer; PlayCasterAnimation,animName=Skill02; PlayCasterBindEffect,effectID =200450101; PlayAudio,audioID = 200450101,audioType=1; Wait,waitTime=1200; DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290630102,turnToTarget=1,deathClear=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290630102,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; PlayCasterAddBuff,buffID=200460102; "
    }
  }
}
return config, "ID", key
