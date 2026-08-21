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
      " PlayCasterAnimation,animName = skill04; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayAudio,audioID =6098,audioType=1; Wait,waitTime=1600; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID2,turnToTarget=1,deathClear=0; Wait,waitTime=100; PlaySummonTrap,trapID=61; PlayAudio,audioID =7019,audioType=1; "
    }
  }
}
return config, "ID", key
