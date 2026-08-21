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
      " PlayCasterHUDVisible,visible=0; PlayTeamHUDVisible,visible=0; PlayCasterAnimation,animName=Skill03; PlayAudio,audioID=6285,audioType=1; PlayRefreshGridByBoardID,sceneEffectIDs=290520117|290520118|290520116,gridPosX=5,gridPosY=5,sceneChangeEffectIDs=290520109|290520110|290520111,changeDelayTime=2000,backIntensity=0.2; Wait,waitTime=2000; PlayEffectAtAllGridPos, effectID=290520114; PlayShowUIBossCastSkillTip, maxNum=25; PlayCasterHUDVisible,visible=1; PlayTeamHUDVisible,visible=1; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; PlayCasterAnimation,animName=Jump; PlayTeleportAsMoving,time=800; "
    }
  }
}
return config, "ID", key
