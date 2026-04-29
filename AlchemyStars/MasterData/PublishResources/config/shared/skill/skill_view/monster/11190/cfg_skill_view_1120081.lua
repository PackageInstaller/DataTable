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
      " PlayTurnToTeleportNewPos; PlayCasterAnimation,animName = Skill01; PlayAudio,audioID=290630101,audioType=1; Wait,waitTime = 500; PlayCasterBindEffect,effectID = 290630101; PlayTeleportAsMoving,time=200; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290630102,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
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
      " PlayTargetAddBuff,buffID=1120081; "
    }
  }
}
return config, "ID", key
