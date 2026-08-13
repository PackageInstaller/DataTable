pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "dorm3d_furniture_slot_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_furniture_slot_template"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.dorm3d_furniture_slot_template = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_furniture_slot_template

var_0_3.all = {
	100101,
	100102,
	100201,
	100202,
	100301,
	100402,
	120101,
	120102,
	120103,
	120201,
	120202,
	120203,
	120301,
	120302,
	120303,
	130101,
	130102,
	130103,
	130201,
	130202,
	130301,
	130302,
	140101,
	1110101,
	1110102,
	1110201,
	1110202,
	1110203,
	1110204,
	1110301,
	1110302,
	1110303,
	1120101,
	1120102,
	1120103,
	1120104,
	1120203,
	1120301,
	1120302,
	1120303,
	1120304,
	1140101,
	1140102,
	1140103,
	1140201,
	1140202,
	1140301,
	1140302,
	1140303,
	2210101,
	2210102,
	2210103,
	2210201,
	2210301,
	2210302,
	2210303,
	2210304
}
pg = var_0_3

local var_0_4 = var_0_3.dorm3d_furniture_slot_template

var_0_4.get_id_list_by_room_id = {
	{
		100101,
		100102,
		100201,
		100202,
		100301,
		100402
	},
	{
		120101,
		120102,
		120103,
		120201,
		120202,
		120203,
		120301,
		120302,
		120303
	},
	{
		130101,
		130102,
		130103,
		130201,
		130202,
		130301,
		130302
	},
	{
		140101
	},
	[11] = {
		1110101,
		1110102,
		1110201,
		1110202,
		1110203,
		1110204,
		1110301,
		1110302,
		1110303
	},
	[12] = {
		1120101,
		1120102,
		1120103,
		1120104,
		1120203,
		1120301,
		1120302,
		1120303,
		1120304
	},
	[14] = {
		1140101,
		1140102,
		1140103,
		1140201,
		1140202,
		1140301,
		1140302,
		1140303
	},
	[21] = {
		2210101,
		2210102,
		2210103,
		2210201,
		2210301,
		2210302,
		2210303,
		2210304
	}
}
pg = var_0_4

local var_0_5 = var_0_4.dorm3d_furniture_slot_template

var_0_5.get_id_list_by_zone_id = {
	[1001] = {
		100101,
		100102
	},
	[1002] = {
		100201,
		100202
	},
	[1003] = {
		100301
	},
	[1004] = {
		100402
	},
	[2001] = {
		120101,
		120102,
		120103
	},
	[2002] = {
		120201,
		120202,
		120203
	},
	[2003] = {
		120301,
		120302,
		120303
	},
	[3001] = {
		130101,
		130102,
		130103
	},
	[3002] = {
		130201,
		130202
	},
	[3003] = {
		130301,
		130302
	},
	[4005] = {
		140101
	},
	[11001] = {
		1110101,
		1110102
	},
	[11002] = {
		1110201,
		1110202,
		1110203,
		1110204
	},
	[11003] = {
		1110301,
		1110302,
		1110303
	},
	[12001] = {
		1120101,
		1120102,
		1120103,
		1120104
	},
	[12002] = {
		1120203
	},
	[12003] = {
		1120301,
		1120302,
		1120303,
		1120304
	},
	[14001] = {
		1140101,
		1140102,
		1140103
	},
	[14002] = {
		1140201,
		1140202
	},
	[14003] = {
		1140301,
		1140302,
		1140303
	},
	[21001] = {
		2210101,
		2210102,
		2210103
	},
	[21002] = {
		2210201
	},
	[21003] = {
		2210301,
		2210302,
		2210303,
		2210304
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
var_0_5.base.dorm3d_furniture_slot_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_furniture_slot_template

	var_1_0[5] = {
		default_furniture = 0,
		name = "卧室桌子",
		type = 3,
		id = 100101,
		room_id = 1,
		furniture_name = "pre_db_chandelier07",
		zone_id = 1001
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_furniture_slot_template

	var_1_1[6] = {
		default_furniture = 4,
		name = "卧室床",
		type = 4,
		id = 100102,
		room_id = 1,
		furniture_name = "pre_db_bed01",
		zone_id = 1001
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.dorm3d_furniture_slot_template

	var_1_2[100201] = {
		default_furniture = 0,
		name = "餐厅桌子",
		type = 3,
		id = 100201,
		room_id = 1,
		furniture_name = "pre_db_electrical03",
		zone_id = 1002
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.dorm3d_furniture_slot_template

	var_1_3[100202] = {
		default_furniture = 1,
		name = "餐厅椅子",
		type = 6,
		id = 100202,
		room_id = 1,
		furniture_name = "pre_db_chair05_01",
		zone_id = 1002
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.dorm3d_furniture_slot_template

	var_1_4[100301] = {
		default_furniture = 3,
		name = "客厅沙发",
		type = 5,
		id = 100301,
		room_id = 1,
		furniture_name = "pre_db_chair01",
		zone_id = 1003
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.dorm3d_furniture_slot_template

	var_1_5[100402] = {
		default_furniture = 0,
		name = "换衣间置物架",
		type = 3,
		id = 100402,
		room_id = 1,
		furniture_name = "pre_db_decoration03 (1)",
		zone_id = 1004
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.dorm3d_furniture_slot_template

	var_1_6[120101] = {
		default_furniture = 0,
		name = "卧室床边摆件",
		type = 3,
		id = 120101,
		room_id = 2,
		furniture_name = "pre_db_nh_vase01",
		zone_id = 2001
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.dorm3d_furniture_slot_template

	var_1_7[120102] = {
		default_furniture = 0,
		name = "卧室床头摆件",
		type = 3,
		id = 120102,
		room_id = 2,
		furniture_name = "pre_db_nh_toy02",
		zone_id = 2001
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.dorm3d_furniture_slot_template

	var_1_8[120103] = {
		default_furniture = 201,
		name = "卧室床",
		type = 4,
		id = 120103,
		room_id = 2,
		furniture_name = "pre_db_bed02",
		zone_id = 2001
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.dorm3d_furniture_slot_template

	var_1_9[9] = {
		default_furniture = 0,
		name = "餐厅桌子摆件",
		type = 3,
		id = 120201,
		room_id = 2,
		furniture_name = "pre_db_nh_tableware02",
		zone_id = 2002
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.dorm3d_furniture_slot_template

	var_1_10[10] = {
		default_furniture = 207,
		name = "餐厅墙上装饰",
		type = 3,
		id = 120202,
		room_id = 2,
		furniture_name = "pre_db_nh_decoration03",
		zone_id = 2002
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.dorm3d_furniture_slot_template

	var_1_11[11] = {
		default_furniture = 202,
		name = "餐厅椅子",
		type = 6,
		id = 120203,
		room_id = 2,
		furniture_name = "pre_db_table05a",
		zone_id = 2002
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.dorm3d_furniture_slot_template

	var_1_12[120301] = {
		default_furniture = 208,
		name = "客厅窗边盆栽",
		type = 3,
		id = 120301,
		room_id = 2,
		furniture_name = "pre_db_nh_flowerpot02",
		zone_id = 2003
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.dorm3d_furniture_slot_template

	var_1_13[120302] = {
		default_furniture = 0,
		name = "客厅柜子摆件",
		type = 3,
		id = 120302,
		room_id = 2,
		furniture_name = "pre_db_nh_vase02",
		zone_id = 2003
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.dorm3d_furniture_slot_template

	var_1_14[120303] = {
		default_furniture = 203,
		name = "客厅沙发",
		type = 5,
		id = 120303,
		room_id = 2,
		furniture_name = "pre_db_chair07",
		zone_id = 2003
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.dorm3d_furniture_slot_template

	var_1_15[130101] = {
		default_furniture = 0,
		name = "卧室帐篷玩偶",
		type = 3,
		id = 130101,
		room_id = 3,
		furniture_name = "pre_db_ah_toy05",
		zone_id = 3001
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.dorm3d_furniture_slot_template

	var_1_16[130102] = {
		default_furniture = 0,
		name = "卧室床边摆件",
		type = 3,
		id = 130102,
		room_id = 3,
		furniture_name = "pre_db_ah_pottedplant01",
		zone_id = 3001
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.dorm3d_furniture_slot_template

	var_1_17[130103] = {
		default_furniture = 301,
		name = "卧室床",
		type = 4,
		id = 130103,
		room_id = 3,
		furniture_name = "pre_db_bed03",
		zone_id = 3001
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.dorm3d_furniture_slot_template

	var_1_18[25] = {
		default_furniture = 0,
		name = "娱乐区画框",
		type = 3,
		id = 130201,
		room_id = 3,
		furniture_name = "pre_db_ah_billboard01_group01",
		zone_id = 3002
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.dorm3d_furniture_slot_template

	var_1_19[26] = {
		default_furniture = 302,
		name = "娱乐区",
		type = 6,
		id = 130202,
		room_id = 3,
		furniture_name = "pre_db_carpet20",
		zone_id = 3002
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.dorm3d_furniture_slot_template

	var_1_20[130301] = {
		default_furniture = 0,
		name = "客厅窗户玩偶",
		type = 3,
		id = 130301,
		room_id = 3,
		furniture_name = "pre_db_ah_decoration02",
		zone_id = 3003
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.dorm3d_furniture_slot_template

	var_1_21[130302] = {
		default_furniture = 303,
		name = "客厅沙发",
		type = 5,
		id = 130302,
		room_id = 3,
		furniture_name = "pre_db_chair15",
		zone_id = 3003
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.dorm3d_furniture_slot_template

	var_1_22[140101] = {
		default_furniture = 0,
		name = "沙滩滑梯",
		type = 3,
		id = 140101,
		room_id = 4,
		furniture_name = "Slide",
		zone_id = 4005
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.dorm3d_furniture_slot_template

	var_1_23[1110101] = {
		default_furniture = 0,
		name = "卧室书架",
		type = 3,
		id = 1110101,
		room_id = 11,
		furniture_name = "no_bake_prop_substitute",
		zone_id = 11001
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.dorm3d_furniture_slot_template

	var_1_24[1110102] = {
		default_furniture = 1101,
		name = "卧室床",
		type = 4,
		id = 1110102,
		room_id = 11,
		furniture_name = "pre_db_bed04",
		zone_id = 11001
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.dorm3d_furniture_slot_template

	var_1_25[1110201] = {
		default_furniture = 0,
		name = "餐厅微波炉",
		type = 3,
		id = 1110201,
		room_id = 11,
		furniture_name = "pre_db_njh_electrical03",
		zone_id = 11002
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.dorm3d_furniture_slot_template

	var_1_26[1110202] = {
		default_furniture = 0,
		name = "餐厅绿植",
		type = 3,
		id = 1110202,
		room_id = 11,
		furniture_name = "pre_db_njh_pottedplant01",
		zone_id = 11002
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.dorm3d_furniture_slot_template

	var_1_27[1110203] = {
		default_furniture = 1102,
		name = "冰箱",
		type = 6,
		id = 1110203,
		room_id = 11,
		furniture_name = "pre_db_appliances04",
		zone_id = 11002
	}
	pg = var_1_27

	local var_1_28 = var_1_27.base.dorm3d_furniture_slot_template

	var_1_28[1110204] = {
		default_furniture = 0,
		name = "冰箱",
		type = 6,
		id = 1110204,
		room_id = 11,
		furniture_name = "pre_db_njh_kitchen01",
		zone_id = 11002
	}
	pg = var_1_28

	local var_1_29 = var_1_28.base.dorm3d_furniture_slot_template

	var_1_29[29] = {
		default_furniture = 0,
		name = "客厅画框",
		type = 3,
		id = 1110301,
		room_id = 11,
		furniture_name = "pre_db_njh_billboard01",
		zone_id = 11003
	}
	pg = var_1_29

	local var_1_30 = var_1_29.base.dorm3d_furniture_slot_template

	var_1_30[30] = {
		default_furniture = 0,
		name = "客厅水缸",
		type = 3,
		id = 1110302,
		room_id = 11,
		furniture_name = "pre_db_njh_fishtank01",
		zone_id = 11003
	}
	pg = var_1_30

	local var_1_31 = var_1_30.base.dorm3d_furniture_slot_template

	var_1_31[31] = {
		default_furniture = 1103,
		name = "客厅沙发",
		type = 5,
		id = 1110303,
		room_id = 11,
		furniture_name = "pre_db_chair19_group",
		zone_id = 11003
	}
	pg = var_1_31

	local var_1_32 = var_1_31.base.dorm3d_furniture_slot_template

	var_1_32[1120101] = {
		default_furniture = 0,
		name = "卧室比基尼",
		type = 3,
		id = 1120101,
		room_id = 12,
		furniture_name = "pre_db_df_cloth01",
		zone_id = 12001
	}
	pg = var_1_32

	local var_1_33 = var_1_32.base.dorm3d_furniture_slot_template

	var_1_33[1120102] = {
		default_furniture = 0,
		name = "卧室屏风",
		type = 3,
		id = 1120102,
		room_id = 12,
		furniture_name = "pre_db_df_frame01",
		zone_id = 12001
	}
	pg = var_1_33

	local var_1_34 = var_1_33.base.dorm3d_furniture_slot_template

	var_1_34[1120103] = {
		default_furniture = 1201,
		name = "卧室床",
		type = 4,
		id = 1120103,
		room_id = 12,
		furniture_name = "pre_db_df_bedroom01_0",
		zone_id = 12001
	}
	pg = var_1_34

	local var_1_35 = var_1_34.base.dorm3d_furniture_slot_template

	var_1_35[1120104] = {
		default_furniture = 0,
		name = "卧室小灯",
		type = 3,
		id = 1120104,
		room_id = 12,
		furniture_name = "pre_db_df_desklamp01",
		zone_id = 12001
	}
	pg = var_1_35

	local var_1_36 = var_1_35.base.dorm3d_furniture_slot_template

	var_1_36[1120203] = {
		default_furniture = 1202,
		name = "餐厅餐桌",
		type = 6,
		id = 1120203,
		room_id = 12,
		furniture_name = "pre_db_df_kitchen01_0",
		zone_id = 12002
	}
	pg = var_1_36

	local var_1_37 = var_1_36.base.dorm3d_furniture_slot_template

	var_1_37[1120301] = {
		default_furniture = 0,
		name = "客厅挂画",
		type = 3,
		id = 1120301,
		room_id = 12,
		furniture_name = "pre_db_df_wallscrolls01",
		zone_id = 12003
	}
	pg = var_1_37

	local var_1_38 = var_1_37.base.dorm3d_furniture_slot_template

	var_1_38[1120302] = {
		default_furniture = 0,
		name = "客厅落地灯",
		type = 3,
		id = 1120302,
		room_id = 12,
		furniture_name = "pre_db_df_floorlamp01",
		zone_id = 12003
	}
	pg = var_1_38

	local var_1_39 = var_1_38.base.dorm3d_furniture_slot_template

	var_1_39[1120303] = {
		default_furniture = 1203,
		name = "客厅沙发",
		type = 5,
		id = 1120303,
		room_id = 12,
		furniture_name = "pre_db_df_livingroom01_0",
		zone_id = 12003
	}
	pg = var_1_39

	local var_1_40 = var_1_39.base.dorm3d_furniture_slot_template

	var_1_40[1120304] = {
		default_furniture = 0,
		name = "客厅特典",
		type = 99,
		id = 1120304,
		room_id = 12,
		furniture_name = "pre_db_df_tedian01",
		zone_id = 12003
	}
	pg = var_1_40

	local var_1_41 = var_1_40.base.dorm3d_furniture_slot_template

	var_1_41[5] = {
		default_furniture = 1401,
		name = "卧室床",
		type = 4,
		id = 1140101,
		room_id = 14,
		furniture_name = "pre_db_aijier_bed01_0",
		zone_id = 14001
	}
	pg = var_1_41

	local var_1_42 = var_1_41.base.dorm3d_furniture_slot_template

	var_1_42[6] = {
		default_furniture = 0,
		name = "卧室相机",
		type = 3,
		id = 1140102,
		room_id = 14,
		furniture_name = "pre_db_aje_camera01",
		zone_id = 14001
	}
	pg = var_1_42

	local var_1_43 = var_1_42.base.dorm3d_furniture_slot_template

	var_1_43[7] = {
		default_furniture = 0,
		name = "卧室台灯",
		type = 3,
		id = 1140103,
		room_id = 14,
		furniture_name = "pre_db_aje_desklamp01",
		zone_id = 14001
	}
	pg = var_1_43

	local var_1_44 = var_1_43.base.dorm3d_furniture_slot_template

	var_1_44[1140201] = {
		default_furniture = 1402,
		name = "书房书桌",
		type = 6,
		id = 1140201,
		room_id = 14,
		furniture_name = "pre_db_aijier_study01_0",
		zone_id = 14002
	}
	pg = var_1_44

	local var_1_45 = var_1_44.base.dorm3d_furniture_slot_template

	var_1_45[1140202] = {
		default_furniture = 0,
		name = "书房盆栽",
		type = 3,
		id = 1140202,
		room_id = 14,
		furniture_name = "pre_db_aje_bonsai01",
		zone_id = 14002
	}
	pg = var_1_45

	local var_1_46 = var_1_45.base.dorm3d_furniture_slot_template

	var_1_46[1140301] = {
		default_furniture = 1403,
		name = "客厅沙发",
		type = 5,
		id = 1140301,
		room_id = 14,
		furniture_name = "pre_db_aijier_living01_0",
		zone_id = 14003
	}
	pg = var_1_46

	local var_1_47 = var_1_46.base.dorm3d_furniture_slot_template

	var_1_47[1140302] = {
		default_furniture = 0,
		name = "客厅相框",
		type = 3,
		id = 1140302,
		room_id = 14,
		furniture_name = "pre_db_aje_billboard01",
		zone_id = 14003
	}
	pg = var_1_47

	local var_1_48 = var_1_47.base.dorm3d_furniture_slot_template

	var_1_48[1140303] = {
		default_furniture = 0,
		name = "客厅蜡烛",
		type = 3,
		id = 1140303,
		room_id = 14,
		furniture_name = "pre_db_aje_decoration01",
		zone_id = 14003
	}
	pg = var_1_48

	local var_1_49 = var_1_48.base.dorm3d_furniture_slot_template

	var_1_49[2210101] = {
		default_furniture = 2101,
		name = "卧室床",
		type = 4,
		id = 2210101,
		room_id = 21,
		furniture_name = "pre_db_naximofu_bed01_0",
		zone_id = 21001
	}
	pg = var_1_49

	local var_1_50 = var_1_49.base.dorm3d_furniture_slot_template

	var_1_50[2210102] = {
		default_furniture = 0,
		name = "香薰瓶 ",
		type = 3,
		id = 2210102,
		room_id = 21,
		furniture_name = "pre_db_nxmf_cosmetic01",
		zone_id = 21001
	}
	pg = var_1_50

	local var_1_51 = var_1_50.base.dorm3d_furniture_slot_template

	var_1_51[2210103] = {
		default_furniture = 0,
		name = "黄釉圆瓶 ",
		type = 3,
		id = 2210103,
		room_id = 21,
		furniture_name = "pre_db_nxmf_ceram01",
		zone_id = 21001
	}
	pg = var_1_51

	local var_1_52 = var_1_51.base.dorm3d_furniture_slot_template

	var_1_52[25] = {
		default_furniture = 2102,
		name = "工房置物架",
		type = 6,
		id = 2210201,
		room_id = 21,
		furniture_name = "pre_db_naximofu_basement01_0",
		zone_id = 21002
	}
	pg = var_1_52

	local var_1_53 = var_1_52.base.dorm3d_furniture_slot_template

	var_1_53[2210301] = {
		default_furniture = 2103,
		name = "客厅沙发",
		type = 5,
		id = 2210301,
		room_id = 21,
		furniture_name = "pre_db_naximofu_living01_0",
		zone_id = 21003
	}
	pg = var_1_53

	local var_1_54 = var_1_53.base.dorm3d_furniture_slot_template

	var_1_54[2210302] = {
		default_furniture = 0,
		name = "原子球模型",
		type = 3,
		id = 2210302,
		room_id = 21,
		furniture_name = "pre_db_nxmf_decoration01",
		zone_id = 21003
	}
	pg = var_1_54

	local var_1_55 = var_1_54.base.dorm3d_furniture_slot_template

	var_1_55[2210303] = {
		default_furniture = 0,
		name = "窗边绿植 ",
		type = 3,
		id = 2210303,
		room_id = 21,
		furniture_name = "pre_db_nxmf_flowerpot01",
		zone_id = 21003
	}
	pg = var_1_55
	var_1_55.base.dorm3d_furniture_slot_template[0] = {
		default_furniture = 0,
		name = "猫猫坐垫 ",
		type = 3,
		id = 2210304,
		room_id = 21,
		furniture_name = "pre_db_nxmf_cushion01",
		zone_id = 21003
	}

	return
end)()

return
