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
      " PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayAudio,audioID =7015,audioType=1; Wait,waitTime=330; PlaySummonTrap,trapID=PARAM.trapID1; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=330; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID2,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
