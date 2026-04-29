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
      " PlayGridDark,darkType=0; PlayBossSpeak, bossCardImage=junei_bosscard_2905201, bossName=str_monster_name_2905201, prob=100, speakList=str_story_banner_29052011, audioList=6286, duration=9000, inAnimName=uieff_UIBattleBossSpeak_in, loopAnimName=uieff_UIBattleBossSpeak_loop, outAnimName=uieff_UIBattleBossSpeak_out; Wait,waitTime=9000; PlayAudio,audioID=6282,audioType=1; PlayCameraEffect,effectID=290520113; PlayTeamHUDVisible,visible=0; PlayHideSceneAndPlaySceneEff,sceneOpenEffectID=290520112,gridPosX=5,gridPosY=5,sceneEffectID=290520116,openDelayTime=1500,backIntensity=0.2; Wait,waitTime=1000; PlayEffectAtAllGridPos, effectID=290520114; PlayShowUIBossCastSkillTip, maxNum=25; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=0; Wait,waitTime=2000; PlayCasterHUDVisible,visible=1; PlayTeamHUDVisible,visible=1; "
    }
  }
}
return config, "ID", key
