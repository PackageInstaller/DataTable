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
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; TankTowerLookAtDamageTarget,time=400; PlayAudio,audioID=7046,audioType=1; PlayCasterAnimation,animName=Skill02; PlayCasterBindEffect,effectID=200290104; Wait,waitTime=180; PlayCasterBindEffect,effectID=200290105; Wait,waitTime=270; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200290106,turnToTarget=0,deathClear=false,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
