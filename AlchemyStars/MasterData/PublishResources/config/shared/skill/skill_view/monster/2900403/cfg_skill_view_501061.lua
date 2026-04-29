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
      " PlayCasterAnimation,animName = Skill02; PlayAudio,audioID = 6038,audioType=1; Wait,waitTime=500; PlayCasterBindEffect,effectID=PARAM.effectID1; Wait,waitTime=2300; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=300; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
