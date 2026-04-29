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
      " PlayAlphaThrowTrap,hitAnim=Hit,hitDelayTime=100,hitEffectID=3612,eachDamageTime=10,delTrapDelay=700,trapStartDelay=250,trapTrajectoryID=3611,trapStartHeight=0,trapEndHeight=0,trapFlyTotalTime=100 "
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
      " PlayCasterAnimation,animName = skill1_1; Wait,waitTime=1300; PlayAudio,audioID=6189,audioType=1; "
    }
  }
}
return config, "ID", key
