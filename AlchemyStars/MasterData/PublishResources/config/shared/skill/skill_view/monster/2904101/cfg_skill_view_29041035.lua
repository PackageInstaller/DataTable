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
      " PlayAudio,audioID = 6249,audioType=1; DataSelectDamage,damageIndex =1; PlayCasterBindEffect,effectID=290410114; Wait,waitTime=200; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290410107,turnToTarget=1,deathClear=0; Wait,waitTime=1000; PlayTeamHUDVisible,visible=1; "
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
      " PlayCasterBindEffect,effectID=290410112; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role; Wait,waitTime=500; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; PlayCasterSuicide; "
    }
  }
}
return config, "ID", key
