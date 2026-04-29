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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1400621,waitTime = 2000;"
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID = 2274; Wait,waitTime = 1433; PlayCasterBindEffect,effectID = 2275; PlayTeleportAsMoving,speed=30.3; PlayCasterAnimation,animName=AtkUlt3; PlayCasterBindEffect,effectID = 2277; Wait,waitTime=1867; "
    }
  },
  {
    3,
    3,
    43,
    2,
    1,
    0,
    {audioID = 2227, audioType = 1}
  },
  {
    4,
    4,
    0,
    2,
    1,
    1433,
    {
      " PlayCasterToPickupTrajectory,effectID=2276,flySpeed=33; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    1433,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
