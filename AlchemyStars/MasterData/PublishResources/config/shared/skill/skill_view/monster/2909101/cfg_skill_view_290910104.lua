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
      " PlayCasterAnimation,animName = skill03; PlayCasterBindEffect,effectID=290910105; PlayAudio,audioID = 29091014,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2000,
    {
      " PlaySummonTrap,trapID=2809101; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2000,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
