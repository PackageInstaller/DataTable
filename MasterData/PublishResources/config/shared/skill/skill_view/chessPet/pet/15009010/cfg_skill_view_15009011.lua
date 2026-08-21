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
      " PlayCasterBindEffect,effectID=1701; PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=1000; PlayAudio,audioID = 3105,audioType=1; Wait,waitTime=1800; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,label=doAgain; PlayTargetAddBuff,buffID=10015,remove=1,stageIndex=1; PlayTargetAddBuff,buffID=10015,stageIndex=2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
