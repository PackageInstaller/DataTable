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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Skill01; Wait,waitTime=600; PlayAudio,audioID = 7023,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID1; Wait,waitTime=200; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID2,turnToTarget=1,deathClear=0; Wait,waitTime=100; PlayTargetAddBuff,buffID=10011; PlaySummonTrap,trapID=60; "
    }
  }
}
return config, "ID", key
