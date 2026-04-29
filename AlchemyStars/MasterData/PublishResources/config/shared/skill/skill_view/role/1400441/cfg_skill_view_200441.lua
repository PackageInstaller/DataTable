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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =781; PlayAudio,audioID = 2129; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    850,
    {
      " DataSelectDamage,damageIndex = 1; PlayCasterEffectAtTargetPos,effectID=782,randomDir=1,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=783,turnToTarget=1,deathClear=0; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
