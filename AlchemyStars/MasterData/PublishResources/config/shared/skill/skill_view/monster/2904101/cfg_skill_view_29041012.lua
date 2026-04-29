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
      " PlayCasterTurnToTarget; "
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
      " PlayCasterAnimation,animName=Skill02; PlayCasterBindEffect,effectID=290410108; Wait,waitTime=900; PlayThrowMonsterAndDamage,hitAnim=Hit,hitEffectID=290410107,flyDelay=0,trajectoryID=290410109,startHeight=0.1,endHeight=0.5,flyTotalTime=300,eachFlyDelayTime=50,dieEffectID=290410110,trajectoryDelayTime=50; Wait,waitTime=1000; PlayTeamHUDVisible,visible=1; "
    }
  },
  {
    3,
    3,
    43,
    1,
    1,
    0,
    {audioID = 6246, audioType = 1}
  }
}
return config, "ID", key
