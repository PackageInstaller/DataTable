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
      " PlayCasterAnimation,animName =Atk; PlayAudio,audioID=290620106,audioType=1; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=2000; "
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
      " PlaySummonTrap,trapID=54130112; PlayAudio,audioID=290620105,audioType=1; PlayCasterBindEffect,effectID=290620109; Wait,waitTime=500; PlayCasterAnimation,animName =Skill01; PlayRoleTeleport, type=3; Wait,waitTime=200; PlayRoleTeleport, type=5; PlayRoleTeleport, type=6; PlayCasterAnimation,animName =Skill02; PlayCasterBindEffect,effectID=290620110; "
    }
  }
}
return config, "ID", key
