pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "dorm3d_zone_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_zone_template"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.dorm3d_zone_template = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_zone_template

var_0_3.all = {
	1000,
	1001,
	1002,
	1003,
	2001,
	2002,
	2003,
	3001,
	3002,
	3003,
	4001,
	4002,
	4003,
	4004,
	4005,
	11001,
	11002,
	11003,
	12001,
	12002,
	12003,
	14001,
	14002,
	14003,
	16001,
	16002,
	16003,
	16004,
	21001,
	21002,
	21003,
	26001,
	26002,
	26003
}
pg = var_0_3

local var_0_4 = var_0_3.dorm3d_zone_template

var_0_4.get_id_list_by_room_id = {
	{
		1000,
		1001,
		1002,
		1003
	},
	{
		2001,
		2002,
		2003
	},
	{
		3001,
		3002,
		3003
	},
	{
		4001,
		4002,
		4003,
		4004,
		4005
	},
	[11] = {
		11001,
		11002,
		11003
	},
	[12] = {
		12001,
		12002,
		12003
	},
	[14] = {
		14001,
		14002,
		14003
	},
	[16] = {
		16001,
		16002,
		16003,
		16004
	},
	[21] = {
		21001,
		21002,
		21003
	},
	[26] = {
		26001,
		26002,
		26003
	}
}
pg = var_0_4
pg = var_1

local var_0_5

if not var_1.base then
	var_0_5 = {}
end

var_0_4.base = var_0_5
pg = var_0_4
var_0_4.base.dorm3d_zone_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_zone_template

	var_1_0[1000] = {
		is_global = 1,
		name = "全局区域",
		type_prioritys = "",
		touch_id = "",
		id = 1000,
		room_id = 1,
		watch_camera = "",
		special_action = ""
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_zone_template

	var_1_1[1001] = {
		is_global = 0,
		name = "卧室",
		touch_id = "",
		id = 1001,
		room_id = 1,
		watch_camera = "Bed",
		type_prioritys = {
			4,
			3,
			2,
			1
		},
		special_action = {
			{
				20220,
				{
					"jinzhang",
					"dianshouzhi"
				}
			}
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.dorm3d_zone_template

	var_1_2[1002] = {
		is_global = 0,
		name = "餐厅",
		type_prioritys = "",
		touch_id = "",
		id = 1002,
		room_id = 1,
		watch_camera = "Table",
		special_action = {
			{
				20220,
				{
					"jinzhang",
					"dianshouzhi"
				}
			}
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.dorm3d_zone_template

	var_1_3[1003] = {
		is_global = 0,
		name = "客厅",
		type_prioritys = "",
		touch_id = "",
		id = 1003,
		room_id = 1,
		watch_camera = "Chair",
		special_action = {
			{
				20220,
				{
					"jinzhang",
					"dianshouzhi"
				}
			}
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.dorm3d_zone_template

	var_1_4[2001] = {
		is_global = 0,
		name = "卧室",
		type_prioritys = "",
		touch_id = "",
		id = 2001,
		room_id = 2,
		watch_camera = "Bed",
		special_action = ""
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.dorm3d_zone_template

	var_1_5[2002] = {
		is_global = 0,
		name = "餐厅",
		type_prioritys = "",
		touch_id = "",
		id = 2002,
		room_id = 2,
		watch_camera = "Table",
		special_action = ""
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.dorm3d_zone_template

	var_1_6[2003] = {
		is_global = 0,
		name = "客厅",
		type_prioritys = "",
		touch_id = "",
		id = 2003,
		room_id = 2,
		watch_camera = "Chair",
		special_action = ""
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.dorm3d_zone_template

	var_1_7[3001] = {
		is_global = 0,
		name = "卧室",
		type_prioritys = "",
		touch_id = "",
		id = 3001,
		room_id = 3,
		watch_camera = "Bed",
		special_action = ""
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.dorm3d_zone_template

	var_1_8[3002] = {
		is_global = 0,
		name = "娱乐区",
		type_prioritys = "",
		touch_id = "",
		id = 3002,
		room_id = 3,
		watch_camera = "Table",
		special_action = ""
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.dorm3d_zone_template

	var_1_9[3003] = {
		is_global = 0,
		name = "客厅",
		type_prioritys = "",
		touch_id = "",
		id = 3003,
		room_id = 3,
		watch_camera = "Chair",
		special_action = ""
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.dorm3d_zone_template

	var_1_10[4001] = {
		is_global = 0,
		name = "入口",
		type_prioritys = "",
		id = 4001,
		room_id = 4,
		watch_camera = "Default",
		touch_id = {
			{
				20220,
				201
			}
		},
		special_action = {
			{
				20220,
				{
					"jinzhang",
					"dianshouzhi"
				}
			}
		}
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.dorm3d_zone_template

	var_1_11[4002] = {
		is_global = 0,
		name = "沙滩椅",
		type_prioritys = "",
		id = 4002,
		room_id = 4,
		watch_camera = "Tianlangxing",
		touch_id = {
			{
				20220,
				201
			}
		},
		special_action = {
			{
				20220,
				{
					"jinzhang",
					"dianshouzhi"
				}
			}
		}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.dorm3d_zone_template

	var_1_12[4003] = {
		is_global = 0,
		name = "遮阳伞",
		type_prioritys = "",
		id = 4003,
		room_id = 4,
		watch_camera = "Nengdai",
		touch_id = {
			{
				30221,
				2210110
			}
		},
		special_action = {}
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.dorm3d_zone_template

	var_1_13[4004] = {
		is_global = 0,
		name = "海滩",
		type_prioritys = "",
		id = 4004,
		room_id = 4,
		watch_camera = "Ankeleiqi",
		touch_id = {
			{
				19903,
				1990390
			}
		},
		special_action = {}
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.dorm3d_zone_template

	var_1_14[4005] = {
		is_global = 0,
		name = "滑梯",
		type_prioritys = "",
		id = 4005,
		room_id = 4,
		watch_camera = "Slide",
		touch_id = {
			{
				19903,
				1990390
			}
		},
		special_action = {}
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.dorm3d_zone_template

	var_1_15[11001] = {
		is_global = 0,
		name = "卧室",
		type_prioritys = "",
		touch_id = "",
		id = 11001,
		room_id = 11,
		watch_camera = "Bed",
		special_action = ""
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.dorm3d_zone_template

	var_1_16[11002] = {
		is_global = 0,
		name = "餐厅",
		type_prioritys = "",
		touch_id = "",
		id = 11002,
		room_id = 11,
		watch_camera = "Table",
		special_action = ""
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.dorm3d_zone_template

	var_1_17[11003] = {
		is_global = 0,
		name = "客厅",
		type_prioritys = "",
		touch_id = "",
		id = 11003,
		room_id = 11,
		watch_camera = "Chair",
		special_action = ""
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.dorm3d_zone_template

	var_1_18[12001] = {
		is_global = 0,
		name = "卧室",
		type_prioritys = "",
		touch_id = "",
		id = 12001,
		room_id = 12,
		watch_camera = "Bed",
		special_action = ""
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.dorm3d_zone_template

	var_1_19[12002] = {
		is_global = 0,
		name = "餐厅",
		type_prioritys = "",
		touch_id = "",
		id = 12002,
		room_id = 12,
		watch_camera = "Table",
		special_action = ""
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.dorm3d_zone_template

	var_1_20[12003] = {
		is_global = 0,
		name = "客厅",
		type_prioritys = "",
		touch_id = "",
		id = 12003,
		room_id = 12,
		watch_camera = "Chair",
		special_action = ""
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.dorm3d_zone_template

	var_1_21[14001] = {
		is_global = 0,
		name = "卧室",
		type_prioritys = "",
		touch_id = "",
		id = 14001,
		room_id = 14,
		watch_camera = "Bed",
		special_action = ""
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.dorm3d_zone_template

	var_1_22[14002] = {
		is_global = 0,
		name = "书房",
		type_prioritys = "",
		touch_id = "",
		id = 14002,
		room_id = 14,
		watch_camera = "Table",
		special_action = ""
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.dorm3d_zone_template

	var_1_23[14003] = {
		is_global = 0,
		name = "客厅",
		type_prioritys = "",
		touch_id = "",
		id = 14003,
		room_id = 14,
		watch_camera = "Chair",
		special_action = ""
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.dorm3d_zone_template

	var_1_24[16001] = {
		is_global = 0,
		name = "舞池",
		type_prioritys = "",
		id = 16001,
		room_id = 16,
		watch_camera = "xinzexi",
		special_action = "",
		touch_id = {
			{
				10517,
				1051790
			}
		}
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.dorm3d_zone_template

	var_1_25[16002] = {
		is_global = 0,
		name = "吧台",
		type_prioritys = "",
		id = 16002,
		room_id = 16,
		watch_camera = "dafeng",
		special_action = "",
		touch_id = {
			{
				30707,
				3070790
			}
		}
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.dorm3d_zone_template

	var_1_26[16003] = {
		is_global = 0,
		name = "卡座",
		type_prioritys = "",
		id = 16003,
		room_id = 16,
		watch_camera = "aijier",
		special_action = "",
		touch_id = {
			{
				49905,
				4990590
			}
		}
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.dorm3d_zone_template

	var_1_27[16004] = {
		is_global = 0,
		name = "休息区",
		type_prioritys = "",
		id = 16004,
		room_id = 16,
		watch_camera = "tianlangxing",
		special_action = "",
		touch_id = {
			{
				20220,
				10100401
			}
		}
	}
	pg = var_1_27

	local var_1_28 = var_1_27.base.dorm3d_zone_template

	var_1_28[21001] = {
		is_global = 0,
		name = "卧室",
		type_prioritys = "",
		touch_id = "",
		id = 21001,
		room_id = 21,
		watch_camera = "Bed",
		special_action = ""
	}
	pg = var_1_28

	local var_1_29 = var_1_28.base.dorm3d_zone_template

	var_1_29[21002] = {
		is_global = 0,
		name = "工房",
		type_prioritys = "",
		touch_id = "",
		id = 21002,
		room_id = 21,
		watch_camera = "Table",
		special_action = ""
	}
	pg = var_1_29

	local var_1_30 = var_1_29.base.dorm3d_zone_template

	var_1_30[21003] = {
		is_global = 0,
		name = "客厅",
		type_prioritys = "",
		touch_id = "",
		id = 21003,
		room_id = 21,
		watch_camera = "Chair",
		special_action = ""
	}
	pg = var_1_30

	local var_1_31 = var_1_30.base.dorm3d_zone_template

	var_1_31[26001] = {
		is_global = 0,
		name = "停车间",
		type_prioritys = "",
		touch_id = "",
		id = 26001,
		room_id = 26,
		watch_camera = "Parking",
		special_action = ""
	}
	pg = var_1_31

	local var_1_32 = var_1_31.base.dorm3d_zone_template

	var_1_32[26002] = {
		is_global = 0,
		name = "休息区",
		type_prioritys = "",
		touch_id = "",
		id = 26002,
		room_id = 26,
		watch_camera = "Relax",
		special_action = ""
	}
	pg = var_1_32
	var_1_32.base.dorm3d_zone_template[26003] = {
		is_global = 0,
		name = "训练区",
		type_prioritys = "",
		touch_id = "",
		id = 26003,
		room_id = 26,
		watch_camera = "Train",
		special_action = ""
	}

	return
end)()

return
