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
      " PlayAudio,audioID = 290940102,audioType=1; PlayCasterMaterialAnim,animName=eff_2910201_death_main; PlayCasterBindEffect,effectID=291020105; PlayEntityLegacyAnimation,animNames=effanim_ 2910201_buff_main_out,casterEffectID=291020106; PlayCasterAnimation,animName = Death; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
