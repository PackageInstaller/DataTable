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
      " PlayCasterAnimation,animName = skill01; PlayCasterBindEffect,effectID=290910101; PlayAudio,audioID = 29091012,audioType=1; Wait,waitTime=2700; "
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
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290910102,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    700,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=290910101,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
