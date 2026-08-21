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
      " PlayPetShowHide,visible=1; PlayCasterBindEffect,effectID =150171108; PlayCasterAnimation,animName = AtkUlt1; PlayAudio,audioID = 2536,audioType=1; Wait,waitTime=4000; PlayPetShowHide,visible=0; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2046,
    {
      " DataSelectDamage,damageIndex = 1; DataSelectDamageInfo,damageInfoIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0, label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    38,
    2,
    2,
    0,
    {
      effectIDList = {150171109}
    }
  }
}
return config, "ID", key
