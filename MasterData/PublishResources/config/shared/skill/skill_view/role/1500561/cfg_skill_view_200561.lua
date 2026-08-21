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
      " DataSelectDamage,damageIndex = 1; PlayCasterTurnToTarget; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =2394; PlayAudio,audioID = 2244,audioType=1; Wait,waitTime=4000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1700,
    {
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 2395,flyTime = 100,flyTrace = 1,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2396,turnToTarget=1,deathClear=0; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
