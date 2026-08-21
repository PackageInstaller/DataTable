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
      " PlayAlphaThrowTrap,hitAnim=Hit,hitDelayTime=100,hitEffectID=3617,eachDamageTime=10,delTrapDelay=1060,trapStartDelay=100,trapTrajectoryID=3616,trapStartHeight=0,trapEndHeight=0,trapFlyTotalTime=100,rideTrapStartDelay=0,rideTrapStartHeight=1,rideTrapTrajectoryID=3616,resetHeightDelay=650 "
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
      " Wait,waitTime=100; PlayCasterAnimation,animName = skill1_2; PlayAudio,audioID=6190,audioType=1; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1000,
    {
      " PlayTargetAddBuff,buffID=10011; "
    }
  }
}
return config, "ID", key
