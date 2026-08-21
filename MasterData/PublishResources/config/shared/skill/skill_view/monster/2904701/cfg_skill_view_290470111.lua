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
      " PlayCasterAnimation,animName=skill01; PlayCasterBindEffect,effectID=290470103; PlayCasterBindEffect,effectID=290470104; Wait,waitTime=300; PlayAudio,audioID=6267,audioType=1; Wait,waitTime=1900; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=960; StopCasterMaterialAnim,animName=effanim_2904701_buff_red; Wait,waitTime=600; "
    }
  }
}
return config, "ID", key
