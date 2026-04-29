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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1500551,waitTime = 2000; "
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
      "PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayAudio,audioID = 2688,audioType=1; PlayCasterBindEffect,effectID=150210108; PlayCasterBindEffect,effectID=150210105; PlayCasterBindEffect,effectID=150210106; Wait,waitTime=800; PlayCasterAnimation,animName=AtkUlt; Wait,waitTime=250; PlayTeleportAsMoving,speed=25; PlayRoleTeleport,type=9; PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0,useResultPosCalcDir=1; PlayCasterAnimation,animName=AtkUlt3; Wait,waitTime=2000;"
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1200,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=150210107,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
