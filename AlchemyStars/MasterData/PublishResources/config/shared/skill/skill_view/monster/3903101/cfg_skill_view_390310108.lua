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
      "PlayAudio,audioID = 2145,audioType=1;"
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayCasterShowHide,visible=1,forcePlayOnSkillHolder=1; PlayCasterBindEffect,effectID=394,forcePlayOnSkillHolder=1; PlayCasterAnimation,animName = AtkUlt,forcePlayOnSkillHolder=1; Wait,waitTime=3933; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=3800; PlayCasterShowHide,visible=0,forcePlayOnSkillHolder=1; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlayCameraEffect,effectID=393; Wait,waitTime=5000; "
    }
  }
}
return config, "ID", key
