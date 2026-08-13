pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "dorm3d_resource") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_resource"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.dorm3d_resource = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_resource

var_0_3.__namecode__ = true
pg = var_0_3

local var_0_4 = var_0_3.dorm3d_resource

var_0_4.all = {
	202201,
	202202,
	202203,
	302211,
	302212,
	199031,
	199032,
	199033,
	105171,
	105173,
	307071,
	307073,
	499051,
	499053,
	799021,
	799022,
	799023,
	799024
}
pg = var_0_4

local var_0_5 = var_0_4.dorm3d_resource

var_0_5.get_id_list_by_ship_group = {
	[10517] = {
		105171,
		105173
	},
	[19903] = {
		199031,
		199032,
		199033
	},
	[20220] = {
		202201,
		202202,
		202203
	},
	[30221] = {
		302211,
		302212
	},
	[30707] = {
		307071,
		307073
	},
	[49905] = {
		499051,
		499053
	},
	[30] = {
		799021,
		799022,
		799023,
		799024
	}
}
pg = var_0_5
pg = var_1

local var_0_6

if not var_1.base then
	var_0_6 = {}
end

var_0_5.base = var_0_6
pg = var_0_5
var_0_5.base.dorm3d_resource = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_resource

	var_1_0[202201] = {
		ship_group = 20220,
		name = "天狼星",
		model_id = "tianlangxing_noshoes",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 0,
		unlock = "",
		unlock_text = "",
		picture = "regular",
		type = 1,
		origin_model = "pre_char_tianlangxing_db_noshoes_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 202201,
		head_Icon = "dorm3Dchar/tianlangxing",
		tags = {},
		hidden_part = {}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_resource

	var_1_1[202202] = {
		ship_group = 20220,
		name = "天狼星泳装",
		model_id = "tianlangxing_swim",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 270110,
		unlock_text = "在沙滩中邀请天狼星解锁",
		picture = "regular",
		type = 2,
		origin_model = "pre_char_tianlangxing_swim_noshoes_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "diantou",
		switch_anim = "ganjin",
		id = 202202,
		head_Icon = "dorm3Dchar/tianlangxing",
		tags = {
			"beach",
			"touch"
		},
		unlock = {
			5,
			4,
			20220
		},
		hidden_part = {}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.dorm3d_resource

	var_1_2[202203] = {
		ship_group = 20220,
		name = "天狼星兔女郎",
		model_id = "tianlangxing_bunny",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 270116,
		unlock_text = "在咖啡馆中购买角色皮肤",
		picture = "regular",
		type = 2,
		origin_model = "pre_char_tianlangxing_bunny_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 202203,
		head_Icon = "dorm3Dchar/tianlangxing",
		tags = {
			"cafe",
			"touch"
		},
		unlock = {
			5,
			16,
			20220
		},
		hidden_part = {}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.dorm3d_resource

	var_1_3[3] = {
		ship_group = 30221,
		name = "{namecode:50}常服",
		model_id = "nengdai_noshoes",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 0,
		unlock = "",
		unlock_text = "",
		picture = "regular",
		type = 1,
		origin_model = "pre_char_nengdai_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 302211,
		head_Icon = "dorm3Dchar/nengdai",
		tags = {},
		hidden_part = {}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.dorm3d_resource

	var_1_4[4] = {
		ship_group = 30221,
		name = "{namecode:50}泳装",
		model_id = "nengdai_swim",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 270111,
		unlock_text = "在沙滩中邀请能代解锁",
		picture = "regular",
		type = 2,
		origin_model = "pre_char_nengdai_swim_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "shuohua_sikao",
		switch_anim = "shuohua_chuaishou",
		id = 302212,
		head_Icon = "dorm3Dchar/nengdai",
		tags = {
			"beach",
			"touch"
		},
		unlock = {
			5,
			4,
			30221
		},
		hidden_part = {}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.dorm3d_resource

	var_1_5[199031] = {
		ship_group = 19903,
		name = "安克雷奇常服",
		model_id = "ankeleiqi_noshoes",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 0,
		unlock = "",
		unlock_text = "",
		picture = "regular",
		type = 1,
		origin_model = "pre_char_ankeleiqi_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 199031,
		head_Icon = "dorm3Dchar/ankeleiqi",
		tags = {},
		hidden_part = {}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.dorm3d_resource

	var_1_6[199032] = {
		ship_group = 19903,
		name = "安克雷奇泳装",
		model_id = "ankeleiqi_swim",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 270112,
		unlock_text = "在沙滩中邀请安克雷奇解锁",
		picture = "regular",
		type = 2,
		origin_model = "pre_char_ankeleiqi_swim_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 199032,
		head_Icon = "dorm3Dchar/ankeleiqi",
		tags = {
			"beach",
			"touch"
		},
		unlock = {
			5,
			4,
			19903
		},
		hidden_part = {}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.dorm3d_resource

	var_1_7[199033] = {
		ship_group = 19903,
		name = "安克雷奇丝袜常服",
		model_id = "ankeleiqi_stock",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 0,
		unlock = "",
		unlock_text = "",
		picture = "regular",
		type = 1,
		origin_model = "pre_char_ankeleiqi_stock_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 0,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 199033,
		head_Icon = "dorm3Dchar/ankeleiqi",
		tags = {},
		hidden_part = {}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.dorm3d_resource

	var_1_8[105171] = {
		ship_group = 10517,
		name = "{namecode:199}常服",
		model_id = "xinzexi_noshoes",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 0,
		unlock = "",
		unlock_text = "",
		picture = "regular",
		type = 1,
		origin_model = "pre_char_xinzexi_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 105171,
		head_Icon = "dorm3Dchar/xinzexi",
		tags = {},
		hidden_part = {
			{
				1,
				"oversleeve",
				"all/hoodie_geo"
			}
		}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.dorm3d_resource

	var_1_9[105173] = {
		ship_group = 10517,
		name = "{namecode:199}兔女郎",
		model_id = "xinzexi_bunny",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 270113,
		unlock_text = "在咖啡馆中购买角色皮肤",
		picture = "regular",
		type = 2,
		origin_model = "pre_char_xinzexi_bunny_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 105173,
		head_Icon = "dorm3Dchar/xinzexi",
		tags = {
			"cafe",
			"touch"
		},
		unlock = {
			5,
			16,
			10517
		},
		hidden_part = {}
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.dorm3d_resource

	var_1_10[307071] = {
		ship_group = 30707,
		name = "{namecode:97}常服",
		model_id = "dafeng_noshoes",
		remarks = "",
		shop_id = 0,
		unlock = "",
		unlock_text = "",
		picture = "regular",
		type = 1,
		origin_model = "pre_char_dafeng_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 307071,
		head_Icon = "dorm3Dchar/dafeng",
		tags = {},
		hidden_part = {
			{
				1,
				"oversleeve",
				"all/cloth_2_geo"
			}
		},
		stocking_pos = {
			1,
			1
		},
		stocking_geo_path = {
			"all/stocking_geo_l",
			"all/stocking_geo_r"
		}
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.dorm3d_resource

	var_1_11[1] = {
		ship_group = 30707,
		name = "{namecode:97}兔女郎",
		model_id = "dafeng_bunny",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 270114,
		unlock_text = "在咖啡馆中购买角色皮肤",
		picture = "regular",
		type = 2,
		origin_model = "pre_char_dafeng_bunny_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 307073,
		head_Icon = "dorm3Dchar/dafeng",
		tags = {
			"cafe",
			"touch"
		},
		unlock = {
			5,
			16,
			30707
		},
		hidden_part = {}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.dorm3d_resource

	var_1_12[499051] = {
		ship_group = 49905,
		name = "{namecode:480}常服",
		model_id = "aijier_noshoes",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 0,
		unlock = "",
		unlock_text = "",
		picture = "regular",
		type = 1,
		origin_model = "pre_char_aijier_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 499051,
		head_Icon = "dorm3Dchar/aijier",
		tags = {},
		hidden_part = {}
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.dorm3d_resource

	var_1_13[499053] = {
		ship_group = 49905,
		name = "{namecode:480}兔女郎",
		model_id = "aijier_bunny",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 270115,
		unlock_text = "在咖啡馆中购买角色皮肤",
		picture = "regular",
		type = 2,
		origin_model = "pre_char_aijier_bunny_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 499053,
		head_Icon = "dorm3Dchar/aijier",
		tags = {
			"cafe",
			"touch"
		},
		unlock = {
			5,
			16,
			49905
		},
		hidden_part = {}
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.dorm3d_resource

	var_1_14[799021] = {
		ship_group = 79902,
		name = "纳希莫夫常服",
		model_id = "naximofu_noshoes",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 0,
		unlock = "",
		unlock_text = "",
		picture = "regular",
		type = 1,
		origin_model = "pre_char_naximofu_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 799021,
		head_Icon = "dorm3Dchar/naximofu",
		tags = {},
		hidden_part = {}
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.dorm3d_resource

	var_1_15[799022] = {
		ship_group = 79902,
		name = "纳希莫夫赛车服",
		model_id = "naximofu_racing",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 270121,
		unlock_text = "在维修区工作站中购买角色皮肤",
		picture = "regular",
		type = 2,
		origin_model = "pre_char_naximofu_racing_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 0,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 799022,
		head_Icon = "dorm3Dchar/naximofu",
		tags = {
			"carwash",
			"touch"
		},
		unlock = {
			5,
			26,
			79902
		},
		hidden_part = {}
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.dorm3d_resource

	var_1_16[799023] = {
		ship_group = 79902,
		name = "纳希莫夫赛车服",
		model_id = "naximofu_racing_noshoes",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 270121,
		unlock_text = "在维修区工作站中购买角色皮肤",
		picture = "regular",
		type = 2,
		origin_model = "pre_char_naximofu_racing_lz_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 1,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 799023,
		head_Icon = "dorm3Dchar/naximofu",
		tags = {},
		unlock = {
			5,
			26,
			79902
		},
		hidden_part = {}
	}
	pg = var_1_16
	var_1_16.base.dorm3d_resource[799024] = {
		ship_group = 79902,
		name = "纳希莫夫赛车服",
		model_id = "naximofu_racing_carwash",
		remarks = "",
		stocking_pos = "",
		stocking_geo_path = "",
		shop_id = 0,
		unlock_text = "在维修区工作站中购买角色皮肤",
		picture = "regular",
		type = 2,
		origin_model = "pre_char_naximofu_racing_mod",
		hidden_part_apply_in_timeline = 0,
		hx_component = "",
		is_show_change_skin = 0,
		animator = "",
		wear_anim = "",
		switch_anim = "",
		id = 799024,
		head_Icon = "dorm3Dchar/naximofu",
		tags = {},
		unlock = {
			5,
			26,
			79902
		},
		hidden_part = {}
	}

	return
end)()

return
