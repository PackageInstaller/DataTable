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
      " PlayCasterAnimation,animName = skill03; PlayAudio,audioID=6269,audioType=1; PlayCasterBindEffect,effectID=290470110; PlayCasterBindEffect,effectID=290470111; PlayCasterMaterialAnim,animName = eff_2904701_skill03_mat; Wait,waitTime=730; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290470109,turnToTarget=1,deathClear=0; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
