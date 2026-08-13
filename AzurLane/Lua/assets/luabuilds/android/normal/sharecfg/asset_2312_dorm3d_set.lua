pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "dorm3d_set") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_set"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.dorm3d_set = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_set

var_0_3.all = {
	"favor_level",
	"stage",
	"char_favor_item",
	"reduce_heartbeat",
	"rapport_interaction",
	"rapport_heartbeat",
	"rapport_heartbeat_trriger",
	"reduce_interaction",
	"heartbeat_unlock",
	"drom3d_time_unlock",
	"drom3d_photograph_unlock",
	"drom3d_illumination_color",
	"drom3d_illumination_intensity",
	"drom3d_recall_unlock",
	"drom3d_collection_unlock",
	"drom3d_furniture_unlock",
	"drom3d_touch_dialogue",
	"drom3d_gift_dialogue",
	"daily_vigor_max",
	"drom3d_favir_trigger_talk",
	"drom3d_favir_trigger_onwer",
	"drom3d_favir_trigger_propose",
	"drom3d_favir_trigger_game",
	"drom3d_weekly_task",
	"drom3d_appellation_time",
	"drom3d_memory_limit",
	"drom3d_shop_product_panel_max",
	"drom3d_shop_product_panel_medium",
	"drom3d_shop_product_panel_min1",
	"drom3d_shop_product_panel_min2",
	"drom3d_shop_product_panel_min3",
	"drom3d_shop_product_panel_num",
	"drom3d_new_room_remind",
	"dorm3d_furniture_slide"
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.dorm3d_set = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_set

	var_1_0.favor_level = {
		key_value_varchar = "",
		key = "favor_level",
		key_value_int = 15
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_set

	var_1_1.stage = {
		key = "stage",
		key_value_int = 0,
		key_value_varchar = {
			1,
			2,
			3
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.dorm3d_set

	var_1_2.char_favor_item = {
		key_value_varchar = " ",
		key = "char_favor_item",
		key_value_int = 0
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.dorm3d_set

	var_1_3.reduce_heartbeat = {
		key_value_varchar = "",
		key = "reduce_heartbeat",
		key_value_int = 0
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.dorm3d_set

	var_1_4.rapport_interaction = {
		key_value_varchar = "",
		key = "rapport_interaction",
		key_value_int = 0
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.dorm3d_set

	var_1_5.rapport_heartbeat = {
		key_value_varchar = "",
		key = "rapport_heartbeat",
		key_value_int = 2
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.dorm3d_set

	var_1_6.rapport_heartbeat_trriger = {
		key_value_varchar = "",
		key = "rapport_heartbeat_trriger",
		key_value_int = 25
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.dorm3d_set

	var_1_7.reduce_interaction = {
		key_value_varchar = "",
		key = "reduce_interaction",
		key_value_int = 0
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.dorm3d_set

	var_1_8.heartbeat_unlock = {
		key_value_varchar = "",
		key = "heartbeat_unlock",
		key_value_int = 1
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.dorm3d_set

	var_1_9.drom3d_time_unlock = {
		key_value_varchar = "",
		key = "drom3d_time_unlock",
		key_value_int = 5
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.dorm3d_set

	var_1_10.drom3d_photograph_unlock = {
		key_value_varchar = "",
		key = "drom3d_photograph_unlock",
		key_value_int = 2
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.dorm3d_set

	var_1_11.drom3d_illumination_color = {
		key = "drom3d_illumination_color",
		key_value_int = 0,
		key_value_varchar = {
			"AA5249",
			"E4CD7B",
			"8AD69A",
			"82C3DB",
			"8460C7",
			"FFFFFF"
		}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.dorm3d_set

	var_1_12.drom3d_illumination_intensity = {
		key_value_varchar = "",
		key = "drom3d_illumination_intensity",
		key_value_int = 2
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.dorm3d_set

	var_1_13.drom3d_recall_unlock = {
		key_value_varchar = "",
		key = "drom3d_recall_unlock",
		key_value_int = 1
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.dorm3d_set

	var_1_14.drom3d_collection_unlock = {
		key_value_varchar = "",
		key = "drom3d_collection_unlock",
		key_value_int = 2
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.dorm3d_set

	var_1_15.drom3d_furniture_unlock = {
		key_value_varchar = "",
		key = "drom3d_furniture_unlock",
		key_value_int = 1
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.dorm3d_set

	var_1_16.drom3d_touch_dialogue = {
		key_value_varchar = "",
		key = "drom3d_touch_dialogue",
		key_value_int = 1
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.dorm3d_set

	var_1_17.drom3d_gift_dialogue = {
		key_value_varchar = "",
		key = "drom3d_gift_dialogue",
		key_value_int = 2
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.dorm3d_set

	var_1_18.daily_vigor_max = {
		key_value_varchar = "",
		key = "daily_vigor_max",
		key_value_int = 3
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.dorm3d_set

	var_1_19.drom3d_favir_trigger_talk = {
		key_value_varchar = "",
		key = "drom3d_favir_trigger_talk",
		key_value_int = 1002
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.dorm3d_set

	var_1_20.drom3d_favir_trigger_onwer = {
		key_value_varchar = "",
		key = "drom3d_favir_trigger_onwer",
		key_value_int = 1007
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.dorm3d_set

	var_1_21.drom3d_favir_trigger_propose = {
		key_value_varchar = "",
		key = "drom3d_favir_trigger_propose",
		key_value_int = 1008
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.dorm3d_set

	var_1_22.drom3d_favir_trigger_game = {
		key_value_varchar = "",
		key = "drom3d_favir_trigger_game",
		key_value_int = 1014
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.dorm3d_set

	var_1_23.drom3d_weekly_task = {
		key_value_varchar = "",
		key = "drom3d_weekly_task",
		key_value_int = 7311
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.dorm3d_set

	var_1_24.drom3d_appellation_time = {
		key_value_varchar = "",
		key = "drom3d_appellation_time",
		key_value_int = 48
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.dorm3d_set

	var_1_25.drom3d_memory_limit = {
		key_value_varchar = "",
		key = "drom3d_memory_limit",
		key_value_int = 5400
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.dorm3d_set

	var_1_26.drom3d_shop_product_panel_max = {
		key = "drom3d_shop_product_panel_max",
		key_value_int = 0,
		key_value_varchar = {
			270104,
			270105
		}
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.dorm3d_set

	var_1_27.drom3d_shop_product_panel_medium = {
		key = "drom3d_shop_product_panel_medium",
		key_value_int = 0,
		key_value_varchar = {
			270201,
			270202,
			270101
		}
	}
	pg = var_1_27

	local var_1_28 = var_1_27.base.dorm3d_set

	var_1_28.drom3d_shop_product_panel_min1 = {
		key = "drom3d_shop_product_panel_min1",
		key_value_int = 0,
		key_value_varchar = {
			270201,
			270202,
			270101
		}
	}
	pg = var_1_28

	local var_1_29 = var_1_28.base.dorm3d_set

	var_1_29.drom3d_shop_product_panel_min2 = {
		key = "drom3d_shop_product_panel_min2",
		key_value_int = 0,
		key_value_varchar = {
			270201,
			270202,
			270101
		}
	}
	pg = var_1_29

	local var_1_30 = var_1_29.base.dorm3d_set

	var_1_30.drom3d_shop_product_panel_min3 = {
		key = "drom3d_shop_product_panel_min3",
		key_value_int = 0,
		key_value_varchar = {
			260101,
			260201
		}
	}
	pg = var_1_30

	local var_1_31 = var_1_30.base.dorm3d_set

	var_1_31.drom3d_shop_product_panel_num = {
		key_value_varchar = "",
		key = "drom3d_shop_product_panel_num",
		key_value_int = 3
	}
	pg = var_1_31

	local var_1_32 = var_1_31.base.dorm3d_set

	var_1_32.drom3d_new_room_remind = {
		key_value_varchar = "",
		key = "drom3d_new_room_remind",
		key_value_int = 11
	}
	pg = var_1_32
	var_1_32.base.dorm3d_set.dorm3d_furniture_slide = {
		key_value_varchar = "",
		key = "dorm3d_furniture_slide",
		key_value_int = 401
	}

	return
end)()

return
