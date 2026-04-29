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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName =Skill03; PlayAudio,audioID = 5023,audioType=1; PlayCasterBindEffect,effectID=3567; PlayCasterBindEffect,effectID=3568; PlayCasterBindEffect,effectID=3569; Wait,waitTime=1200; PlayCasterBindEffect,effectID=3570; Wait,waitTime=100; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
