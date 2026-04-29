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
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterAnimation,animName = skill01; PlayAudio,audioID = 7050,audioType=1; PlayCasterBindEffect,effectID=200310101; Wait,waitTime=400; DataSelectDamageInfo,damageInfoIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200310102,turnToTarget=1,deathClear=false; Wait,waitTime=480; "
    }
  }
}
return config, "ID", key
