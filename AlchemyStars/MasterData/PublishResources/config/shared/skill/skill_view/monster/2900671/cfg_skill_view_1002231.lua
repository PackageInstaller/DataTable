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
      " PlayCasterAnimation,animName=Skill03; PlayAudio,audioID = 6084,audioType=1; PlayCasterBindEffect,effectID=1259; PlayEffectAGridPos,effectID=2790,gridPosX=5,gridPosY=5; Wait,waitTime=1500; PlayEffectAGridPos,effectID=2789,gridPosX=5,gridPosY=5; ShowHideGameObject, isShow=0, goName=SceneRoot; Wait,waitTime=500; PlayMonsterVisible,visible = 0; Wait,waitTime=5000; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=700; ShowHideGameObject, isShow=1, goName=SceneRoot; Wait,waitTime=500; PlayMonsterVisible,visible = 1; PlayCasterBindEffect,effectID=1261; "
    }
  }
}
return config, "ID", key
