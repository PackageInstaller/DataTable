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
      " PlayAudio,audioID = 6244,audioType=1; PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=290400103; PlayCasterBindEffect,effectID=290400104; PlayCasterBindEffect,effectID=290400105; PlayBoss2904001Teleport,stockpileTimeMs=667,stockpileAnimTriggerName=Skill02_a,jumpTimeMs=933,jumpAnimTriggerName=Skill02_b,landTimeMs=1900,landAnimTriggerName=Skill02_c; Wait,waitTime=1500; "
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
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=3600; "
    }
  }
}
return config, "ID", key
