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
      " PlayCasterAnimation,animName = Death; PlayCasterBindEffect,effectID=1124; PlayDeadEffect,deadType = 1; Wait,waitTime=800; StopCasterMaterialAnim,animName=2000431_shader_effects; PlayAudio,audioID = 7007,audioType=1; Wait,waitTime=500; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    300,
    {
      " PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; "
    }
  }
}
return config, "ID", key
