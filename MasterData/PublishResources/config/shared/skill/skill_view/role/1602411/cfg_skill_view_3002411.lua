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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1501321,waitTime = 2000;"
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
      " PlayTurnToPickUpDirection; PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 160241103,audioType=1; PlayCasterBindEffect,effectID=160241101; PlayCasterBindEffect,effectID=160241102; PlayGridDark,darkType=2,duration=0.2,endValue=0.35; Wait,waitTime=800; PlayGridDark,darkType=2,duration=0.8,endValue=1; Wait,waitTime=4000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    800,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160241103,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2600,
    {
      " PlaySummonTrap,trapID=2803501,effectID=160241104; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
