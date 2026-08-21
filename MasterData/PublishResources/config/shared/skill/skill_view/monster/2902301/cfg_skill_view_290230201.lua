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
      " PlayAlphaBlinkAttack,disappearEffID=3621,firstDisappearTime=600,appearEffID=3622,attackAni=skill2,attackEffID=3603,attackEffID2=3604,attackTime=1500,secondDisappearTime=400, "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=2500; PlayCasterBindEffect,effectID=3605; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  },
  {
    3,
    3,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=1000; PlayAudio,audioID=6192,audioType=1; "
    }
  }
}
return config, "ID", key
