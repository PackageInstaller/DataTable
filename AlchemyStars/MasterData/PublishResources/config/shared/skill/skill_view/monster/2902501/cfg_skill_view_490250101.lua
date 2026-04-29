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
      " DataSelectResult,effectType=72,index=1; Jump,condition=CheckEffectResultIndex,param=72,result=0,goto=phaseEnd; PlayCasterTurnToPlayer; PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID=3656; PlayAudio,audioID = 6200,audioType=1; Wait,waitTime=1200; PlayFlyEffectCasterToTarget,flyEffectID = 3658,flyTime=150,flyTrace = 1,offsetx=0.114,offsety=1.004,offsetz=0.778,targetPos=Hit; Wait,waitTime=700; "
    }
  },
  {
    2,
    2,
    74,
    1,
    1,
    500,
    {
      hitAnimName = "Hit",
      hitDelayTime = 0,
      hitEffectID = 3660,
      casterAnimName = "Skill04",
      castEffectID = 11,
      noTrapCasterEffectID = 11,
      successCasterEffectID = 11,
      trapStartDelay = 1,
      trapTrajectoryID = 11,
      trapStartHeight = 0,
      trapEndHeight = 2,
      trapFlyTotalTime = 1,
      bowlderStartDelay = 1,
      bowlderTrajectoryID = 11,
      bowlderStartHeight = 4,
      bowlderEndHeight = 0,
      bowlderFlyTotalTime = 1
    }
  }
}
return config, "ID", key
