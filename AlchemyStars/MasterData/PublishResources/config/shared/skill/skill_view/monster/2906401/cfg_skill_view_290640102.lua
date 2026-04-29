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
      " PlayAudio,audioID =2302,audioType=1; Wait,waitTime=500; PlayCasterAnimation,animName = Atk2; PlayCasterBindEffect,effectID=290640104; Wait,waitTime=550; PlayCasterBindEffect,effectID=290640103; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,deathClear=0; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
