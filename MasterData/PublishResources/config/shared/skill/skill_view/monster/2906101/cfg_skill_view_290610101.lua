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
      " PlayTeamHUDVisible,visible=0; PlayCasterAnimation,animName=Skill01Move; PlayMarchForward,marchTime=1200; PlayCasterAnimation,animName=StopMove; Wait,waitTime=300; PlayAudio,audioID=7067,audioType=1; PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID =290610105; Wait,waitTime=1500; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; PlayPushBoard, dirX=0, dirY=-1; Wait,waitTime=1000; PlayTeamHUDVisible,visible=1; PlayRefreshAllHPPos,forceRefreshHPPercent=1; "
    }
  }
}
return config, "ID", key
