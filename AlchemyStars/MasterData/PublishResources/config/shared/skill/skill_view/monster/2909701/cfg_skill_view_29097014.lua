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
      " PlayDeleteWaringArea; PlayCasterAnimation,animName=Skill_2; PlayCasterBindEffect,effectID =290970101; Wait,waitTime=200; PlayAudio,audioID = 29097013,audioType=1; Wait,waitTime=500; PlayCasterBindEffect,effectID =290970102; PlayTeleportAsMoving,time=200; Wait,waitTime=400; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
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
      " PlaySummonTrap,trapID=2909701; Wait,waitTime=1000; "
    }
  },
  {
    3,
    3,
    29,
    2,
    2,
    0,
    {
      warningCenterPosType = 4,
      warningTextEffectID = 339,
      areaRes = ""
    }
  }
}
return config, "ID", key
