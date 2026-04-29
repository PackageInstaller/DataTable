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
      " PlayCasterTurnToPlayer; PlayCasterAnimation,animName=skill01; PlayAudio,audioID =6099,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=800; PlayCasterBindEffect,effectID=PARAM.effectID1; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1300,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
