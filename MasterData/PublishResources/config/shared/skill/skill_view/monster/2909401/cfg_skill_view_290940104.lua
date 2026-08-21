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
      " PlayCasterAnimation,animName = Skill2; PlayCasterBindEffect,effectID =290940107; PlayEffectAtCasterPos,effectID=290940108; PlayAudio,audioID = 290940104; Wait,waitTime=3300; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    700,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290940103,turnToTarget=1,deathClear=0,label=doAgain1; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; "
    }
  }
}
return config, "ID", key
