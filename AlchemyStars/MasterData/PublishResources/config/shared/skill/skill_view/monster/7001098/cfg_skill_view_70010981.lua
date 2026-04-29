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
      " PlayCasterAnimation,animName = Skill02; PlayAudio,audioID = 6008,audioType=1; PlayCasterBindEffect,effectID=1252; PlayEffectAGridPos,effectID=1253,gridPosX=5,gridPosY=7; PlayEffectAGridPos,effectID=1253,gridPosX=5,gridPosY=3,gridDirX=0,gridDirY=-1; PlayEffectAGridPos,effectID=1253,gridPosX=3,gridPosY=5,gridDirX=-1,gridDirY=0; PlayEffectAGridPos,effectID=1253,gridPosX=7,gridPosY=5,gridDirX=1,gridDirY=0; Wait,waitTime=1500; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
