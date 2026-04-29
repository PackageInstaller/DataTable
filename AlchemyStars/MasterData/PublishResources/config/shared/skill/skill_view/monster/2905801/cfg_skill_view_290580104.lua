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
      " PlayCasterBindEffect,effectID = 290580109; PlayAudio,audioID =290580105,audioType=1; Wait,waitTime=1150; PlayCameraEffect,effectID=290580110; Wait,waitTime=6000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayCasterAnimation,animName=Atk4; Wait,waitTime=3300; Wait,waitTime=1000; PlayCasterAnimation,animName=Atk4_1; Wait,waitTime=1167; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    4000,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
