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
      " PlayAudio,audioID = 2396,audioType=1; PlayCasterAnimation,animName = Skill01; Wait,waitTime=350; PlayCasterBindEffect,effectID = 200370102; Wait,waitTime=1600; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    500,
    {
      " DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 200370103,flyTime = 100,flyTrace = 1,offsetx=0.16,offsety=0.98,isBlock =0,targetPos=Hit,label=hitAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=hitAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    600,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200370101,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    23,
    1,
    3,
    500,
    {showTime = 0}
  }
}
return config, "ID", key
