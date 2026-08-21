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
      " PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 6009,audioType=1; PlayCasterBindEffect,effectID=1249; Wait,waitTime=1500; Wait,waitTime=1000; PlayEffectAGridPos,effectID=1251,gridPosX=5,gridPosY=4; Wait,waitTime=2000; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=2100; PlayCasterBindEffect,effectID=1250; Wait,waitTime=100; PlayCasterAnimation,animName = Idle; "
    }
  }
}
return config, "ID", key
