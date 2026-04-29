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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600051,waitTime = 2000;"
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
      " Jump,condition=CheckMiyaPhase2,result=1,goto=phaseEnd; PlayCasterAnimation,animName = AtkUlt01; PlayAudio,audioID = 2190,audioType=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=354; Wait,waitTime=700; Wait,waitTime=1400; Wait,waitTime=1200; Wait,waitTime=1400; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " Jump,condition=CheckMiyaPhase2,result=0,goto=phaseEnd; PlayCasterAnimation,animName = AtkUlt02; PlayAudio,audioID = 2190,audioType=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=354; Wait,waitTime=1400; Wait,waitTime=1200; PlayCasterBindEffect,effectID=355; Wait,waitTime=1700; PlayCasterBindEffect,effectID=356; Wait,waitTime=3300; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2300,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=357,turnToTarget=1,deathClear=1,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    24,
    2,
    4,
    200,
    {
      targetType = 0,
      trajectoryType = 1,
      gridEffectID = 359,
      startHigh = 0.75,
      endHigh = 0.6,
      flyTotalTime = 100,
      finishDelayTime = 0,
      deltaAngle = 0,
      castEndEffectID = 358,
      audioID = 2191
    }
  },
  {
    6,
    6,
    25,
    1,
    3,
    5000,
    {
      hitAnim = "Hit",
      audioID = 2192,
      audioWaitTime = 0,
      hitEffectId = 357,
      attackIntervalTime = 350,
      finishDelayTime = 1500
    }
  }
}
return config, "ID", key
