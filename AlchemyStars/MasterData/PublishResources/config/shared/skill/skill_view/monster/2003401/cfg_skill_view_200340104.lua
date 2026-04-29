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
      " PlayAudio,audioID=7049,audioType=1; PlayCasterAnimation,animName=Skill02; PlayCasterBindEffect,effectID=200340105; Wait,waitTime=800; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    440,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200340106,turnToTarget=1,deathClear=false,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
