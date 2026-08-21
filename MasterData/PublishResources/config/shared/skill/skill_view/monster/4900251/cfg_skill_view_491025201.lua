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
      " DataSelectDamage,damageIndex = 1; DataSelectDamageInfo,damageInfoIndex = 1; PlayCasterAnimation,animName = Atk; PlayAudio,audioID = 5022,audioType=1; PlayCasterBindEffect,effectID =662; Wait,waitTime=120; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=648,turnToTarget=1,deathClear=0; Wait,waitTime=900; DataSelectDamageInfo,damageInfoIndex = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=648,turnToTarget=1,deathClear=0; Wait,waitTime=900; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterAnimation,animName =Skill02_copy; PlayAudio,audioID = 5026,audioType=1; PlayCasterBindEffect,effectID=655; PlayMakePhantom,flyDuration=1000,eftID=657,eftPosYa=2.4,eftPosYb=0.7; "
    }
  }
}
return config, "ID", key
