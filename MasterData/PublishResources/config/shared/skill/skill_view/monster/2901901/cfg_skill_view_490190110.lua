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
      " PlayCasterAnimation,animName=Skill01; PlayAudio,audioID=6165,audioType=1; PlayCasterBindEffect,effectID=3385; PlayCasterBindEffect,effectID=3386; PlayTeleportAsMoving,time=200; Wait,waitTime=700; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=500; Wait,waitTime=800; "
    }
  },
  {
    2,
    2,
    23,
    1,
    1,
    700,
    {showTime = 200}
  }
}
return config, "ID", key
