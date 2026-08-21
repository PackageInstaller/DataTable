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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=1032; PlayAudio,audioID=2056; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; PlayCasterEffectHolder,effHolderType=Idle,isShow=1; PlayCasterEffectHolder,effHolderType=Charge,isShow=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
