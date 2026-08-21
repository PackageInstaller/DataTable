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
      " PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=0; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; PlayCasterAnimation,animName=BirthEmpty; PlayCasterMaterialAnim,animName=PARAM.animName1; Wait,waitTime=330; PlayCasterBindEffect,effectID=200260102; Wait,waitTime=1170; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=200260101; PlayCasterBindEffect,effectID=200260114; PlayCasterBindEffect,effectID=200260117; PlayCasterMaterialAnim,animName=PARAM.animName2; Wait,waitTime=100; PlayCasterBindEffect,effectID=200260103; Wait,waitTime=400; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
