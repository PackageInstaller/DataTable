local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID = 290890105,audioType=1; PlayVoice,voiceID=8910048; PlayCasterBindEffect,effectID=290890108; PlayCasterBindEffect,effectID=290890111; PlayCasterAnimation,animName = Skill02; DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=290890110,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;"
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2300,
    {
      " PlayCasterAnimation,animName = Skill02_01; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
