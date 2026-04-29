local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1701091,waitTime = 2000;"
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
      " PlayCasterBindEffect,effectID =3063; PlayCasterBindEffect,effectID =3064; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2349,audioType=1; Wait,waitTime=3000; PlaySelectCenterGridEffect,effectID=3065,intervalTime=0; Wait,waitTime=350; PlaySummonMeantimeLimit,trapDieSkillID=516012613; Wait,waitTime=1000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    3000,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
