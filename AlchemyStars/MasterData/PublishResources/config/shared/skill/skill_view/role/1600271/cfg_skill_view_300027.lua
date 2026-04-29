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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600271,waitTime = 2000;"
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt1; PlayCasterBindEffect,effectID = 1817; Wait,waitTime = 700; PlayRoleTeleport, type=3; PlayRoleTeleport, type=5, onlySelf=0; Wait,waitTime=33; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0,useResultPosCalcDir=1; PlayCasterAnimation,animName=AtkUlt2; Wait,waitTime=50; PlayCasterBindEffect,effectID = 1819; Wait,waitTime=1950; "
    }
  },
  {
    3,
    3,
    43,
    2,
    1,
    0,
    {audioID = 3108, audioType = 1}
  },
  {
    4,
    4,
    0,
    2,
    1,
    600,
    {
      " PlayCasterToPickupTrajectory,effectID=1818,flyTime=1000; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    900,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1820,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    900,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    7,
    7,
    0,
    2,
    2,
    0,
    {
      " DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=4300271,label=doAgain; PlayAddBuffView,buffID=4300272; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
