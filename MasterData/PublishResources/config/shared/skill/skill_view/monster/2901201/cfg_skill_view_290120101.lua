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
      " PlayCasterAnimation,animName=Skill02; PlayAudio,audioID=6130,audioType=1; PlayCasterMaterialAnim,animName=eff_2901201_skill02_main; PlayCasterBindEffect,effectID=3165; PlayCasterBindEffect,effectID=3166; PlayCasterAddBuff,buffID=29012016; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    2300,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
