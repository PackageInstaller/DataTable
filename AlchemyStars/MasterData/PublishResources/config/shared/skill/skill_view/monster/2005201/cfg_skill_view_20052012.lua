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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID= 200520103; PlayAudio,audioID=200520102,audioType=1; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200520102,turnToTarget=1,deathClear=0; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
