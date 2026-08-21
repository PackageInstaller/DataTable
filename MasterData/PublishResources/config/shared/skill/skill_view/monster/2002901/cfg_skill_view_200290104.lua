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
      " TankTowerResetRotation,time=300; PlayAudio,audioID=7045,audioType=1; PlayTankRushPerGrid,rushSpeed=8,rushAnimatorTrigger=Skill01,hitAnimName=Hit,hitEffectID=200290103,turnToTarget=1,deathClear=1,rotateTime=1000,rushEffectID=200290102,rushEffectDestroyDelay=1000,rushEndEffectID=200290101,; "
    }
  }
}
return config, "ID", key
