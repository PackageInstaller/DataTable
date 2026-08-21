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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=PARAM.effectID2; PlayCasterBindEffect,effectID=PARAM.effectID1; Wait,waitTime=500; PlayAudio,audioID = 7020,audioType=1; Wait,waitTime=1000; PlayCommonBeHit,hitAnimName=Hit,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
