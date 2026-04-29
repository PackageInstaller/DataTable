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
      " PlayCasterAnimation,animName=Skill04; PlayAudio,audioID = 6007,audioType=1; PlayCasterBindEffect,effectID=1259; Wait,waitTime=1000; PlayEffectAGridPos,effectID=1262,gridPosX=5,gridPosY=5; Wait,waitTime=500; ShowHideGameObject, isShow=0, goName=SceneRoot; PlayMonsterVisible,visible = 0; PlayEffectAGridPos,effectID=1260,gridPosX=5,gridPosY=5; Wait,waitTime=1000; ShowHideGameObject, isShow=1, goName=SceneRoot; Wait,waitTime=4200; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; PlayMonsterVisible,visible = 1; PlayCasterBindEffect,effectID=1261; "
    }
  }
}
return config, "ID", key
