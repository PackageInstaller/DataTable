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
      " PlayCasterAnimation,animName=Atk03; PlayAudio,audioID =290920104,audioType=1; PlayCasterBindEffect,effectID=290920115; Wait,waitTime=800; PlayCasterLineToTarget,lineEffectID=290920117,lineOnCaster=Bone034,lineOnTarget=Hit,lineEffectDuration=900; Wait,waitTime=2100; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    800,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290920116,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
