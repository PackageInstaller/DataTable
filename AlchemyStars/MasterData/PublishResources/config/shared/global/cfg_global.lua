local key = {
  ID = 1,
  StrValue = 2,
  IntValue = 3,
  FloatValue = 4,
  ArrayValue = 5,
  TableValue = 6
}
local common = {
  "bonus_time",
  {2048, 2048},
  {21, 52}
}
local config = {
  skill_chain_time = {
    "skill_chain_time",
    nil,
    3000
  },
  pet_up_level_start_long_time = {
    "pet_up_level_start_long_time",
    nil,
    500
  },
  pet_up_level_add_count_per_second = {
    "pet_up_level_add_count_per_second",
    nil,
    150
  },
  pet_up_level_presse_count = {
    "pet_up_level_presse_count",
    nil,
    5
  },
  pet_up_level_next_presse_count = {
    "pet_up_level_next_presse_count",
    nil,
    15
  },
  inner_game_warning_round_count = {
    "inner_game_warning_round_count",
    nil,
    3
  },
  inner_game_warning_round_count_maze = {
    "inner_game_warning_round_count_maze",
    nil,
    5
  },
  inner_game_zero_round_cost_hp = {
    "inner_game_zero_round_cost_hp",
    "5,10,15,20"
  },
  inner_game_zero_round_limit_hp = {
    "inner_game_zero_round_limit_hp",
    nil,
    1
  },
  main_default_spine_pet_id = {
    "main_default_spine_pet_id",
    nil,
    1500331
  },
  sale_and_use_press_long_deltaTime = {
    "sale_and_use_press_long_deltaTime",
    nil,
    200
  },
  ui_interface_common_size = {
    "ui_interface_common_size",
    nil,
    nil,
    nil,
    common[2]
  },
  ui_interface_common_monster_size = {
    "ui_interface_common_monster_size",
    nil,
    nil,
    nil,
    common[2]
  },
  ui_toast_manager_stop_time = {
    "ui_toast_manager_stop_time",
    nil,
    2000
  },
  ui_wave_warning_3000101 = {
    "ui_wave_warning_3000101",
    common[1]
  },
  audio_wave_warning_3000101 = {
    "audio_wave_warning_3000101",
    nil,
    1015
  },
  ui_wave_warning_default = {
    "ui_wave_warning_default",
    common[1]
  },
  audio_wave_warning_default = {
    "audio_wave_warning_default",
    nil,
    1015
  },
  long_press_threshold = {
    "long_press_threshold",
    nil,
    0.3
  },
  ui_discovery_content_scale = {
    "ui_discovery_content_scale",
    nil,
    nil,
    nil,
    {
      0.88,
      1.3,
      0.9,
      0.9
    }
  },
  vice_boss_template_id_list = {
    "vice_boss_template_id_list",
    nil,
    nil,
    nil,
    {2900181, 2900182}
  },
  ui_battle_time_speed_mission = {
    "ui_battle_time_speed_mission",
    nil,
    nil,
    nil,
    nil,
    {
      disableMissionList = {
        4001010,
        4001020,
        4001030,
        4001040
      }
    }
  },
  ui_notice_data_reset_time_hour = {
    "ui_notice_data_reset_time_hour",
    nil,
    5
  },
  shakeWaitTime = {
    "shakeWaitTime",
    nil,
    2000
  },
  shakeOffsetX = {
    "shakeOffsetX",
    nil,
    10
  },
  shakeOffsetY = {
    "shakeOffsetY",
    nil,
    10
  },
  change_chapter_name_cast = {
    "change_chapter_name_cast",
    nil,
    200
  },
  change_chapter_name_cast_item_id = {
    "change_chapter_name_cast_item_id",
    nil,
    3000003
  },
  change_chapter_name_cast_item_icon = {
    "change_chapter_name_cast_item_icon",
    "toptoon_3000003"
  },
  ui_player_info_sign_upper = {
    "ui_player_info_sign_upper",
    nil,
    100
  },
  change_chapter_name_max_value_view = {
    "change_chapter_name_max_value_view",
    nil,
    7
  },
  change_chapter_sign_max_value_view = {
    "change_chapter_sign_max_value_view",
    nil,
    50
  },
  change_chapter_name_max_value_code = {
    "change_chapter_name_max_value_code",
    nil,
    14
  },
  ui_besieged_tips_count = {
    "ui_besieged_tips_count",
    nil,
    10
  },
  ui_backpack_new_max_level = {
    "ui_backpack_new_max_level",
    nil,
    15
  },
  UIQuestGrowthLookIcon = {
    "UIQuestGrowthLookIcon",
    "task_chengzhang_cover1",
    1400481
  },
  UIQuestGrowthLookIcon_2 = {
    "UIQuestGrowthLookIcon_2",
    "task_chengzhang_cover2",
    3420116
  },
  changeTeamLeaderCount = {
    "changeTeamLeaderCount",
    nil,
    3
  },
  AircraftRandomStoryWaitTime = {
    "AircraftRandomStoryWaitTime",
    nil,
    86400
  },
  AircraftWhisperRandomPetCount = {
    "AircraftWhisperRandomPetCount",
    nil,
    nil,
    nil,
    {1, 2}
  },
  AircraftWhisperNextWaitTime = {
    "AircraftWhisperNextWaitTime",
    nil,
    nil,
    nil,
    {3000, 5000}
  },
  AircraftWhisperActionGaps = {
    "AircraftWhisperActionGaps",
    nil,
    1000
  },
  AirActionInteractionWaitTime = {
    "AirActionInteractionWaitTime",
    nil,
    14000
  },
  ui_achievement_finish_controller_close_time = {
    "ui_achievement_finish_controller_close_time",
    nil,
    1000
  },
  ui_achievement_finish_controller_gaps_time = {
    "ui_achievement_finish_controller_gaps_time",
    nil,
    500
  },
  UIWidgetBattlePet_dialLine2Hp = {
    "UIWidgetBattlePet_dialLine2Hp",
    nil,
    200
  },
  UIWidgetBattlePet_bigDiaLine = {
    "UIWidgetBattlePet_bigDiaLine",
    nil,
    5
  },
  ui_discovery_hint_missions = {
    "ui_discovery_hint_missions",
    nil,
    nil,
    nil,
    {
      4001010,
      4001020,
      4001030,
      4001045,
      4001040,
      4001041,
      4001050,
      4001060,
      4001070,
      4001095,
      4001080,
      4001090,
      4001100,
      4001110,
      4001120,
      4001130
    }
  },
  ui_pet_up_level_mat_cast_count_max = {
    "ui_pet_up_level_mat_cast_count_max",
    nil,
    999
  },
  ui_sign_in_every_day_cg_name = {
    "ui_sign_in_every_day_cg_name",
    "sign_qiandao_tu2"
  },
  ui_sign_in_total_cg_name = {
    "ui_sign_in_total_cg_name",
    "sign_qiandao_tu1"
  },
  ui_set_cancel_agree_proto_cd = {
    "ui_set_cancel_agree_proto_cd",
    nil,
    1
  },
  signInPassMissionID = {
    "signInPassMissionID",
    nil,
    4001030
  },
  ui_draw_card_flip_ratio = {
    "ui_draw_card_flip_ratio",
    nil,
    nil,
    0.7
  },
  ui_chapter_unlock_time = {
    "ui_chapter_unlock_time",
    nil,
    nil,
    nil,
    nil,
    {
      [9] = 1632186000,
      [10] = 1635843600,
      [11] = 1653296400,
      [19] = 1694682000
    }
  },
  FormationCount = {
    "FormationCount",
    nil,
    8
  },
  ui_discovery_between_chapters = {
    "ui_discovery_between_chapters",
    nil,
    nil,
    nil,
    {2}
  },
  ui_homeland_build_rotate_step = {
    "ui_homeland_build_rotate_step",
    nil,
    10
  },
  homeland_fell_tree_refresh_interval = {
    "homeland_fell_tree_refresh_interval",
    nil,
    600
  },
  homeland_axe_id = {
    "homeland_axe_id",
    nil,
    5011001
  },
  TowerFormationCount = {
    "TowerFormationCount",
    nil,
    4
  },
  MainBannerMaxCount = {
    "MainBannerMaxCount",
    nil,
    8
  },
  ShopBannerMaxCount = {
    "ShopBannerMaxCount",
    nil,
    20
  },
  UnlockAddToken = {
    "UnlockAddToken",
    nil,
    5
  },
  ActiveReviewTokenMax = {
    "ActiveReviewTokenMax",
    nil,
    10
  },
  ActiveReviewStartTime = {
    "ActiveReviewStartTime",
    "2022-09-15 09:00:00"
  },
  VigorousRange = {
    "VigorousRange",
    nil,
    60
  },
  VigorousAddToken = {
    "VigorousAddToken",
    nil,
    1
  },
  SeniorSkinhead = {
    "SeniorSkinhead",
    nil,
    nil,
    nil,
    {3751523}
  },
  MedalLImit = {
    "MedalLImit",
    nil,
    50
  },
  ShowMainLightUI = {
    "ShowMainLightUI"
  },
  MonthCardOutDateLimit = {
    "MonthCardOutDateLimit",
    nil,
    259200
  },
  property_cultivate = {
    "property_cultivate",
    nil,
    nil,
    nil,
    {
      6,
      14,
      17
    }
  },
  anipop_hard_init = {
    "anipop_hard_init",
    nil,
    1
  },
  anipop_mail_id = {
    "anipop_mail_id",
    nil,
    220005
  },
  ["1600773_main_lobby_cg"] = {
    "1600773_main_lobby_cg"
  },
  ["1600771_2_super_spine_idle"] = {
    "1600771_2_super_spine_idle"
  },
  ["1601484_main_lobby_cg"] = {
    "1601484_main_lobby_cg"
  },
  ["1601481_2_super_spine_idle"] = {
    "1601481_2_super_spine_idle"
  },
  ["1601214_main_lobby_cg"] = {
    "1601214_main_lobby_cg"
  },
  ["1601214_2_super_spine_idle"] = {
    "1601214_2_super_spine_idle"
  },
  TalentTreeItemId = {
    "TalentTreeItemId",
    nil,
    3001019
  },
  CollectCardNumGold = {
    "CollectCardNumGold",
    nil,
    20
  },
  CollectGoldNum = {
    "CollectGoldNum",
    nil,
    4
  },
  PersonSendCardNUm = {
    "PersonSendCardNUm",
    nil,
    3
  },
  SendCardNum = {
    "SendCardNum",
    nil,
    5
  },
  ActiveBackFlowStartTime = {
    "ActiveBackFlowStartTime",
    "2024-07-03 05:00:00"
  },
  ActiveBackFlowEndTime = {
    "ActiveBackFlowEndTime",
    "2024-07-26 04:00:00"
  },
  AlchemyLevelComponentID = {
    "AlchemyLevelComponentID",
    nil,
    506800409
  },
  AlchemyMoneyItemID = {
    "AlchemyMoneyItemID",
    nil,
    8800008
  },
  AlchemyShopShelfCount = {
    "AlchemyShopShelfCount",
    nil,
    3
  },
  AlchemyShopShelfMax = {
    "AlchemyShopShelfMax",
    nil,
    100
  },
  OnLineToOffine = {
    "OnLineToOffine",
    "2025-01-24 12:00:00"
  },
  ElementAddExp = {
    "ElementAddExp",
    nil,
    50
  },
  stage_1_id = {
    "stage_1_id",
    nil,
    4001010
  },
  stage_2_id = {
    "stage_2_id",
    nil,
    4001020
  },
  stage_3_id = {
    "stage_3_id",
    nil,
    4001030
  },
  stage_1_guide_id = {
    "stage_1_guide_id",
    nil,
    1000
  },
  stage_2_guide_id = {
    "stage_2_guide_id",
    nil,
    1001
  },
  stage_3_guide_id = {
    "stage_3_guide_id",
    nil,
    1002
  },
  auto_fight_need_pass_main_mission_id = {
    "auto_fight_need_pass_main_mission_id",
    nil,
    4001040
  },
  NewChapterID = {
    "NewChapterID",
    nil,
    0
  },
  pet_open_awaken = {
    "pet_open_awaken",
    nil,
    1
  },
  pet_open_grade = {
    "pet_open_grade",
    nil,
    1
  },
  role_phy_recover_rate = {
    "role_phy_recover_rate",
    nil,
    360
  },
  role_phy_max_limit = {
    "role_phy_max_limit",
    nil,
    999
  },
  maze_reset_hour = {
    "maze_reset_hour",
    nil,
    168
  },
  maze_reset_hour_new = {
    "maze_reset_hour_new",
    nil,
    336
  },
  anipop_reset_hour = {
    "anipop_reset_hour",
    nil,
    336
  },
  SearchEvilUseFirefly = {
    "SearchEvilUseFirefly",
    nil,
    10
  },
  TraceEvilUseFirefly = {
    "TraceEvilUseFirefly",
    nil,
    20
  },
  PetAffinityAddCountSingle = {
    "PetAffinityAddCountSingle",
    nil,
    1
  },
  MailLimitNum = {
    "MailLimitNum",
    nil,
    100
  },
  MailAppendixTypeLimitNum = {
    "MailAppendixTypeLimitNum",
    nil,
    99
  },
  MailTitleLimitNum = {
    "MailTitleLimitNum",
    nil,
    30
  },
  MailGameMasterDefaultTime = {
    "MailGameMasterDefaultTime",
    nil,
    144000
  },
  MailGameMasterDefaultName = {
    "MailGameMasterDefaultName",
    "str_mail_gm_default_name"
  },
  NoticeLanguage = {
    "NoticeLanguage",
    "ja"
  },
  NoticeCountryRegion = {
    "NoticeCountryRegion",
    nil,
    392
  },
  NoticePartition = {
    "NoticePartition",
    "0"
  },
  auto_fight_need_3_star = {
    "auto_fight_need_3_star",
    "str_battle_auto_needStar"
  },
  auto_fight_need_role_level = {
    "auto_fight_need_role_level",
    "str_battle_auto_needLevel"
  },
  auto_fight_need_aircraft_level = {
    "auto_fight_need_aircraft_level",
    "str_battle_auto_needAirLevel"
  },
  auto_fight_need_mission_id = {
    "auto_fight_need_mission_id",
    "str_battle_auto_needMission"
  },
  auto_fight_need_pass = {
    "auto_fight_need_pass",
    "str_battle_auto_needPass_withouthelp",
    1
  },
  auto_fight_disable_in_mission = {
    "auto_fight_disable_in_mission",
    "str_battle_auto_config_disable"
  },
  auto_fight_need_pass_boss_level = {
    "auto_fight_need_pass_boss_level",
    "str_battle_auto_needPass_boss"
  },
  auto_fight_need_pass_mainLine_level = {
    "auto_fight_need_pass_mainLine_level",
    "str_battle_auto_needPass_mainLine"
  },
  auto_fight_can_not_use = {
    "auto_fight_can_not_use",
    "str_battle_auto_canNot_use"
  },
  bgm_volume = {
    "bgm_volume",
    nil,
    nil,
    0.6
  },
  voice_volume = {
    "voice_volume",
    nil,
    nil,
    1
  },
  sound_volume = {
    "sound_volume",
    nil,
    nil,
    0.9
  },
  EnableAuroraTime = {
    "EnableAuroraTime",
    nil,
    1
  },
  MainUIFreeTime = {
    "MainUIFreeTime",
    nil,
    60
  },
  GrowthQuestSec = {
    "GrowthQuestSec",
    nil,
    630720000
  },
  GrowthQuestCount = {
    "GrowthQuestCount",
    nil,
    72
  },
  GrowthQuestCount2 = {
    "GrowthQuestCount2",
    nil,
    27
  },
  help_pet_state_pet_count = {
    "help_pet_state_pet_count",
    nil,
    4
  },
  help_pet_max_system_pool = {
    "help_pet_max_system_pool",
    nil,
    4000
  },
  help_pet_max_friend_pet = {
    "help_pet_max_friend_pet",
    nil,
    9
  },
  help_pet_max_system_pet = {
    "help_pet_max_system_pet",
    nil,
    9
  },
  help_pet_max_refresh_cache = {
    "help_pet_max_refresh_cache",
    nil,
    12
  },
  help_pet_max_equip_level = {
    "help_pet_max_equip_level",
    nil,
    1
  },
  help_pet_limit_time_history_data = {
    "help_pet_limit_time_history_data",
    nil,
    168
  },
  help_pet_limit_time_system_support = {
    "help_pet_limit_time_system_support",
    nil,
    48
  },
  help_pet_time_update_support_history = {
    "help_pet_time_update_support_history",
    nil,
    5
  },
  help_pet_time_update_system_support = {
    "help_pet_time_update_system_support",
    nil,
    5
  },
  help_pet_time_update_friend_support = {
    "help_pet_time_update_friend_support",
    nil,
    5
  },
  help_pet_limit_time_refresh_help_pet = {
    "help_pet_limit_time_refresh_help_pet",
    nil,
    3
  },
  re_sign_in_vig_point = {
    "re_sign_in_vig_point",
    nil,
    120
  },
  minor_chat = {
    "minor_chat",
    nil,
    0
  },
  activity_item_conver_mail_id = {
    "activity_item_conver_mail_id",
    nil,
    220001
  },
  prediction_mail_id = {
    "prediction_mail_id",
    nil,
    220002
  },
  sign_activity_reward_id = {
    "sign_activity_reward_id",
    nil,
    999999999,
    nil,
    nil,
    {
      showAwards = {
        3000002,
        3000003,
        3000004
      }
    }
  },
  sailing_init_layer_id = {
    "sailing_init_layer_id",
    nil,
    1
  },
  homeland_movie_task_reward = {
    "homeland_movie_task_reward",
    nil,
    nil,
    nil,
    {
      3000003,
      5273028,
      5273029,
      5273037,
      5273038,
      5273049,
      5273050,
      5273031,
      5273034,
      5273030,
      5273040,
      5273043,
      5273039,
      5273052,
      5273055,
      5273051
    }
  },
  WeekQuestResetDay = {
    "WeekQuestResetDay",
    nil,
    4
  },
  difficulty_tower_need_level = {
    "difficulty_tower_need_level",
    nil,
    100
  },
  difficulty_tower_show_level = {
    "difficulty_tower_show_level",
    nil,
    60
  },
  simulation_operation_unlock_mission_id = {
    "simulation_operation_unlock_mission_id",
    nil,
    5331001
  },
  simulation_operation_pickup_cd = {
    "simulation_operation_pickup_cd",
    nil,
    60
  },
  ui_discovery_chapter1_enter_level = {
    "ui_discovery_chapter1_enter_level",
    nil,
    4001130
  },
  ui_discovery_chapter3_enter_level = {
    "ui_discovery_chapter3_enter_level",
    nil,
    4201155
  },
  SyncAddMissionPassTimeDelta = {
    "SyncAddMissionPassTimeDelta",
    nil,
    3600
  },
  SyncGameGetMissionPassDelta = {
    "SyncGameGetMissionPassDelta",
    nil,
    300
  },
  compentsate_rewards_mail_id = {
    "compentsate_rewards_mail_id",
    nil,
    33200019
  },
  survey_tokens_time = {
    "survey_tokens_time",
    nil,
    86400
  },
  survey_tokens_MaxNum = {
    "survey_tokens_MaxNum",
    nil,
    10
  },
  survey_tokens_item = {
    "survey_tokens_item",
    "3000332|400"
  },
  survey_main_task_id = {
    "survey_main_task_id",
    nil,
    3520784
  },
  survey_boss_spine_name = {
    "survey_boss_spine_name",
    "n34_g_leiting_spine_idle"
  },
  survey_boss_idle_animation = {
    "survey_boss_idle_animation",
    "idle"
  },
  survey_boss_random_animation = {
    "survey_boss_random_animation",
    "action"
  },
  survey_boss_idle_length = {
    "survey_boss_idle_length",
    nil,
    4000
  },
  survey_boss_random_length = {
    "survey_boss_random_length",
    nil,
    4000
  },
  req_mission_team_record_num = {
    "req_mission_team_record_num",
    nil,
    5
  },
  mission_team_record_max_num = {
    "mission_team_record_max_num",
    nil,
    100
  },
  business_global_id = {
    "business_global_id",
    nil,
    800407701
  },
  SpecialFormulaMatchType = {
    "SpecialFormulaMatchType",
    nil,
    nil,
    nil,
    common[3],
    {
      [13] = {percent = 0.25, formulaID = 165},
      [14] = {percent = 0.2, formulaID = 166},
      [15] = {percent = 0.2, formulaID = 167}
    }
  },
  ModifyBuffLayer = {
    "ModifyBuffLayer",
    nil,
    nil,
    nil,
    common[3],
    {
      BuffEffectTypeList = {
        2001,
        2002,
        2003
      },
      MaxLayerCount = 99
    }
  },
  ModifyBuffDesc = {
    "ModifyBuffDesc",
    nil,
    nil,
    nil,
    common[3],
    {
      [2001] = "str_buff_desc_burn",
      [2002] = "str_buff_desc_posion",
      [2003] = "str_buff_desc_bleed"
    }
  },
  ReplaceBuffIDMatchType = {
    "ReplaceBuffIDMatchType",
    nil,
    nil,
    nil,
    {52},
    {
      [10011] = 581001,
      [10021] = 581002,
      [30061] = 583006,
      [30081] = 583008
    }
  },
  cook_endstory_504410901 = {
    "cook_endstory_504410901",
    nil,
    50390130
  },
  ASheepPopCount = {
    "ASheepPopCount",
    nil,
    5
  },
  main_dressup_max = {
    "main_dressup_max",
    nil,
    5
  },
  BackCampaignId = {
    "BackCampaignId",
    nil,
    1043
  }
}
return config, "ID", key
