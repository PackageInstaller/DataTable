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
      " PlayAlphaThrowTrap,hitAnim=Hit,hitDelayTime=250,hitEffectID=3612,eachDamageTime=10,trapStartDelay=100,trapTrajectoryID=3611,trapStartHeight=0,trapEndHeight=0,trapFlyTotalTime=100,resetHeightDelay=800 "
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
      " Wait,waitTime=700; PlayAudio,audioID=6189,audioType=1; "
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
      " Wait,waitTime=20; PlayCasterBindEffect,effectID=3618; PlayAudio,audioID=6191,audioType=1; Wait,waitTime=780; PlayTeleportTargetAsMoving,time=100,moveAni= skill1_3,moveEffID=3619; Wait,waitTime=100; PlayTargetAddBuff,buffID=10011; Wait,waitTime=450; "
    }
  },
  {
    4,
    4,
    0,
    1,
    3,
    0,
    {
      " Wait,waitTime=600; PlayRoleTeleport, type=3, stageIndex=2; Wait,waitTime=700; PlayRoleTeleport, type=5, onlySelf=0, stageIndex=2; PlayCasterBindEffect,effectID=3622; Wait,waitTime=100; PlayRoleTeleport, type=6, stageIndex=2; "
    }
  },
  {
    5,
    5,
    0,
    1,
    3,
    0,
    {
      " Wait,waitTime=500; PlayCasterMaterialAnim,animName=eff_2602301_skill01_3_out; Wait,waitTime=700; StopCasterMaterialAnim,animName=eff_2602301_skill01_3_out; "
    }
  },
  {
    6,
    6,
    27,
    1,
    3,
    800,
    {
      hitAnim = "Hit",
      hitEffectID = 3620,
      turnToTarget = 1
    }
  },
  {
    7,
    7,
    0,
    1,
    1,
    0,
    {
      " PlayCasterAnimation,animName = skill1_1; "
    }
  }
}
return config, "ID", key
