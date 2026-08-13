pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "island_set") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_set"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.island_set = var_0_2
pg = var_0

local var_0_3 = var_0.island_set

var_0_3.all = {
	"order_complete_refresh_time",
	"order_change_time",
	"order_random_open",
	"order_price_down_proportion",
	"oeder_difficulty_coefficient",
	"order_award_coefficient",
	"order_ship_award_coefficient",
	"order_ship_time_coefficient",
	"order_award_proportion",
	"order_value_exp_ratio",
	"order_special_limit_num",
	"order_daily_limit_num",
	"order_favor",
	"order_special_duration",
	"order_special_probability",
	"order_special_refresh_time",
	"island_daily_task_reward",
	"island_daily_task_num",
	"ship_attribute_value",
	"favorite_gifts_state",
	"work_points",
	"mining_recovery_time",
	"mining_recovery_tim_new",
	"collection_point_recovery_time",
	"mission_gather_point",
	"mining_default_slot",
	"mining_auto_parameters",
	"base_efficiency",
	"stamina_cost",
	"detection_parameters",
	"player_movement_parameters",
	"initial_scene",
	"initial_spawn_point",
	"mining_ore_spawn_point",
	"task_daily",
	"task_weekly",
	"chara_att_unlock",
	"daily_gift_get_max",
	"daily_gift_drop_num",
	"daily_gift",
	"season_pt",
	"season_now",
	"season_pt_show",
	"island_manage_price_coefficient",
	"island_manage_sale_coefficient_a",
	"island_manage_sale_coefficient_b",
	"island_manage_sale_coefficient_c",
	"island_manage_sale_constant",
	"island_manage_sale_limit",
	"whit_list_max_cnt",
	"main_page_function_unlock",
	"farm_empty_state_info",
	"island_build_save_time",
	"build_self_theme_num",
	"island_build_capacity",
	"island_build_expansion",
	"island_pre_placement",
	"island_manage_animation_extroversion",
	"island_manage_animation_introverted",
	"island_manage_bubble_resource",
	"island_manage_bubble_duration",
	"island_manage_bubble_cd",
	"island_manage_customer_list",
	"seek_game_reset_cd",
	"initial_dress",
	"character_detail_camera_speed",
	"initial_visitor_scene",
	"initial_visitor_spawn_point",
	"initial_furniture",
	"information_hud_height",
	"achievement_mention_time",
	"achievement_target_num_max",
	"achievement_target_num_max_special",
	"default_dress",
	"island_time_rate",
	"initial_dress_colordiff",
	"post_manage_produce",
	"post_manage_operate",
	"island_default_building",
	"hud_name_range",
	"action_bubble_range",
	"island_feedback_award_times",
	"island_label_limit",
	"action_waiting_time",
	"action_detection",
	"island_card_photo_default",
	"island_card_achievement_limit",
	"island_default_name",
	"island_message_bubble_range",
	"delegate_role_transparency",
	"max_follower_cnt",
	"single_action_respon_check_range",
	"default_action",
	"island_photohight_FPS",
	"island_photohight_TPS",
	"island_dress_follow_param",
	"island_ticket_shopid",
	"agora_reloading_base_cd",
	"island_corncup_return_mail_content",
	"island_shiporder_refresh_cd",
	"island_combo_count_limit",
	"couple_word_cd",
	"island_shiporder_refresh",
	"island_shiporder_list_quantity",
	"island_shiporder_limit",
	"island_guide_itemlimit",
	"treasure_week_limit",
	"treasure_unlock",
	"treasure_return_random",
	"treasure_price_limit",
	"treasure_price_initial",
	"treasure_price_parameter",
	"treasure_price_weight_group",
	"treasure_price_buy",
	"treasure_price_scale_y",
	"island_fishing_success_exit_time",
	"island_fishery_bubble_vfx",
	"daily_task_follow_action",
	"weekly_task_follow_action"
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.island_set = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_set

	var_1_0.order_complete_refresh_time = {
		key_value_varchar = "",
		key = "order_complete_refresh_time",
		key_value_int = 0
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_set

	var_1_1.order_change_time = {
		key = "order_change_time",
		key_value_int = 0,
		key_value_varchar = {
			{
				5,
				10
			},
			{
				1,
				10
			},
			100
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.island_set

	var_1_2.order_random_open = {
		key_value_varchar = "",
		key = "order_random_open",
		key_value_int = 5
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.island_set

	var_1_3.order_price_down_proportion = {
		key_value_varchar = "",
		key = "order_price_down_proportion",
		key_value_int = 10
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.island_set

	var_1_4.oeder_difficulty_coefficient = {
		key = "oeder_difficulty_coefficient",
		key_value_int = 0,
		key_value_varchar = {
			80,
			150
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.island_set

	var_1_5.order_award_coefficient = {
		key_value_varchar = "",
		key = "order_award_coefficient",
		key_value_int = 100
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.island_set

	var_1_6.order_ship_award_coefficient = {
		key = "order_ship_award_coefficient",
		key_value_int = 0,
		key_value_varchar = {
			1,
			25,
			0
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.island_set

	var_1_7.order_ship_time_coefficient = {
		key_value_varchar = "",
		key = "order_ship_time_coefficient",
		key_value_int = 1
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.island_set

	var_1_8.order_award_proportion = {
		key = "order_award_proportion",
		key_value_int = 0,
		key_value_varchar = {
			{
				1,
				{
					70,
					70
				}
			},
			{
				30,
				30
			}
		}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.island_set

	var_1_9.order_value_exp_ratio = {
		key = "order_value_exp_ratio",
		key_value_int = 0,
		key_value_varchar = {
			1,
			0.5
		}
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.island_set

	var_1_10.order_special_limit_num = {
		key_value_varchar = "",
		key = "order_special_limit_num",
		key_value_int = 15
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.island_set

	var_1_11.order_daily_limit_num = {
		key_value_varchar = "",
		key = "order_daily_limit_num",
		key_value_int = 5
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.island_set

	var_1_12.order_favor = {
		key_value_varchar = "",
		key = "order_favor",
		key_value_int = 20
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.island_set

	var_1_13.order_special_duration = {
		key_value_varchar = "",
		key = "order_special_duration",
		key_value_int = 28800
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.island_set

	var_1_14.order_special_probability = {
		key = "order_special_probability",
		key_value_int = 0,
		key_value_varchar = {
			20,
			5
		}
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.island_set

	var_1_15.order_special_refresh_time = {
		key_value_varchar = "",
		key = "order_special_refresh_time",
		key_value_int = 900
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.island_set

	var_1_16.island_daily_task_reward = {
		key = "island_daily_task_reward",
		key_value_int = 0,
		key_value_varchar = {
			{
				101655,
				4
			},
			{
				105477,
				200
			}
		}
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.island_set

	var_1_17.island_daily_task_num = {
		key_value_varchar = "",
		key = "island_daily_task_num",
		key_value_int = 3
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.island_set

	var_1_18.ship_attribute_value = {
		key = "ship_attribute_value",
		key_value_int = 0,
		key_value_varchar = {
			20,
			16,
			12,
			8,
			4
		}
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.island_set

	var_1_19.favorite_gifts_state = {
		key_value_varchar = "",
		key = "favorite_gifts_state",
		key_value_int = 200201
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.island_set

	var_1_20.work_points = {
		key_value_varchar = "",
		key = "work_points",
		key_value_int = 10
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.island_set

	var_1_21.mining_recovery_time = {
		key = "mining_recovery_time",
		key_value_int = 0,
		key_value_varchar = {
			{
				2001,
				1200,
				1
			},
			{
				2002,
				1200,
				1
			},
			{
				2003,
				1200,
				1
			},
			{
				2004,
				1200,
				1
			},
			{
				2011,
				1200,
				1
			},
			{
				2012,
				1200,
				1
			},
			{
				2013,
				1200,
				1
			},
			{
				2014,
				1200,
				1
			}
		}
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.island_set

	var_1_22.mining_recovery_tim_new = {
		key_value_varchar = "",
		key = "mining_recovery_tim_new",
		key_value_int = 10800
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.island_set

	var_1_23.collection_point_recovery_time = {
		key = "collection_point_recovery_time",
		key_value_int = 0,
		key_value_varchar = {
			{
				401,
				900
			},
			{
				402,
				900
			}
		}
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.island_set

	var_1_24.mission_gather_point = {
		key = "mission_gather_point",
		key_value_int = 0,
		key_value_varchar = {
			{
				2005,
				10040030
			},
			{
				2015,
				10040040
			}
		}
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.island_set

	var_1_25.mining_default_slot = {
		key = "mining_default_slot",
		key_value_int = 0,
		key_value_varchar = {
			{
				401,
				{
					2001,
					2002,
					2003,
					2004,
					2006,
					2007,
					2008,
					2009,
					2010
				}
			},
			{
				402,
				{
					2011,
					2012,
					2013,
					2014,
					2016,
					2017,
					2018,
					2019,
					2020
				}
			}
		}
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.island_set

	var_1_26.mining_auto_parameters = {
		key = "mining_auto_parameters",
		key_value_int = 0,
		key_value_varchar = {
			{
				401,
				50,
				5,
				25,
				1030
			},
			{
				402,
				50,
				5,
				25,
				1031
			}
		}
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.island_set

	var_1_27.base_efficiency = {
		key_value_varchar = "",
		key = "base_efficiency",
		key_value_int = 10
	}
	pg = var_1_27

	local var_1_28 = var_1_27.base.island_set

	var_1_28.stamina_cost = {
		key_value_varchar = "",
		key = "stamina_cost",
		key_value_int = 100
	}
	pg = var_1_28

	local var_1_29 = var_1_28.base.island_set

	var_1_29.detection_parameters = {
		key = "detection_parameters",
		key_value_int = 0,
		key_value_varchar = {
			170,
			3,
			1
		}
	}
	pg = var_1_29

	local var_1_30 = var_1_29.base.island_set

	var_1_30.player_movement_parameters = {
		key = "player_movement_parameters",
		key_value_int = 0,
		key_value_varchar = {
			5,
			6.5,
			1
		}
	}
	pg = var_1_30

	local var_1_31 = var_1_30.base.island_set

	var_1_31.initial_scene = {
		key_value_varchar = "",
		key = "initial_scene",
		key_value_int = 1004
	}
	pg = var_1_31

	local var_1_32 = var_1_31.base.island_set

	var_1_32.initial_spawn_point = {
		key_value_varchar = "",
		key = "initial_spawn_point",
		key_value_int = 10040042
	}
	pg = var_1_32

	local var_1_33 = var_1_32.base.island_set

	var_1_33.mining_ore_spawn_point = {
		key = "mining_ore_spawn_point",
		key_value_int = 0,
		key_value_varchar = {
			10040003,
			10040004,
			10040005,
			10040006,
			10040007,
			10040008,
			10040070,
			10040071,
			10040072
		}
	}
	pg = var_1_33

	local var_1_34 = var_1_33.base.island_set

	var_1_34.task_daily = {
		key = "task_daily",
		key_value_int = 0,
		key_value_varchar = {
			{
				14,
				1
			},
			{
				15,
				1
			},
			{
				16,
				1
			},
			{
				17,
				1
			},
			{
				18,
				1
			},
			{
				19,
				1
			},
			{
				20,
				1
			},
			{
				2,
				1
			},
			{
				3,
				1
			},
			{
				4,
				1
			},
			{
				5,
				1
			},
			{
				6,
				1
			},
			{
				7,
				1
			},
			{
				8,
				1
			}
		}
	}
	pg = var_1_34

	local var_1_35 = var_1_34.base.island_set

	var_1_35.task_weekly = {
		key = "task_weekly",
		key_value_int = 0,
		key_value_varchar = {
			{
				21,
				1
			},
			{
				22,
				1
			},
			{
				23,
				1
			},
			{
				24,
				1
			},
			{
				25,
				1
			},
			{
				26,
				1
			}
		}
	}
	pg = var_1_35

	local var_1_36 = var_1_35.base.island_set

	var_1_36.chara_att_unlock = {
		key_value_varchar = "",
		key = "chara_att_unlock",
		key_value_int = 0
	}
	pg = var_1_36

	local var_1_37 = var_1_36.base.island_set

	var_1_37.daily_gift_get_max = {
		key_value_varchar = "",
		key = "daily_gift_get_max",
		key_value_int = 3
	}
	pg = var_1_37

	local var_1_38 = var_1_37.base.island_set

	var_1_38.daily_gift_drop_num = {
		key_value_varchar = "",
		key = "daily_gift_drop_num",
		key_value_int = 6
	}
	pg = var_1_38

	local var_1_39 = var_1_38.base.island_set

	var_1_39.daily_gift = {
		key_value_varchar = "",
		key = "daily_gift",
		key_value_int = 4
	}
	pg = var_1_39

	local var_1_40 = var_1_39.base.island_set

	var_1_40.season_pt = {
		key = "season_pt",
		key_value_int = 0,
		key_value_varchar = {
			"岛屿开发PT",
			"IslandProps/season_pt"
		}
	}
	pg = var_1_40

	local var_1_41 = var_1_40.base.island_set

	var_1_41.season_now = {
		key_value_varchar = "",
		key = "season_now",
		key_value_int = 4
	}
	pg = var_1_41

	local var_1_42 = var_1_41.base.island_set

	var_1_42.season_pt_show = {
		key_value_varchar = "",
		key = "season_pt_show",
		key_value_int = 14
	}
	pg = var_1_42

	local var_1_43 = var_1_42.base.island_set

	var_1_43.island_manage_price_coefficient = {
		key_value_varchar = "",
		key = "island_manage_price_coefficient",
		key_value_int = 100
	}
	pg = var_1_43

	local var_1_44 = var_1_43.base.island_set

	var_1_44.island_manage_sale_coefficient_a = {
		key_value_varchar = "",
		key = "island_manage_sale_coefficient_a",
		key_value_int = 60
	}
	pg = var_1_44

	local var_1_45 = var_1_44.base.island_set

	var_1_45.island_manage_sale_coefficient_b = {
		key_value_varchar = "",
		key = "island_manage_sale_coefficient_b",
		key_value_int = 240
	}
	pg = var_1_45

	local var_1_46 = var_1_45.base.island_set

	var_1_46.island_manage_sale_coefficient_c = {
		key_value_varchar = "",
		key = "island_manage_sale_coefficient_c",
		key_value_int = 0
	}
	pg = var_1_46

	local var_1_47 = var_1_46.base.island_set

	var_1_47.island_manage_sale_constant = {
		key_value_varchar = "",
		key = "island_manage_sale_constant",
		key_value_int = 160
	}
	pg = var_1_47

	local var_1_48 = var_1_47.base.island_set

	var_1_48.island_manage_sale_limit = {
		key_value_varchar = "",
		key = "island_manage_sale_limit",
		key_value_int = 1
	}
	pg = var_1_48

	local var_1_49 = var_1_48.base.island_set

	var_1_49.whit_list_max_cnt = {
		key_value_varchar = "",
		key = "whit_list_max_cnt",
		key_value_int = 100
	}
	pg = var_1_49

	local var_1_50 = var_1_49.base.island_set

	var_1_50.main_page_function_unlock = {
		key = "main_page_function_unlock",
		key_value_int = 0,
		key_value_varchar = {
			0,
			0,
			27
		}
	}
	pg = var_1_50

	local var_1_51 = var_1_50.base.island_set

	var_1_51.farm_empty_state_info = {
		key = "farm_empty_state_info",
		key_value_int = 0,
		key_value_varchar = {
			"无作物",
			"islandprops/plant_seedings"
		}
	}
	pg = var_1_51

	local var_1_52 = var_1_51.base.island_set

	var_1_52.island_build_save_time = {
		key_value_varchar = "",
		key = "island_build_save_time",
		key_value_int = 5
	}
	pg = var_1_52

	local var_1_53 = var_1_52.base.island_set

	var_1_53.build_self_theme_num = {
		key_value_varchar = "",
		key = "build_self_theme_num",
		key_value_int = 5
	}
	pg = var_1_53

	local var_1_54 = var_1_53.base.island_set

	var_1_54.island_build_capacity = {
		key_value_varchar = "",
		key = "island_build_capacity",
		key_value_int = 3000
	}
	pg = var_1_54

	local var_1_55 = var_1_54.base.island_set

	var_1_55.island_build_expansion = {
		key = "island_build_expansion",
		key_value_int = 0,
		key_value_varchar = {
			{
				1,
				{
					41,
					2001,
					5
				},
				700
			},
			{
				2,
				{
					41,
					2001,
					5
				},
				1000
			}
		}
	}
	pg = var_1_55

	local var_1_56 = var_1_55.base.island_set

	var_1_56.island_pre_placement = {
		key = "island_pre_placement",
		key_value_int = 0,
		key_value_varchar = {
			{
				1,
				{
					0,
					0
				}
			}
		}
	}
	pg = var_1_56

	local var_1_57 = var_1_56.base.island_set

	var_1_57.island_manage_animation_extroversion = {
		key_value_varchar = "",
		key = "island_manage_animation_extroversion",
		key_value_int = 20002
	}
	pg = var_1_57

	local var_1_58 = var_1_57.base.island_set

	var_1_58.island_manage_animation_introverted = {
		key_value_varchar = "",
		key = "island_manage_animation_introverted",
		key_value_int = 20004
	}
	pg = var_1_58

	local var_1_59 = var_1_58.base.island_set

	var_1_59.island_manage_bubble_resource = {
		key = "island_manage_bubble_resource",
		key_value_int = 0,
		key_value_varchar = {
			"island/islandmanagebubble/manage_1",
			"island/islandmanagebubble/manage_2",
			"island/islandmanagebubble/manage_3",
			"island/islandmanagebubble/manage_4",
			"island/islandmanagebubble/manage_5",
			"island/islandmanagebubble/manage_6",
			"island/islandmanagebubble/manage_7"
		}
	}
	pg = var_1_59

	local var_1_60 = var_1_59.base.island_set

	var_1_60.island_manage_bubble_duration = {
		key = "island_manage_bubble_duration",
		key_value_int = 0,
		key_value_varchar = {
			2,
			3
		}
	}
	pg = var_1_60

	local var_1_61 = var_1_60.base.island_set

	var_1_61.island_manage_bubble_cd = {
		key = "island_manage_bubble_cd",
		key_value_int = 0,
		key_value_varchar = {
			2,
			10
		}
	}
	pg = var_1_61

	local var_1_62 = var_1_61.base.island_set

	var_1_62.island_manage_customer_list = {
		key = "island_manage_customer_list",
		key_value_int = 0,
		key_value_varchar = {
			100100,
			100200,
			100300,
			100400,
			100500
		}
	}
	pg = var_1_62

	local var_1_63 = var_1_62.base.island_set

	var_1_63.seek_game_reset_cd = {
		key_value_varchar = "",
		key = "seek_game_reset_cd",
		key_value_int = 2
	}
	pg = var_1_63

	local var_1_64 = var_1_63.base.island_set

	var_1_64.initial_dress = {
		key = "initial_dress",
		key_value_int = 0,
		key_value_varchar = {
			1040001,
			1040002,
			1040003,
			1050001,
			1050002,
			1050003,
			1050004,
			1050005,
			1050006,
			1060001,
			1060002,
			1070001,
			1070002
		}
	}
	pg = var_1_64

	local var_1_65 = var_1_64.base.island_set

	var_1_65.character_detail_camera_speed = {
		key_value_varchar = "",
		key = "character_detail_camera_speed",
		key_value_int = 30
	}
	pg = var_1_65

	local var_1_66 = var_1_65.base.island_set

	var_1_66.initial_visitor_scene = {
		key_value_varchar = "",
		key = "initial_visitor_scene",
		key_value_int = 1003
	}
	pg = var_1_66

	local var_1_67 = var_1_66.base.island_set

	var_1_67.initial_visitor_spawn_point = {
		key_value_varchar = "",
		key = "initial_visitor_spawn_point",
		key_value_int = 10030001
	}
	pg = var_1_67

	local var_1_68 = var_1_67.base.island_set

	var_1_68.initial_furniture = {
		key = "initial_furniture",
		key_value_int = 0,
		key_value_varchar = {
			{
				10201,
				1
			},
			{
				2,
				10
			},
			{
				3,
				10
			},
			{
				5,
				10
			},
			{
				6,
				10
			},
			{
				7,
				10
			},
			{
				8,
				10
			},
			{
				10,
				10
			},
			{
				12,
				20
			},
			{
				13,
				20
			},
			{
				14,
				20
			},
			{
				15,
				20
			},
			{
				16,
				20
			},
			{
				17,
				20
			},
			{
				18,
				20
			},
			{
				19,
				20
			},
			{
				20,
				20
			},
			{
				21,
				20
			},
			{
				22,
				20
			},
			{
				23,
				20
			}
		}
	}
	pg = var_1_68

	local var_1_69 = var_1_68.base.island_set

	var_1_69.information_hud_height = {
		key = "information_hud_height",
		key_value_int = 0,
		key_value_varchar = {
			{
				10040003,
				10040004,
				10040005,
				10040006,
				10040007,
				10040008,
				10040030
			},
			0.75
		}
	}
	pg = var_1_69

	local var_1_70 = var_1_69.base.island_set

	var_1_70.achievement_mention_time = {
		key_value_varchar = "",
		key = "achievement_mention_time",
		key_value_int = 10
	}
	pg = var_1_70

	local var_1_71 = var_1_70.base.island_set

	var_1_71.achievement_target_num_max = {
		key_value_varchar = "",
		key = "achievement_target_num_max",
		key_value_int = 9999
	}
	pg = var_1_71

	local var_1_72 = var_1_71.base.island_set

	var_1_72.achievement_target_num_max_special = {
		key_value_varchar = "",
		key = "achievement_target_num_max_special",
		key_value_int = 99999999
	}
	pg = var_1_72

	local var_1_73 = var_1_72.base.island_set

	var_1_73.default_dress = {
		key = "default_dress",
		key_value_int = 0,
		key_value_varchar = {
			1040003,
			1050006,
			1060002,
			1070002
		}
	}
	pg = var_1_73

	local var_1_74 = var_1_73.base.island_set

	var_1_74.island_time_rate = {
		key_value_varchar = "",
		key = "island_time_rate",
		key_value_int = 12
	}
	pg = var_1_74

	local var_1_75 = var_1_74.base.island_set

	var_1_75.initial_dress_colordiff = {
		key = "initial_dress_colordiff",
		key_value_int = 0,
		key_value_varchar = {
			104000101,
			104000102,
			104000201,
			104000202,
			104000301,
			104000302
		}
	}
	pg = var_1_75

	local var_1_76 = var_1_75.base.island_set

	var_1_76.post_manage_produce = {
		key = "post_manage_produce",
		key_value_int = 0,
		key_value_varchar = {
			101,
			102,
			201,
			401,
			402,
			501,
			502,
			601,
			602,
			603,
			604,
			703,
			704,
			705,
			706,
			901
		}
	}
	pg = var_1_76

	local var_1_77 = var_1_76.base.island_set

	var_1_77.post_manage_operate = {
		key = "post_manage_operate",
		key_value_int = 0,
		key_value_varchar = {
			601,
			602,
			603,
			604,
			901
		}
	}
	pg = var_1_77

	local var_1_78 = var_1_77.base.island_set

	var_1_78.island_default_building = {
		key = "island_default_building",
		key_value_int = 0,
		key_value_varchar = {
			10201,
			{
				29.73,
				-3.01,
				72.95
			}
		}
	}
	pg = var_1_78

	local var_1_79 = var_1_78.base.island_set

	var_1_79.hud_name_range = {
		key_value_varchar = "",
		key = "hud_name_range",
		key_value_int = 10
	}
	pg = var_1_79

	local var_1_80 = var_1_79.base.island_set

	var_1_80.action_bubble_range = {
		key_value_varchar = "",
		key = "action_bubble_range",
		key_value_int = 10
	}
	pg = var_1_80

	local var_1_81 = var_1_80.base.island_set

	var_1_81.island_feedback_award_times = {
		key_value_varchar = "",
		key = "island_feedback_award_times",
		key_value_int = 3
	}
	pg = var_1_81

	local var_1_82 = var_1_81.base.island_set

	var_1_82.island_label_limit = {
		key_value_varchar = "",
		key = "island_label_limit",
		key_value_int = 2
	}
	pg = var_1_82

	local var_1_83 = var_1_82.base.island_set

	var_1_83.action_waiting_time = {
		key_value_varchar = "",
		key = "action_waiting_time",
		key_value_int = 10
	}
	pg = var_1_83

	local var_1_84 = var_1_83.base.island_set

	var_1_84.action_detection = {
		key_value_varchar = "",
		key = "action_detection",
		key_value_int = 5
	}
	pg = var_1_84

	local var_1_85 = var_1_84.base.island_set

	var_1_85.island_card_photo_default = {
		key_value_varchar = "",
		key = "island_card_photo_default",
		key_value_int = 4001
	}
	pg = var_1_85

	local var_1_86 = var_1_85.base.island_set

	var_1_86.island_card_achievement_limit = {
		key_value_varchar = "",
		key = "island_card_achievement_limit",
		key_value_int = 4
	}
	pg = var_1_86

	local var_1_87 = var_1_86.base.island_set

	var_1_87.island_default_name = {
		key = "island_default_name",
		key_value_int = 0,
		key_value_varchar = {
			"的小岛"
		}
	}
	pg = var_1_87

	local var_1_88 = var_1_87.base.island_set

	var_1_88.island_message_bubble_range = {
		key_value_varchar = "",
		key = "island_message_bubble_range",
		key_value_int = 10
	}
	pg = var_1_88

	local var_1_89 = var_1_88.base.island_set

	var_1_89.delegate_role_transparency = {
		key_value_varchar = "",
		key = "delegate_role_transparency",
		key_value_int = 50
	}
	pg = var_1_89

	local var_1_90 = var_1_89.base.island_set

	var_1_90.max_follower_cnt = {
		key_value_varchar = "",
		key = "max_follower_cnt",
		key_value_int = 4
	}
	pg = var_1_90

	local var_1_91 = var_1_90.base.island_set

	var_1_91.single_action_respon_check_range = {
		key_value_varchar = "",
		key = "single_action_respon_check_range",
		key_value_int = 4
	}
	pg = var_1_91

	local var_1_92 = var_1_91.base.island_set

	var_1_92.default_action = {
		key = "default_action",
		key_value_int = 0,
		key_value_varchar = {
			1000,
			1001,
			1002,
			1003,
			1004,
			2000
		}
	}
	pg = var_1_92

	local var_1_93 = var_1_92.base.island_set

	var_1_93.island_photohight_FPS = {
		key = "island_photohight_FPS",
		key_value_int = 0,
		key_value_varchar = {
			1.6,
			1,
			2.3
		}
	}
	pg = var_1_93

	local var_1_94 = var_1_93.base.island_set

	var_1_94.island_photohight_TPS = {
		key = "island_photohight_TPS",
		key_value_int = 0,
		key_value_varchar = {
			2,
			1,
			3.5
		}
	}
	pg = var_1_94

	local var_1_95 = var_1_94.base.island_set

	var_1_95.island_dress_follow_param = {
		key = "island_dress_follow_param",
		key_value_int = 0,
		key_value_varchar = {
			0.01,
			10,
			0.1
		}
	}
	pg = var_1_95

	local var_1_96 = var_1_95.base.island_set

	var_1_96.island_ticket_shopid = {
		key = "island_ticket_shopid",
		key_value_int = 0,
		key_value_varchar = {
			{
				1,
				2,
				3,
				4,
				5
			},
			{
				10130
			}
		}
	}
	pg = var_1_96

	local var_1_97 = var_1_96.base.island_set

	var_1_97.agora_reloading_base_cd = {
		key_value_varchar = "",
		key = "agora_reloading_base_cd",
		key_value_int = 3
	}
	pg = var_1_97

	local var_1_98 = var_1_97.base.island_set

	var_1_98.island_corncup_return_mail_content = {
		key = "island_corncup_return_mail_content",
		key_value_int = 0,
		key_value_varchar = {
			"岛屿科技额外消耗资源返还",
			"感谢指挥官在岛屿计划中作出的贡献喵~"
		}
	}
	pg = var_1_98
	var_1_98.base.island_set.island_shiporder_refresh_cd = {
		key_value_varchar = "",
		key = "island_shiporder_refresh_cd",
		key_value_int = 14400
	}

	return
end)()
;(function()
	pg = var_1_10000

	local var_2_0 = var_1_10000.base.island_set

	var_2_0.island_combo_count_limit = {
		key_value_varchar = "",
		key = "island_combo_count_limit",
		key_value_int = 9999
	}
	pg = var_2_0

	local var_2_1 = var_2_0.base.island_set

	var_2_1.couple_word_cd = {
		key_value_varchar = "",
		key = "couple_word_cd",
		key_value_int = 3
	}
	pg = var_2_1

	local var_2_2 = var_2_1.base.island_set

	var_2_2.island_shiporder_refresh = {
		key = "island_shiporder_refresh",
		key_value_int = 0,
		key_value_varchar = {
			10800,
			64800
		}
	}
	pg = var_2_2

	local var_2_3 = var_2_2.base.island_set

	var_2_3.island_shiporder_list_quantity = {
		key_value_varchar = "",
		key = "island_shiporder_list_quantity",
		key_value_int = 6
	}
	pg = var_2_3

	local var_2_4 = var_2_3.base.island_set

	var_2_4.island_shiporder_limit = {
		key_value_varchar = "",
		key = "island_shiporder_limit",
		key_value_int = 1
	}
	pg = var_2_4

	local var_2_5 = var_2_4.base.island_set

	var_2_5.island_guide_itemlimit = {
		key_value_varchar = "",
		key = "island_guide_itemlimit",
		key_value_int = 99999
	}
	pg = var_2_5

	local var_2_6 = var_2_5.base.island_set

	var_2_6.treasure_week_limit = {
		key = "treasure_week_limit",
		key_value_int = 0,
		key_value_varchar = {
			200,
			200
		}
	}
	pg = var_2_6

	local var_2_7 = var_2_6.base.island_set

	var_2_7.treasure_unlock = {
		key_value_varchar = "",
		key = "treasure_unlock",
		key_value_int = 20
	}
	pg = var_2_7

	local var_2_8 = var_2_7.base.island_set

	var_2_8.treasure_return_random = {
		key = "treasure_return_random",
		key_value_int = 0,
		key_value_varchar = {
			3000,
			11000
		}
	}
	pg = var_2_8

	local var_2_9 = var_2_8.base.island_set

	var_2_9.treasure_price_limit = {
		key = "treasure_price_limit",
		key_value_int = 0,
		key_value_varchar = {
			200,
			1000
		}
	}
	pg = var_2_9

	local var_2_10 = var_2_9.base.island_set

	var_2_10.treasure_price_initial = {
		key = "treasure_price_initial",
		key_value_int = 0,
		key_value_varchar = {
			200,
			850
		}
	}
	pg = var_2_10

	local var_2_11 = var_2_10.base.island_set

	var_2_11.treasure_price_parameter = {
		key = "treasure_price_parameter",
		key_value_int = 0,
		key_value_varchar = {
			0.5,
			{
				40,
				60
			},
			0.01
		}
	}
	pg = var_2_11

	local var_2_12 = var_2_11.base.island_set

	var_2_12.treasure_price_weight_group = {
		key = "treasure_price_weight_group",
		key_value_int = 0,
		key_value_varchar = {
			{
				0,
				400
			},
			{
				401,
				800
			},
			{
				801,
				1000
			}
		}
	}
	pg = var_2_12

	local var_2_13 = var_2_12.base.island_set

	var_2_13.treasure_price_buy = {
		key_value_varchar = "",
		key = "treasure_price_buy",
		key_value_int = 110
	}
	pg = var_2_13

	local var_2_14 = var_2_13.base.island_set

	var_2_14.treasure_price_scale_y = {
		key = "treasure_price_scale_y",
		key_value_int = 0,
		key_value_varchar = {
			0,
			200,
			400,
			600,
			800,
			1000
		}
	}
	pg = var_2_14

	local var_2_15 = var_2_14.base.island_set

	var_2_15.island_fishing_success_exit_time = {
		key_value_varchar = "",
		key = "island_fishing_success_exit_time",
		key_value_int = 3
	}
	pg = var_2_15

	local var_2_16 = var_2_15.base.island_set

	var_2_16.island_fishery_bubble_vfx = {
		key = "island_fishery_bubble_vfx",
		key_value_int = 0,
		key_value_varchar = {
			{
				20101,
				10020079
			},
			{
				20102,
				10020080
			},
			{
				20103,
				10020081
			}
		}
	}
	pg = var_2_16

	local var_2_17 = var_2_16.base.island_set

	var_2_17.daily_task_follow_action = {
		key = "daily_task_follow_action",
		key_value_int = 0,
		key_value_varchar = {
			"clap"
		}
	}
	pg = var_2_17
	var_2_17.base.island_set.weekly_task_follow_action = {
		key = "weekly_task_follow_action",
		key_value_int = 0,
		key_value_varchar = {
			"clap"
		}
	}

	return
end)()

return
