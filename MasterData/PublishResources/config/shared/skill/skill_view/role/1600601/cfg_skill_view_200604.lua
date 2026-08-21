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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =1781; PlayCasterBindEffect,effectID =1782; PlayCasterBindEffect,effectID =1784; PlayAudio,audioID =3112; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1600,
    {
      " DataSelectDamage,damageIndex = 1; PlayCasterEffectAtTargetPos,effectID=1780,randomDir=1,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=200; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
