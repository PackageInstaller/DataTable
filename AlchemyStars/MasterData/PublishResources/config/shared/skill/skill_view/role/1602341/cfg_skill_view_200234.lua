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
      " PlayCasterAnimation,animName = AtkChain; Wait,waitTime=600; PlayCasterBindEffect,effectID =160234103; PlayAudio,audioID = 160234102,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1800,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160234104,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160234103,audioType=1; Wait,waitTime=100; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    300,
    {
      " Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
