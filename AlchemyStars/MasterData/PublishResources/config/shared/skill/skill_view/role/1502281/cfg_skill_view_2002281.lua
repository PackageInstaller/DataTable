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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =150228104; PlayAudio,audioID = 150228105,audioType=1; Wait,waitTime=2700; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    400,
    {
      " RobotBomb, effectID=150228110, speed=3, explodeEffectID=150228105, hitAnimName=Hit, hitEffectID=0, turnToTarget=1, deathClear=0; "
    }
  }
}
return config, "ID", key
