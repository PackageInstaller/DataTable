local key = {
  ID = 1,
  StrValue = 2,
  IntValue = 3,
  FloatValue = 4,
  ArrayValue = 5
}
local common = {
  {4001010, 4001020},
  {8003029, 2}
}
local config = {
  guide_no_active_skill_missions = {
    "guide_no_active_skill_missions",
    nil,
    nil,
    nil,
    common[1]
  },
  guide_no_threestar_missions = {
    "guide_no_threestar_missions",
    nil,
    nil,
    nil,
    common[1]
  },
  guide_train_level_mission = {
    "guide_train_level_mission",
    nil,
    4001070
  },
  guide_train_level_min = {
    "guide_train_level_min",
    nil,
    1
  },
  guide_team_mission = {
    "guide_team_mission",
    nil,
    4001070
  },
  guide_team_min = {
    "guide_team_min",
    nil,
    3
  },
  guide_team_max = {
    "guide_team_max",
    nil,
    5
  },
  guide_condition_mission = {
    "guide_condition_mission",
    nil,
    4001030
  },
  guide_direct_mission = {
    "guide_direct_mission",
    nil,
    4001020
  },
  guide_battle_quit_hide = {
    "guide_battle_quit_hide",
    nil,
    4001030
  },
  guide_team_limit = {
    "guide_team_limit"
  },
  guide_discovery_btn_chapter = {
    "guide_discovery_btn_chapter",
    nil,
    2
  },
  guide_team_clear_guideid = {
    "guide_team_clear_guideid",
    nil,
    nil,
    nil,
    {1051, 3}
  },
  guide_team_btn_chapter = {
    "guide_team_btn_chapter",
    nil,
    2
  },
  guide_buff_mission_to_guideid = {
    "guide_buff_mission_to_guideid",
    "4001010,1000|4001020,1001|4001030,1002",
    nil,
    nil,
    {71, 72}
  },
  guide_star_time_limit_mission = {
    "guide_star_time_limit_mission",
    nil,
    4001030
  },
  guide_attr_pet_id = {
    "guide_attr_pet_id",
    nil,
    nil,
    nil,
    {
      1500331,
      1300521,
      1400321
    }
  },
  guide_homeland_base = {
    "guide_homeland_base",
    nil,
    50001
  },
  guide_dormitory = {
    "guide_dormitory",
    nil,
    50004
  },
  guide_dormitory_edit = {
    "guide_dormitory_edit",
    nil,
    50005
  },
  guide_dormitory_in = {
    "guide_dormitory_in",
    nil,
    50006,
    nil,
    {1400411, 1400412}
  },
  guide_fishing = {
    "guide_fishing",
    nil,
    50008
  },
  guide_diff = {
    "guide_diff",
    nil,
    12
  },
  guide_wechat = {
    "guide_wechat",
    nil,
    1078,
    nil,
    {1500331}
  },
  guide_dormitory_build = {
    "guide_dormitory_build",
    nil,
    50004,
    nil,
    {5242101}
  },
  guide_season_s1_buff_level = {
    "guide_season_s1_buff_level",
    nil,
    3
  },
  guide_season_s1_drag = {
    "guide_season_s1_drag",
    nil,
    800110
  },
  guide_season_s2_balance = {
    "guide_season_s2_balance",
    nil,
    nil,
    nil,
    {8002009, 2}
  },
  guide_season_s3_telescope = {
    "guide_season_s3_telescope",
    nil,
    nil,
    nil,
    common[2]
  },
  guide_season_s3_backpack = {
    "guide_season_s3_backpack",
    nil,
    nil,
    nil,
    common[2]
  }
}
return config, "ID", key
