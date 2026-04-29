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
      " PlayAudio,audioID = 20039011,audioType=1; PlayCasterTurnToPlayer; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=200390103; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1050,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200390104,turnToTarget=1,deathClear=false,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
