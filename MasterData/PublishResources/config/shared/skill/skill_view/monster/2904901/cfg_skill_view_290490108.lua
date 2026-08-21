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
      " PlayAudio,audioID=6255,audioType=1; PlayCasterAnimation,animName=Skill02; PlayCasterBindEffect,effectID=290490106; DataSelectDamage,damageIndex = 1; PlayWaitWithCasterAndTargetDis,baseTime=760,oneGridTime=40; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
