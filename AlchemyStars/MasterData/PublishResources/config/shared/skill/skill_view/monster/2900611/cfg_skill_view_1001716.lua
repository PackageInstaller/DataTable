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
      " PlayCasterAnimation,animName = Skill01; PlayAudio,audioID =6070,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=2700; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=9.5,gridPosY=4.5; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=9.5,gridPosY=9.5; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=4.5,gridPosY=4.5; Wait,waitTime=200; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=4.5,gridPosY=8.5; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=7.5,gridPosY=4.5; Wait,waitTime=150; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=5.5,gridPosY=9.5; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=7.5,gridPosY=9.5; Wait,waitTime=120; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=4.5,gridPosY=6.5; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=9.5,gridPosY=7.5; Wait,waitTime=130; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=5.5,gridPosY=4.5; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=9.5,gridPosY=5.5; Wait,waitTime=700; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
