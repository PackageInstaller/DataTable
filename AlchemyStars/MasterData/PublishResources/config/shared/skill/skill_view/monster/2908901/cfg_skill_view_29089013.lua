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
      "PlayCasterBindEffect,effectID=290890112; PlayCasterBindEffect,effectID=290890113; PlayVoice,voiceID=8910049; PlayCasterAnimation,animName = Skill03; Wait,waitTime=2800; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=3000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1000,
    {
      "PlayAudio,audioID = 290890106,audioType=1;"
    }
  }
}
return config, "ID", key
