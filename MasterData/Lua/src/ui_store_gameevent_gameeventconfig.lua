local this = {}
this.GameEventModules = {
  [L_Const.ActivityType.AT_SIGN] = "moduleAttendance",
  [L_Const.ActivityType.AT_Main] = "moduleGameActivityMainTaskReward",
  [L_Const.ActivityType.AT_DAILY_TASK] = "moduleGameActivityTask",
  [L_Const.ActivityType.AT_SUBMIT_ITEM_TASK] = "moduleGameActivityCommit",
  [L_Const.ActivityType.AT_KIBO_DUEL] = "moduleGameActivityKiboBattle",
  [L_Const.ActivityType.AT_DOUBLE_DROP] = "moduleGameActivityDoubleReward",
  [L_Const.ActivityType.AT_Only_Show] = "moduleGameActivitySpecialProbabilityBoost",
  [L_Const.ActivityType.AT_PARTY] = "moduleActivityParty",
  [L_Const.ActivityType.AT_Kibo_Tour_Group] = "moduleGameActivityKiboTravel",
  [L_Const.ActivityType.AT_JADEGAME_WEB] = "moduleXiaoYuActivityEntrance",
  [L_Const.ActivityType.AT_Companion] = "moduleActivityBondsMission",
  [L_Const.ActivityType.AT_GROWUP] = "moduleActivityScenario",
  [L_Const.ActivityType.AT_REPEAT_EVENT] = "moduleGameActivityRedungeon",
  [L_Const.ActivityType.AT_NDAY] = "moduleNDaysActivity",
  [L_Const.ActivityType.AT_Level] = "moduleGameActivityStarLevel",
  [L_Const.ActivityType.AT_TeachingUp] = "moduleActivityHeroTrial",
  [L_Const.ActivityType.AT_JOURNEY] = "moduleActivityTravelLog",
  [L_Const.ActivityType.AT_SUNSET] = "moduleActivitySunSet"
}
this.gameEventGEModels = {
  [L_Const.ActivityType.AT_SIGN] = "signInGE",
  [L_Const.ActivityType.AT_Main] = "gameActivityMainTaskRewardGE",
  [L_Const.ActivityType.AT_DAILY_SIGN] = "sevenDaySignGE",
  [L_Const.ActivityType.AT_DAILY_TASK] = "gameActivityTaskGE",
  [L_Const.ActivityType.AT_SUBMIT_ITEM_TASK] = "gameActivityCommitGE",
  [L_Const.ActivityType.AT_KIBO_DUEL] = "gameActivityKiboBattleGE",
  [L_Const.ActivityType.AT_DOUBLE_DROP] = "gameActivityDoubleReward",
  [L_Const.ActivityType.AT_Only_Show] = "gameActivityOnlyShowGE",
  [L_Const.ActivityType.AT_Level] = "gameActivityStarLevelGE",
  [L_Const.ActivityType.AT_Kibo_Tour_Group] = "moduleGameActivityKiboTravelGE",
  [L_Const.ActivityType.AT_JADEGAME_WEB] = "moduleXiaoYuActivityEntranceGE",
  [L_Const.ActivityType.AT_PARTY] = "moduleActivityPartyGE",
  [L_Const.ActivityType.AT_NDAY] = "moduleNDaysActivityGE",
  [L_Const.ActivityType.AT_Companion] = "moduleActivityBondsMissionGE",
  [L_Const.ActivityType.AT_GROWUP] = "moduleActivityScenarioGE",
  [L_Const.ActivityType.AT_REPEAT_EVENT] = "gameActivityRedungeonGE",
  [L_Const.ActivityType.AT_TeachingUp] = "gameActivityHeroTrialsGE",
  [L_Const.ActivityType.AT_JOURNEY] = "gameActivityTravelLogGE",
  [L_Const.ActivityType.AT_SUNSET] = "gameActivitySunSetGE"
}
this.gameEventConfig = {
  [L_Const.ActivityType.AT_SIGN] = {
    banner = "UI/Texture/tex_mainui_btn_banner002.png"
  },
  [L_Const.ActivityType.AT_DAILY_SIGN] = {
    banner = "UI/Texture/tex_events_day_attendance_bg_banner.png",
    clickBannerCallback = function()
      L_UI:open("pageActivityNDaySign", {
        gameEventType = L_Const.ActivityType.AT_DAILY_SIGN
      })
    end
  },
  [L_Const.ActivityType.AT_DAILY_TASK] = {
    banner = "UI/Texture/tex_game_events_novice_bg_banner.png"
  },
  [L_Const.ActivityType.AT_SUBMIT_ITEM_TASK] = {
    banner = "UI/Texture/tex_game_events_novice_bg_banner.png"
  },
  [L_Const.ActivityType.AT_REPEAT_EVENT] = {
    banner = "UI/Texture/tex_game_events_novice_bg_banner.png"
  }
}
this.kiboBattleRedConfig = {106010, 100000}
this.kiboTravelRedConfig = {1}
return this
