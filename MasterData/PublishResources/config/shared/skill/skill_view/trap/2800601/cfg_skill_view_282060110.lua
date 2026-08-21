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
      " PlayCasterAnimation,animName=Skill04; PlayAudio,audioID=8011,audioType=1; PlayCasterBindEffect,effectID=3477; Wait,waitTime=450; PlayCasterMaterialAnim,animName=eff_2800601_skill04_cure; Wait,waitTime=550; "
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
      " PlayAddHpText,damageStageIndex=1; Wait,waitTime=2500; "
    }
  }
}
return config, "ID", key
