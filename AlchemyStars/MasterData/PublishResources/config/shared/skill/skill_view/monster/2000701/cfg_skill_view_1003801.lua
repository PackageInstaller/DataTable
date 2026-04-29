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
      " PlayCasterAnimation,animName =Skill02; PlayAudio,audioID = 7028,audioType=1; PlayCasterBindEffect,effectID=2618; PlayCasterMaterialAnim,animName=eff_2000701_skill02_main; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2000,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2619,turnToTarget=1; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
