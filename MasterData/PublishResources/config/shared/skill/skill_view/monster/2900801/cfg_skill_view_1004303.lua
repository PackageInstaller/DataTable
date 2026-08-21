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
      " PlayCasterAnimation,animName = Skill03; PlayAudio,audioID = 6109,audioType=1; PlayGridDark,darkType=0; PlayEffectAGridPos,effectID=2645,gridPosX=4,gridPosY=5,gridDirX=0,gridDirY=-1; Wait,waitTime=3000; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; PlayGridDark,darkType=1; "
    }
  }
}
return config, "ID", key
