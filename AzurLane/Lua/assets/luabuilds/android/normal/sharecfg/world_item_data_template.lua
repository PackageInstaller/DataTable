pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "world_item_data_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "world_item_data_template"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.world_item_data_template = var_0_2
pg = var_0

local var_0_3 = var_0.world_item_data_template

var_0_3.all = {
	100,
	101,
	102,
	103,
	104,
	105,
	110,
	120,
	201,
	202,
	203,
	204,
	205,
	206,
	251,
	252,
	253,
	301,
	302,
	303,
	304,
	305,
	306,
	2002,
	2003,
	2004,
	2005,
	2006,
	2014,
	2015,
	2016,
	2050,
	2051,
	2052,
	2053,
	2054,
	2055,
	2056,
	2057,
	2058,
	2059,
	2101,
	2102,
	2103,
	2111,
	2112,
	2113,
	2114,
	2115,
	2116,
	2117,
	2118,
	2119,
	2120,
	2121,
	2122,
	100011,
	100012,
	100013,
	100014,
	100021,
	100023,
	100024,
	100025,
	100031,
	100032,
	100033,
	100034,
	100041,
	100042,
	100043,
	100051,
	100052,
	100053,
	100054,
	100061,
	100062,
	100063,
	100064,
	100065,
	100066,
	100071,
	100072,
	100073,
	100081,
	100082,
	100083,
	100084,
	100085,
	100091,
	100092,
	100093,
	100094,
	100095,
	100101,
	100102,
	100103,
	100104,
	100105,
	100106,
	100111,
	100112,
	100113,
	100114,
	100121,
	100122,
	100123,
	100124,
	100125,
	100131,
	100132,
	100133,
	100134,
	100135,
	100141,
	100142,
	100143,
	100144,
	100151,
	100152,
	100153,
	100155,
	100156,
	100157,
	100158,
	100159,
	110011,
	110012,
	110013,
	110014,
	110042,
	110051,
	110052,
	110053,
	110054,
	110061,
	110063,
	110064,
	110071,
	110072,
	110073,
	110082,
	110085,
	110091,
	110101,
	110102,
	110103,
	110104,
	110106,
	110121,
	110124,
	110142,
	110144,
	110151,
	110152,
	110153,
	110155,
	110156,
	110157,
	110158,
	110159,
	2000000,
	2000001,
	2000002,
	2000003,
	2000004,
	2000005,
	2000006,
	2000007,
	2000008,
	2000009,
	2100001,
	2100002,
	2100003,
	2100011,
	2100012,
	2100013,
	2100014,
	2100015,
	2100021,
	2100022,
	2100030
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.world_item_data_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.world_item_data_template

	var_1_0[100] = {
		item_transform_item_type = 1,
		name = "作战补给凭证",
		item_transform_item_id = 3002,
		item_transform_item_number = 1,
		log_text = "",
		display = "大型作战中广泛发放的补给兑换凭证，用于交换常规资源。作战结束后将会统一回收，请注意保有期限。",
		icon = "Props/Wdashijiehuobi",
		sort_priority = 4,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 100,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 100,
		usage_arg = {},
		item_origin = {
			201,
			3,
			4,
			5,
			6,
			7
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.world_item_data_template

	var_1_1[101] = {
		item_transform_item_type = 1,
		name = "特别兑换凭证",
		item_transform_item_id = 3002,
		item_transform_item_number = 1,
		log_text = "",
		display = "作战中少量发放的稀有兑换凭证，用于交换特殊资源。作战结束后将会统一回收，请注意保有期限。",
		icon = "Props/Wdashijiezhaungbeibi",
		sort_priority = 4,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 101,
		usage_arg = {},
		item_origin = {
			100,
			201,
			3,
			7,
			8,
			9,
			10,
			11
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.world_item_data_template

	var_1_2[102] = {
		item_transform_item_type = 0,
		name = "战役信息记录仪",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "由指挥部特别制作，储存有大型作战全部资料的情报记录仪。使用以后可以获得大型作战的全部海域信息，解除所有移动限制，侦察全部普通海域，并获得全部调查奖励。",
		icon = "Props/xinxizhongduan4",
		sort_priority = 4,
		usage = "usage_world_clean",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 102,
		usage_arg = {},
		item_origin = {
			101
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.world_item_data_template

	var_1_3[103] = {
		item_transform_item_type = 1,
		name = "仲裁机关战利品回收箱（小）",
		item_transform_item_id = 3002,
		item_transform_item_number = 100,
		log_text = "",
		display = "击破仲裁机关量产型机体后回收的战利品箱。作战结束后将会自动转换为100战备物资兑换券。",
		icon = "Props/Wsairencailiao3",
		sort_priority = 4,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 103,
		usage_arg = {},
		item_origin = {
			12
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.world_item_data_template

	var_1_4[104] = {
		item_transform_item_type = 1,
		name = "仲裁机关战利品回收箱（中）",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "击破仲裁机关量产型机体后回收的战利品箱。作战结束后将会自动转换为200战备物资兑换券。",
		icon = "Props/Wsairencailiao1",
		sort_priority = 4,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 104,
		usage_arg = {},
		item_origin = {
			12
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.world_item_data_template

	var_1_5[105] = {
		item_transform_item_type = 1,
		name = "仲裁机关战利品回收箱（大）",
		item_transform_item_id = 3002,
		item_transform_item_number = 500,
		log_text = "",
		display = "击破仲裁机关量产型机体后回收的战利品箱。作战结束后将会自动转换为500战备物资兑换券。",
		icon = "Props/Wsairencailiao2",
		sort_priority = 4,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 105,
		usage_arg = {},
		item_origin = {
			12
		}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.world_item_data_template

	var_1_6[110] = {
		item_transform_item_type = 1,
		name = "塞壬能源储存容器",
		item_transform_item_id = 3002,
		item_transform_item_number = 5,
		log_text = "",
		display = "保存完好的能源存储器，能够用于维持部分塞壬设施的运转，无爆炸危险。",
		icon = "Props/jingtidianchi",
		sort_priority = 4,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 110,
		usage_arg = {},
		item_origin = {
			100,
			201,
			4,
			7
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.world_item_data_template

	var_1_7[120] = {
		item_transform_item_type = 0,
		name = "隐秘海域信息记录仪",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "由指挥部特别制作，储存有全部隐秘海域资料的信息记录仪。使用以后将会自动侦察本期大型作战期间的所有隐秘海域，并解锁隐秘海域计划模式。",
		icon = "Props/W120",
		sort_priority = 4,
		usage = "usage_world_flag",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 120,
		usage_arg = {
			1
		},
		item_origin = {
			101
		}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.world_item_data_template

	var_1_8[201] = {
		item_transform_item_type = 0,
		name = "应急维修箱",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "使用后，恢复当前舰队中1名角色耐久值1000点。",
		icon = "Props/Wshengminghuifu1",
		sort_priority = 5,
		usage = "usage_world_healing_value",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 201,
		usage_arg = {
			1,
			1000
		},
		item_origin = {
			100,
			201,
			4,
			7
		}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.world_item_data_template

	var_1_9[202] = {
		item_transform_item_type = 0,
		name = "豪华维修箱",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "使用后，恢复当前舰队中1名角色耐久值3000点。",
		icon = "Props/Wshengminghuifu2",
		sort_priority = 5,
		usage = "usage_world_healing_value",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 202,
		usage_arg = {
			1,
			3000
		},
		item_origin = {
			100,
			201,
			4
		}
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.world_item_data_template

	var_1_10[203] = {
		item_transform_item_type = 0,
		name = "应急维修箱（组件）",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "使用后，恢复当前舰队中至多3名角色耐久值500点。",
		icon = "Props/Wshengminghuifu3",
		sort_priority = 5,
		usage = "usage_world_healing_value",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 203,
		usage_arg = {
			3,
			500
		},
		item_origin = {
			100,
			201,
			4,
			7
		}
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.world_item_data_template

	var_1_11[204] = {
		item_transform_item_type = 0,
		name = "豪华应急维修箱（组件）",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "使用后，恢复当前舰队中至多3名角色耐久值1500点。",
		icon = "Props/Wshengminghuifu4",
		sort_priority = 5,
		usage = "usage_world_healing_value",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 204,
		usage_arg = {
			3,
			1500
		},
		item_origin = {
			100,
			201,
			4
		}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.world_item_data_template

	var_1_12[205] = {
		item_transform_item_type = 0,
		name = "应急维修箱（套装）",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "使用后，恢复当前舰队中所有角色耐久值上限的30%。",
		icon = "Props/Wshengminghuifu5",
		sort_priority = 5,
		usage = "usage_world_healing",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 205,
		usage_arg = {
			6,
			3000
		},
		item_origin = {
			100,
			201,
			4,
			7
		}
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.world_item_data_template

	var_1_13[206] = {
		item_transform_item_type = 0,
		name = "豪华应急维修箱（套装）",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "使用后，恢复当前舰队中所有角色耐久值上限的100%。",
		icon = "Props/Wshengminghuifu6",
		sort_priority = 5,
		usage = "usage_world_healing",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 206,
		usage_arg = {
			6,
			10000
		},
		item_origin = {
			100,
			201,
			4,
			10
		}
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.world_item_data_template

	var_1_14[251] = {
		item_transform_item_type = 0,
		name = "能源补给箱（小）",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "使用后，可获得大型作战海域行动力20点。",
		icon = "Props/Wxingdonglihuifu1",
		sort_priority = 6,
		usage = "usage_world_recoverAP",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 251,
		usage_arg = {
			20
		},
		item_origin = {
			100,
			201,
			3
		}
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.world_item_data_template

	var_1_15[252] = {
		item_transform_item_type = 0,
		name = "能源补给箱（中）",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "使用后，可获得大型作战海域行动力50点。",
		icon = "Props/Wxingdonglihuifu2",
		sort_priority = 6,
		usage = "usage_world_recoverAP",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 252,
		usage_arg = {
			50
		},
		item_origin = {
			100,
			201,
			3
		}
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.world_item_data_template

	var_1_16[253] = {
		item_transform_item_type = 0,
		name = "能源补给箱（大）",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "使用后，可获得大型作战海域行动力100点。",
		icon = "Props/Wxingdonglihuifu3",
		sort_priority = 6,
		usage = "usage_world_recoverAP",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 253,
		usage_arg = {
			100
		},
		item_origin = {
			100,
			201
		}
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.world_item_data_template

	var_1_17[301] = {
		item_transform_item_type = 0,
		name = "效能样本-攻击",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "完成分析的特殊数据样本，使用后能提升[适应性调整-攻击]5点。",
		icon = "Props/Wyangben1",
		sort_priority = 7,
		usage = "usage_worldSLGbuff",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 301,
		usage_arg = {
			401,
			5
		},
		item_origin = {
			100
		}
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.world_item_data_template

	var_1_18[302] = {
		item_transform_item_type = 0,
		name = "效能样本-耐久",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "完成分析的特殊数据样本，使用后能提升[适应性调整-耐久]5点。",
		icon = "Props/Wyangben3",
		sort_priority = 7,
		usage = "usage_worldSLGbuff",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 302,
		usage_arg = {
			402,
			5
		},
		item_origin = {
			100
		}
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.world_item_data_template

	var_1_19[303] = {
		item_transform_item_type = 0,
		name = "效能样本-恢复",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "完成分析的特殊数据样本，使用后能提升[适应性调整-恢复]5点。",
		icon = "Props/Wyangben5",
		sort_priority = 7,
		usage = "usage_worldSLGbuff",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 303,
		usage_arg = {
			403,
			5
		},
		item_origin = {
			100
		}
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.world_item_data_template

	var_1_20[304] = {
		item_transform_item_type = 0,
		name = "强力效能样本-攻击",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "完成分析的特殊数据样本，使用后能提升[适应性调整-攻击]10点。",
		icon = "Props/Wyangben2",
		sort_priority = 7,
		usage = "usage_worldSLGbuff",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 304,
		usage_arg = {
			401,
			10
		},
		item_origin = {
			100
		}
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.world_item_data_template

	var_1_21[305] = {
		item_transform_item_type = 0,
		name = "强力效能样本-耐久",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "完成分析的特殊数据样本，使用后能提升[适应性调整-耐久]10点。",
		icon = "Props/Wyangben4",
		sort_priority = 7,
		usage = "usage_worldSLGbuff",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 305,
		usage_arg = {
			402,
			10
		},
		item_origin = {
			100
		}
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.world_item_data_template

	var_1_22[306] = {
		item_transform_item_type = 0,
		name = "强力效能样本-恢复",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "完成分析的特殊数据样本，使用后能提升[适应性调整-恢复]10点。",
		icon = "Props/Wyangben6",
		sort_priority = 7,
		usage = "usage_worldSLGbuff",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 306,
		usage_arg = {
			403,
			10
		},
		item_origin = {
			100
		}
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.world_item_data_template

	var_1_23[2002] = {
		item_transform_item_type = 1,
		name = "海域坐标记录仪R2",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "一个记录有神秘坐标的仪器。解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanputong2",
		sort_priority = 1,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 1,
		open_directly = 1,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		usage_arg = "1030001",
		id = 2002,
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.world_item_data_template

	var_1_24[2003] = {
		item_transform_item_type = 1,
		name = "海域坐标记录仪R3",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "一个记录有神秘坐标的仪器。解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanputong3",
		sort_priority = 1,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 1,
		open_directly = 1,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		usage_arg = "1030002",
		id = 2003,
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.world_item_data_template

	var_1_25[2004] = {
		item_transform_item_type = 1,
		name = "海域坐标记录仪R4",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "一个记录有神秘坐标的仪器。解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanputong4",
		sort_priority = 1,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 1,
		open_directly = 1,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		usage_arg = "1030003",
		id = 2004,
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.world_item_data_template

	var_1_26[2005] = {
		item_transform_item_type = 1,
		name = "海域坐标记录仪R5",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "一个记录有神秘坐标的仪器。解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanputong5",
		sort_priority = 1,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 1,
		open_directly = 1,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1030004",
		id = 2005,
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.world_item_data_template

	var_1_27[2006] = {
		item_transform_item_type = 1,
		name = "海域坐标记录仪R6",
		item_transform_item_id = 3002,
		item_transform_item_number = 160,
		log_text = "",
		display = "一个记录有神秘坐标的仪器。解析显示坐标位于侵蚀等级6的海域，请指挥官小心应对。",
		icon = "Props/Wluopanputong6",
		sort_priority = 1,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 1,
		open_directly = 1,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1030005",
		id = 2006,
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_1_27

	local var_1_28 = var_1_27.base.world_item_data_template

	var_1_28[2014] = {
		item_transform_item_type = 1,
		name = "塞壬坐标记录仪R4",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "一个包含可疑科技模块的记录仪器。解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanputong4",
		sort_priority = 1,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 1,
		open_directly = 1,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1030006",
		id = 2014,
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_1_28

	local var_1_29 = var_1_28.base.world_item_data_template

	var_1_29[2015] = {
		item_transform_item_type = 1,
		name = "塞壬坐标记录仪R5",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "一个包含可疑科技模块的记录仪器。解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanputong5",
		sort_priority = 1,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 1,
		open_directly = 1,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1030007",
		id = 2015,
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_1_29

	local var_1_30 = var_1_29.base.world_item_data_template

	var_1_30[2016] = {
		item_transform_item_type = 1,
		name = "塞壬坐标记录仪R6",
		item_transform_item_id = 3002,
		item_transform_item_number = 800,
		log_text = "",
		display = "一个包含可疑科技模块的记录仪器。解析显示坐标位于侵蚀等级6的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanputong6",
		sort_priority = 1,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 1,
		open_directly = 1,
		grid_num = 1,
		rarity = 5,
		expired_date = "",
		usage_arg = "1030008",
		id = 2016,
		item_origin = {
			100,
			201,
			7
		}
	}
	pg = var_1_30

	local var_1_31 = var_1_30.base.world_item_data_template

	var_1_31[2050] = {
		item_transform_item_type = 0,
		name = "档案坐标记录仪1",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "解析后可以获得一系列档案任务，前往对应海域完成任务可回收总计10份档案（141-1至142-4）。<color=#ff5c5c>该物品仅能购买1次，不会随大型作战周期性重置而重置，购买后将会自动使用。档案任务同一时间只能接取一组。</color>",
		icon = "Props/Wdanganluopan1",
		sort_priority = 1,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2050,
		usage_arg = {},
		item_origin = {}
	}
	pg = var_1_31

	local var_1_32 = var_1_31.base.world_item_data_template

	var_1_32[2051] = {
		item_transform_item_type = 0,
		name = "档案坐标记录仪2",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "解析后可以获得一系列档案任务，前往对应海域完成任务可回收总计10份档案（142-5至142-6、111-1至111-8）。<color=#ff5c5c>该物品仅能购买1次，不会随大型作战周期性重置而重置，购买后将会自动使用。档案任务同一时间只能接取一组。</color>",
		icon = "Props/Wdanganluopan2",
		sort_priority = 1,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2051,
		usage_arg = {},
		item_origin = {}
	}
	pg = var_1_32

	local var_1_33 = var_1_32.base.world_item_data_template

	var_1_33[2052] = {
		item_transform_item_type = 0,
		name = "档案坐标记录仪3",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "解析后可以获得一系列档案任务，前往对应海域完成任务可回收总计10份档案（115-1至115-4、131-1至131-6）。<color=#ff5c5c>该物品仅能购买1次，不会随大型作战周期性重置而重置，购买后将会自动使用。档案任务同一时间只能接取一组。</color>",
		icon = "Props/Wdanganluopan3",
		sort_priority = 1,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2052,
		usage_arg = {},
		item_origin = {}
	}
	pg = var_1_33

	local var_1_34 = var_1_33.base.world_item_data_template

	var_1_34[2053] = {
		item_transform_item_type = 0,
		name = "档案坐标记录仪4",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "解析后可以获得一系列档案任务，前往对应海域完成任务可回收总计10份档案（115-5至115-6、144-1至144-8）。<color=#ff5c5c>该物品仅能购买1次，不会随大型作战周期性重置而重置，购买后将会自动使用。档案任务同一时间只能接取一组。</color>",
		icon = "Props/Wdanganluopan4",
		sort_priority = 1,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2053,
		usage_arg = {},
		item_origin = {}
	}
	pg = var_1_34

	local var_1_35 = var_1_34.base.world_item_data_template

	var_1_35[2054] = {
		item_transform_item_type = 0,
		name = "档案坐标记录仪5",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "解析后可以获得一系列档案任务，前往对应海域完成任务可回收总计12份档案（131-1至131-6、143-1至143-6）。<color=#ff5c5c>该物品仅能购买1次，不会随大型作战周期性重置而重置，购买后将会自动使用。档案任务同一时间只能接取一组。</color>",
		icon = "Props/Wdanganluopan5",
		sort_priority = 1,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2054,
		usage_arg = {},
		item_origin = {}
	}
	pg = var_1_35

	local var_1_36 = var_1_35.base.world_item_data_template

	var_1_36[2055] = {
		item_transform_item_type = 0,
		name = "档案坐标记录仪6",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "解析后可以获得一系列档案任务，前往对应海域完成任务可回收总计12份档案（113-1至113-6、133-1至133-6）。<color=#ff5c5c>该物品仅能购买1次，不会随大型作战周期性重置而重置，购买后将会自动使用。档案任务同一时间只能接取一组。</color>",
		icon = "Props/Wdanganluopan6",
		sort_priority = 1,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2055,
		usage_arg = {},
		item_origin = {}
	}
	pg = var_1_36

	local var_1_37 = var_1_36.base.world_item_data_template

	var_1_37[2056] = {
		item_transform_item_type = 0,
		name = "档案坐标记录仪7",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "解析后可以获得一系列档案任务，前往对应海域完成任务可回收总计10份档案（144-9至144-10、146-1至146-8）。<color=#ff5c5c>该物品仅能购买1次，不会随大型作战周期性重置而重置，购买后将会自动使用。档案任务同一时间只能接取一组。</color>",
		icon = "Props/Wdanganluopan7",
		sort_priority = 1,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2056,
		usage_arg = {},
		item_origin = {}
	}
	pg = var_1_37

	local var_1_38 = var_1_37.base.world_item_data_template

	var_1_38[2057] = {
		item_transform_item_type = 0,
		name = "档案坐标记录仪8",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "解析后可以获得一系列档案任务，前往对应海域完成任务可回收总计11份档案（116-1至116-9、144-11、146-9）。<color=#ff5c5c>该物品仅能购买1次，不会随大型作战周期性重置而重置，购买后将会自动使用。档案任务同一时间只能接取一组。</color>",
		icon = "Props/Wdanganluopan8",
		sort_priority = 1,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2057,
		usage_arg = {},
		item_origin = {}
	}
	pg = var_1_38

	local var_1_39 = var_1_38.base.world_item_data_template

	var_1_39[2058] = {
		item_transform_item_type = 0,
		name = "档案坐标记录仪9",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "解析后可以获得一系列档案任务，前往对应海域完成任务可回收总计10份档案（150-4、151-5至151-6、180-1、190-1至190-6）。<color=#ff5c5c>该物品仅能购买1次，不会随大型作战周期性重置而重置，购买后将会自动使用。档案任务同一时间只能接取一组。</color>",
		icon = "Props/Wdanganluopan9",
		sort_priority = 1,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2058,
		usage_arg = {},
		item_origin = {}
	}
	pg = var_1_39

	local var_1_40 = var_1_39.base.world_item_data_template

	var_1_40[2059] = {
		item_transform_item_type = 0,
		name = "档案坐标记录仪10",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "解析后可以接到档案任务，前往对应的档案海域完成任务，回收档案。 ",
		icon = "Props/Wdanganluopan10",
		sort_priority = 1,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2059,
		usage_arg = {},
		item_origin = {}
	}
	pg = var_1_40

	local var_1_41 = var_1_40.base.world_item_data_template

	var_1_41[2101] = {
		item_transform_item_type = 0,
		name = "装备研发物资箱T1",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "包含若干个随机稀有品质的装备研发物资。",
		icon = "Props/Wsucaixiang3",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		usage_arg = "1030009",
		id = 2101,
		item_origin = {
			100
		}
	}
	pg = var_1_41

	local var_1_42 = var_1_41.base.world_item_data_template

	var_1_42[2102] = {
		item_transform_item_type = 0,
		name = "装备研发物资箱T2",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "包含若干个随机精锐品质的装备研发物资。",
		icon = "Props/Wsucaixiang2",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		usage_arg = "1030010",
		id = 2102,
		item_origin = {
			100
		}
	}
	pg = var_1_42

	local var_1_43 = var_1_42.base.world_item_data_template

	var_1_43[2103] = {
		item_transform_item_type = 0,
		name = "装备研发物资箱T3",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "包含若干个随机超稀有品质的装备研发物资。",
		icon = "Props/Wsucaixiang1",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1030011",
		id = 2103,
		item_origin = {
			100
		}
	}
	pg = var_1_43

	local var_1_44 = var_1_43.base.world_item_data_template

	var_1_44[2111] = {
		item_transform_item_type = 0,
		name = "常规实验计划",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "购买后能得到若干份[常规实验计划]，可用于进行装备研发。",
		icon = "Props/18125",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		usage_arg = "1030012",
		id = 2111,
		item_origin = {
			100
		}
	}
	pg = var_1_44

	local var_1_45 = var_1_44.base.world_item_data_template

	var_1_45[2112] = {
		item_transform_item_type = 0,
		name = "机密实验计划",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "购买后能得到若干份[机密实验计划]，可用于进行装备研发。",
		icon = "Props/18126",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1030013",
		id = 2112,
		item_origin = {
			100
		}
	}
	pg = var_1_45

	local var_1_46 = var_1_45.base.world_item_data_template

	var_1_46[2113] = {
		item_transform_item_type = 0,
		name = "未知装备部件T4",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "购买后能得到若干个随机装备部件T4，可用于进行装备研发。",
		icon = "Props/Wsuijibujian",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1030014",
		id = 2113,
		item_origin = {
			100
		}
	}
	pg = var_1_46

	local var_1_47 = var_1_46.base.world_item_data_template

	var_1_47[2114] = {
		item_transform_item_type = 0,
		name = "试作型突破部件",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "购买后能得到若干个试作型突破部件，可用于进行装备强化突破。",
		icon = "Props/17990",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1030015",
		id = 2114,
		item_origin = {
			100
		}
	}
	pg = var_1_47

	local var_1_48 = var_1_47.base.world_item_data_template

	var_1_48[2115] = {
		item_transform_item_type = 0,
		name = "特装型突破部件",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "购买后能得到若干个特装型突破部件，可用于进行装备强化突破。",
		icon = "Props/17991",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 5,
		expired_date = "",
		usage_arg = "1030016",
		id = 2115,
		item_origin = {
			100
		}
	}
	pg = var_1_48

	local var_1_49 = var_1_48.base.world_item_data_template

	var_1_49[2116] = {
		item_transform_item_type = 0,
		name = "结晶化热强钢",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "购买后能得到若干个用于提升舰装火炮性能的稀有材料，可在「META研究室」-「舰装修复」中使用。",
		icon = "Props/21101",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1030017",
		id = 2116,
		item_origin = {}
	}
	pg = var_1_49

	local var_1_50 = var_1_49.base.world_item_data_template

	var_1_50[2117] = {
		item_transform_item_type = 0,
		name = "纳米陶铝合金",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "购买后能得到若干个用于提升舰装航空性能的稀有材料，可在「META研究室」-「舰装修复」中使用。",
		icon = "Props/21111",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1030018",
		id = 2117,
		item_origin = {}
	}
	pg = var_1_50

	local var_1_51 = var_1_50.base.world_item_data_template

	var_1_51[2118] = {
		item_transform_item_type = 0,
		name = "可塑性机械臂",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "购买后能得到若干个用于提升舰装装填性能的稀有材料，可在「META研究室」-「舰装修复」中使用。",
		icon = "Props/21121",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1030019",
		id = 2118,
		item_origin = {}
	}
	pg = var_1_51

	local var_1_52 = var_1_51.base.world_item_data_template

	var_1_52[2119] = {
		item_transform_item_type = 0,
		name = "超空泡发生器",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "购买后能得到若干个用于提升舰装雷击性能的稀有材料，可在「META研究室」-「舰装修复」中使用。",
		icon = "Props/21131",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1030020",
		id = 2119,
		item_origin = {}
	}
	pg = var_1_52

	local var_1_53 = var_1_52.base.world_item_data_template

	var_1_53[2120] = {
		item_transform_item_type = 2,
		name = "装备研发图纸SSR型",
		item_transform_item_id = 30914,
		item_transform_item_number = 1,
		log_text = "",
		display = "使用后可从以下[装备研发图纸SSR型]中任意选择一种获得1个",
		icon = "Props/Wshejitujin",
		sort_priority = 2,
		usage = "usage_drop_appointed",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2120,
		usage_arg = {
			{
				2,
				18117,
				1
			},
			{
				2,
				18119,
				1
			},
			{
				2,
				18121,
				1
			},
			{
				2,
				18123,
				1
			}
		},
		item_origin = {}
	}
	pg = var_1_53

	local var_1_54 = var_1_53.base.world_item_data_template

	var_1_54[2121] = {
		item_transform_item_type = 2,
		name = "装备研发图纸UR型",
		item_transform_item_id = 30915,
		item_transform_item_number = 1,
		log_text = "",
		display = "使用后可从以下[装备研发图纸UR型]中任意选择一种获得1个",
		icon = "Props/Wshejitucai",
		sort_priority = 2,
		usage = "usage_drop_appointed",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 1,
		rarity = 5,
		expired_date = "",
		id = 2121,
		usage_arg = {
			{
				2,
				18118,
				1
			},
			{
				2,
				18120,
				1
			},
			{
				2,
				18122,
				1
			},
			{
				2,
				18124,
				1
			}
		},
		item_origin = {}
	}
	pg = var_1_54

	local var_1_55 = var_1_54.base.world_item_data_template

	var_1_55[2122] = {
		item_transform_item_type = 0,
		name = "绝密实验计划",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "购买后能得到1个[绝密实验计划]，可用于进行装备研发。",
		icon = "Props/18127",
		sort_priority = 2,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 0,
		open_directly = 1,
		grid_num = 1,
		rarity = 5,
		expired_date = "",
		usage_arg = "1030023",
		id = 2122,
		item_origin = {
			100
		}
	}
	pg = var_1_55

	local var_1_56 = var_1_55.base.world_item_data_template

	var_1_56[100011] = {
		item_transform_item_type = 1,
		name = "海域坐标:卡利比安海A",
		item_transform_item_id = 3002,
		item_transform_item_number = 160,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100011,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_1_56

	local var_1_57 = var_1_56.base.world_item_data_template

	var_1_57[100012] = {
		item_transform_item_type = 1,
		name = "海域坐标:卡利比安海B",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100012,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_1_57

	local var_1_58 = var_1_57.base.world_item_data_template

	var_1_58[100013] = {
		item_transform_item_type = 1,
		name = "海域坐标:卡利比安海C",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100013,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_1_58

	local var_1_59 = var_1_58.base.world_item_data_template

	var_1_59[100014] = {
		item_transform_item_type = 1,
		name = "海域坐标:卡利比安海D",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100014,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_59

	local var_1_60 = var_1_59.base.world_item_data_template

	var_1_60[100021] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西南A",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100021,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_60

	local var_1_61 = var_1_60.base.world_item_data_template

	var_1_61[100023] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西南C",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100023,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_61

	local var_1_62 = var_1_61.base.world_item_data_template

	var_1_62[100024] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西南D",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100024,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_62

	local var_1_63 = var_1_62.base.world_item_data_template

	var_1_63[100025] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西南E",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100025,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_63

	local var_1_64 = var_1_63.base.world_item_data_template

	var_1_64[100031] = {
		item_transform_item_type = 1,
		name = "海域坐标:西南洋脊A",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100031,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_64

	local var_1_65 = var_1_64.base.world_item_data_template

	var_1_65[100032] = {
		item_transform_item_type = 1,
		name = "海域坐标:西南洋脊B",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100032,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_65

	local var_1_66 = var_1_65.base.world_item_data_template

	var_1_66[100033] = {
		item_transform_item_type = 1,
		name = "海域坐标:西南洋脊C",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100033,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_66

	local var_1_67 = var_1_66.base.world_item_data_template

	var_1_67[100034] = {
		item_transform_item_type = 1,
		name = "海域坐标:西南洋脊D",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100034,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_67

	local var_1_68 = var_1_67.base.world_item_data_template

	var_1_68[100041] = {
		item_transform_item_type = 1,
		name = "海域坐标:西大陆架A",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100041,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_68

	local var_1_69 = var_1_68.base.world_item_data_template

	var_1_69[100042] = {
		item_transform_item_type = 1,
		name = "海域坐标:西大陆架B",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100042,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_69

	local var_1_70 = var_1_69.base.world_item_data_template

	var_1_70[100043] = {
		item_transform_item_type = 1,
		name = "海域坐标:西大陆架C",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100043,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_70

	local var_1_71 = var_1_70.base.world_item_data_template

	var_1_71[100051] = {
		item_transform_item_type = 1,
		name = "海域坐标:东南洋脊A",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100051,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_71

	local var_1_72 = var_1_71.base.world_item_data_template

	var_1_72[100052] = {
		item_transform_item_type = 1,
		name = "海域坐标:东南洋脊B",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100052,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_72

	local var_1_73 = var_1_72.base.world_item_data_template

	var_1_73[100053] = {
		item_transform_item_type = 1,
		name = "海域坐标:东南洋脊C",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100053,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_73

	local var_1_74 = var_1_73.base.world_item_data_template

	var_1_74[100054] = {
		item_transform_item_type = 1,
		name = "海域坐标:东南洋脊D",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100054,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_74

	local var_1_75 = var_1_74.base.world_item_data_template

	var_1_75[100061] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东南A",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100061,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_75

	local var_1_76 = var_1_75.base.world_item_data_template

	var_1_76[100062] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东南B",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100062,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_76

	local var_1_77 = var_1_76.base.world_item_data_template

	var_1_77[100063] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东南C",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100063,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_77

	local var_1_78 = var_1_77.base.world_item_data_template

	var_1_78[100064] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东南D",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100064,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_78

	local var_1_79 = var_1_78.base.world_item_data_template

	var_1_79[100065] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东南E",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100065,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_79

	local var_1_80 = var_1_79.base.world_item_data_template

	var_1_80[100066] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东南F",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100066,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_80

	local var_1_81 = var_1_80.base.world_item_data_template

	var_1_81[100071] = {
		item_transform_item_type = 1,
		name = "海域坐标:陆间海A",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100071,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_1_81

	local var_1_82 = var_1_81.base.world_item_data_template

	var_1_82[100072] = {
		item_transform_item_type = 1,
		name = "海域坐标:陆间海B",
		item_transform_item_id = 3002,
		item_transform_item_number = 160,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100072,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_1_82

	local var_1_83 = var_1_82.base.world_item_data_template

	var_1_83[100073] = {
		item_transform_item_type = 1,
		name = "海域坐标:陆间海C",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100073,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_1_83

	local var_1_84 = var_1_83.base.world_item_data_template

	var_1_84[100081] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西A",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100081,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_84

	local var_1_85 = var_1_84.base.world_item_data_template

	var_1_85[100082] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西B",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100082,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_85

	local var_1_86 = var_1_85.base.world_item_data_template

	var_1_86[100083] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西C",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100083,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_86

	local var_1_87 = var_1_86.base.world_item_data_template

	var_1_87[100084] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西D",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100084,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_87

	local var_1_88 = var_1_87.base.world_item_data_template

	var_1_88[100085] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西E",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100085,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_88

	local var_1_89 = var_1_88.base.world_item_data_template

	var_1_89[100091] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西北A",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100091,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_89

	local var_1_90 = var_1_89.base.world_item_data_template

	var_1_90[100092] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西北B",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100092,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_90

	local var_1_91 = var_1_90.base.world_item_data_template

	var_1_91[100093] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西北C",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100093,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_91

	local var_1_92 = var_1_91.base.world_item_data_template

	var_1_92[100094] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西北D",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100094,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_92

	local var_1_93 = var_1_92.base.world_item_data_template

	var_1_93[100095] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域西北E",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100095,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_93

	local var_1_94 = var_1_93.base.world_item_data_template

	var_1_94[5] = {
		item_transform_item_type = 1,
		name = "海域坐标:西北航道A",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100101,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_1_94

	local var_1_95 = var_1_94.base.world_item_data_template

	var_1_95[6] = {
		item_transform_item_type = 1,
		name = "海域坐标:西北航道B",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100102,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_1_95

	local var_1_96 = var_1_95.base.world_item_data_template

	var_1_96[7] = {
		item_transform_item_type = 1,
		name = "海域坐标:西北航道C",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100103,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_96

	local var_1_97 = var_1_96.base.world_item_data_template

	var_1_97[8] = {
		item_transform_item_type = 1,
		name = "海域坐标:西北航道D",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100104,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_97

	local var_1_98 = var_1_97.base.world_item_data_template

	var_1_98[9] = {
		item_transform_item_type = 1,
		name = "海域坐标:西北航道E",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100105,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_1_98
	var_1_98.base.world_item_data_template[10] = {
		item_transform_item_type = 1,
		name = "海域坐标:西北航道F",
		item_transform_item_id = 3002,
		item_transform_item_number = 160,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100106,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}

	return
end)()
;(function()
	pg = var_1_10000

	local var_2_0 = var_1_10000.base.world_item_data_template

	var_2_0[15] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东A",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100111,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_0

	local var_2_1 = var_2_0.base.world_item_data_template

	var_2_1[16] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东B",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100112,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_1

	local var_2_2 = var_2_1.base.world_item_data_template

	var_2_2[17] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东C",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100113,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_2

	local var_2_3 = var_2_2.base.world_item_data_template

	var_2_3[18] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东D",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100114,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_3

	local var_2_4 = var_2_3.base.world_item_data_template

	var_2_4[25] = {
		item_transform_item_type = 1,
		name = "海域坐标:东大陆架A",
		item_transform_item_id = 3002,
		item_transform_item_number = 160,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100121,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_4

	local var_2_5 = var_2_4.base.world_item_data_template

	var_2_5[26] = {
		item_transform_item_type = 1,
		name = "海域坐标:东大陆架B",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100122,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_5

	local var_2_6 = var_2_5.base.world_item_data_template

	var_2_6[27] = {
		item_transform_item_type = 1,
		name = "海域坐标:东大陆架C",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100123,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_6

	local var_2_7 = var_2_6.base.world_item_data_template

	var_2_7[28] = {
		item_transform_item_type = 1,
		name = "海域坐标:东大陆架D",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100124,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_7

	local var_2_8 = var_2_7.base.world_item_data_template

	var_2_8[29] = {
		item_transform_item_type = 1,
		name = "海域坐标:东大陆架E",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100125,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_8

	local var_2_9 = var_2_8.base.world_item_data_template

	var_2_9[100131] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东北A",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100131,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_9

	local var_2_10 = var_2_9.base.world_item_data_template

	var_2_10[100132] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东北B",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100132,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_10

	local var_2_11 = var_2_10.base.world_item_data_template

	var_2_11[100133] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东北C",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100133,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_11

	local var_2_12 = var_2_11.base.world_item_data_template

	var_2_12[100134] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东北D",
		item_transform_item_id = 3002,
		item_transform_item_number = 10,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级2的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo2",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 2,
		expired_date = "",
		id = 100134,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_12

	local var_2_13 = var_2_12.base.world_item_data_template

	var_2_13[100135] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域东北E",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100135,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_13

	local var_2_14 = var_2_13.base.world_item_data_template

	var_2_14[100141] = {
		item_transform_item_type = 1,
		name = "海域坐标:东北航道A",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100141,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_14

	local var_2_15 = var_2_14.base.world_item_data_template

	var_2_15[100142] = {
		item_transform_item_type = 1,
		name = "海域坐标:东北航道B",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100142,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_15

	local var_2_16 = var_2_15.base.world_item_data_template

	var_2_16[100143] = {
		item_transform_item_type = 1,
		name = "海域坐标:东北航道C",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级3的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo3",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 3,
		expired_date = "",
		id = 100143,
		usage_arg = {},
		item_origin = {
			100,
			7
		}
	}
	pg = var_2_16

	local var_2_17 = var_2_16.base.world_item_data_template

	var_2_17[100144] = {
		item_transform_item_type = 1,
		name = "海域坐标:东北航道D",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100144,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_17

	local var_2_18 = var_2_17.base.world_item_data_template

	var_2_18[100151] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域深处A",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100151,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_18

	local var_2_19 = var_2_18.base.world_item_data_template

	var_2_19[100152] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域深处B",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100152,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_19

	local var_2_20 = var_2_19.base.world_item_data_template

	var_2_20[100153] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域深处C",
		item_transform_item_id = 3002,
		item_transform_item_number = 160,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100153,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_20

	local var_2_21 = var_2_20.base.world_item_data_template

	var_2_21[100155] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域深处D",
		item_transform_item_id = 3002,
		item_transform_item_number = 160,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100155,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_21

	local var_2_22 = var_2_21.base.world_item_data_template

	var_2_22[100156] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域深处E",
		item_transform_item_id = 3002,
		item_transform_item_number = 160,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100156,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_22

	local var_2_23 = var_2_22.base.world_item_data_template

	var_2_23[100157] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域深处F",
		item_transform_item_id = 3002,
		item_transform_item_number = 160,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100157,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_23

	local var_2_24 = var_2_23.base.world_item_data_template

	var_2_24[100158] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域深处G",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100158,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_24

	local var_2_25 = var_2_24.base.world_item_data_template

	var_2_25[100159] = {
		item_transform_item_type = 1,
		name = "海域坐标:NA海域深处H",
		item_transform_item_id = 3002,
		item_transform_item_number = 80,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，请指挥官小心应对。",
		icon = "Props/Wluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 100159,
		usage_arg = {},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_25

	local var_2_26 = var_2_25.base.world_item_data_template

	var_2_26[110011] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:卡利比安海A",
		item_transform_item_id = 3002,
		item_transform_item_number = 800,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 5,
		expired_date = "",
		id = 110011,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			201,
			7
		}
	}
	pg = var_2_26

	local var_2_27 = var_2_26.base.world_item_data_template

	var_2_27[110012] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:卡利比安海B",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110012,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_27

	local var_2_28 = var_2_27.base.world_item_data_template

	var_2_28[110013] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:卡利比安海C",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110013,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_28

	local var_2_29 = var_2_28.base.world_item_data_template

	var_2_29[110014] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:卡利比安海D",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110014,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_29

	local var_2_30 = var_2_29.base.world_item_data_template

	var_2_30[110042] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:西大陆架B",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110042,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_30

	local var_2_31 = var_2_30.base.world_item_data_template

	var_2_31[110051] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:东南洋脊A",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110051,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_31

	local var_2_32 = var_2_31.base.world_item_data_template

	var_2_32[110052] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:东南洋脊B",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110052,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_32

	local var_2_33 = var_2_32.base.world_item_data_template

	var_2_33[110053] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:东南洋脊C",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110053,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_33

	local var_2_34 = var_2_33.base.world_item_data_template

	var_2_34[110054] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:东南洋脊D",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110054,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_34

	local var_2_35 = var_2_34.base.world_item_data_template

	var_2_35[110061] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域东南A",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110061,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_35

	local var_2_36 = var_2_35.base.world_item_data_template

	var_2_36[110063] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域东南C",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110063,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_36

	local var_2_37 = var_2_36.base.world_item_data_template

	var_2_37[110064] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域东南D",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110064,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_37

	local var_2_38 = var_2_37.base.world_item_data_template

	var_2_38[110071] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:陆间海A",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110071,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_38

	local var_2_39 = var_2_38.base.world_item_data_template

	var_2_39[110072] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:陆间海B",
		item_transform_item_id = 3002,
		item_transform_item_number = 800,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 5,
		expired_date = "",
		id = 110072,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			201,
			7
		}
	}
	pg = var_2_39

	local var_2_40 = var_2_39.base.world_item_data_template

	var_2_40[110073] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:陆间海C",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110073,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_40

	local var_2_41 = var_2_40.base.world_item_data_template

	var_2_41[2] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域西B",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110082,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_41

	local var_2_42 = var_2_41.base.world_item_data_template

	var_2_42[5] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域西E",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110085,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_42

	local var_2_43 = var_2_42.base.world_item_data_template

	var_2_43[11] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域西北A",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110091,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_43

	local var_2_44 = var_2_43.base.world_item_data_template

	var_2_44[21] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:西北航道A",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110101,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_44

	local var_2_45 = var_2_44.base.world_item_data_template

	var_2_45[22] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:西北航道B",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110102,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_45

	local var_2_46 = var_2_45.base.world_item_data_template

	var_2_46[23] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:西北航道C",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110103,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_46

	local var_2_47 = var_2_46.base.world_item_data_template

	var_2_47[24] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:西北航道D",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110104,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_47

	local var_2_48 = var_2_47.base.world_item_data_template

	var_2_48[26] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:西北航道F",
		item_transform_item_id = 3002,
		item_transform_item_number = 800,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 5,
		expired_date = "",
		id = 110106,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			201,
			7
		}
	}
	pg = var_2_48

	local var_2_49 = var_2_48.base.world_item_data_template

	var_2_49[110121] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:东大陆架A",
		item_transform_item_id = 3002,
		item_transform_item_number = 800,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 5,
		expired_date = "",
		id = 110121,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			201,
			7
		}
	}
	pg = var_2_49

	local var_2_50 = var_2_49.base.world_item_data_template

	var_2_50[110124] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:东大陆架D",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110124,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_50

	local var_2_51 = var_2_50.base.world_item_data_template

	var_2_51[110142] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:东北航道B",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级4的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo4",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110142,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			7
		}
	}
	pg = var_2_51

	local var_2_52 = var_2_51.base.world_item_data_template

	var_2_52[110144] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:东北航道D",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110144,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_52

	local var_2_53 = var_2_52.base.world_item_data_template

	var_2_53[110151] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域深处A",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110151,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_53

	local var_2_54 = var_2_53.base.world_item_data_template

	var_2_54[110152] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域深处B",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110152,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_54

	local var_2_55 = var_2_54.base.world_item_data_template

	var_2_55[110153] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域深处C",
		item_transform_item_id = 3002,
		item_transform_item_number = 800,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 5,
		expired_date = "",
		id = 110153,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			201,
			7
		}
	}
	pg = var_2_55

	local var_2_56 = var_2_55.base.world_item_data_template

	var_2_56[110155] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域深处D",
		item_transform_item_id = 3002,
		item_transform_item_number = 800,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 5,
		expired_date = "",
		id = 110155,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			201,
			7
		}
	}
	pg = var_2_56

	local var_2_57 = var_2_56.base.world_item_data_template

	var_2_57[110156] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域深处E",
		item_transform_item_id = 3002,
		item_transform_item_number = 800,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 5,
		expired_date = "",
		id = 110156,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			201,
			7
		}
	}
	pg = var_2_57

	local var_2_58 = var_2_57.base.world_item_data_template

	var_2_58[110157] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域深处F",
		item_transform_item_id = 3002,
		item_transform_item_number = 800,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级6的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo6",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 5,
		expired_date = "",
		id = 110157,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			201,
			7
		}
	}
	pg = var_2_58

	local var_2_59 = var_2_58.base.world_item_data_template

	var_2_59[110158] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域深处G",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110158,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_59

	local var_2_60 = var_2_59.base.world_item_data_template

	var_2_60[110159] = {
		item_transform_item_type = 1,
		name = "塞壬坐标:NA海域深处H",
		item_transform_item_id = 3002,
		item_transform_item_number = 400,
		log_text = "",
		display = "解析显示坐标位于侵蚀等级5的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanjihuo5",
		sort_priority = 10,
		usage = "usage_world_map",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 0,
		rarity = 4,
		expired_date = "",
		id = 110159,
		usage_arg = {
			1
		},
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_60

	local var_2_61 = var_2_60.base.world_item_data_template

	var_2_61[0] = {
		item_transform_item_type = 0,
		name = "作战效能-攻击",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "针对大型作战特殊环境而进行的舰装适应性调整，该数值体现敌方单位的攻击力变化程度。",
		icon = "Props/Wbuff1",
		sort_priority = 10,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 2000000,
		usage_arg = {},
		item_origin = {
			5,
			6
		}
	}
	pg = var_2_61

	local var_2_62 = var_2_61.base.world_item_data_template

	var_2_62[1] = {
		item_transform_item_type = 0,
		name = "作战效能-耐久",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "针对大型作战特殊环境而进行的舰装适应性调整，该数值体现敌方单位的耐久值变化程度。",
		icon = "Props/Wbuff2",
		sort_priority = 10,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 2000001,
		usage_arg = {},
		item_origin = {
			5,
			6
		}
	}
	pg = var_2_62

	local var_2_63 = var_2_62.base.world_item_data_template

	var_2_63[2] = {
		item_transform_item_type = 0,
		name = "作战效能-恢复",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "针对大型作战特殊环境而进行的舰装适应性调整，该数值影响战斗中己方角色受到的恢复效果。",
		icon = "Props/Wbuff3",
		sort_priority = 10,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 2000002,
		usage_arg = {},
		item_origin = {
			5,
			6
		}
	}
	pg = var_2_63

	local var_2_64 = var_2_63.base.world_item_data_template

	var_2_64[3] = {
		item_transform_item_type = 0,
		name = "作战效能-攻击",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "针对大型作战特殊环境而进行的舰装适应性调整，该数值体现敌方单位的攻击力变化程度。",
		icon = "Props/Wbuff1",
		sort_priority = 10,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2000003,
		usage_arg = {},
		item_origin = {
			5,
			6
		}
	}
	pg = var_2_64

	local var_2_65 = var_2_64.base.world_item_data_template

	var_2_65[4] = {
		item_transform_item_type = 0,
		name = "作战效能-耐久",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "针对大型作战特殊环境而进行的舰装适应性调整，该数值体现敌方单位的耐久值变化程度。",
		icon = "Props/Wbuff2",
		sort_priority = 10,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2000004,
		usage_arg = {},
		item_origin = {
			5,
			6
		}
	}
	pg = var_2_65

	local var_2_66 = var_2_65.base.world_item_data_template

	var_2_66[5] = {
		item_transform_item_type = 0,
		name = "作战效能-恢复",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "针对大型作战特殊环境而进行的舰装适应性调整，该数值影响战斗中己方角色受到的恢复效果。",
		icon = "Props/Wbuff3",
		sort_priority = 10,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2000005,
		usage_arg = {},
		item_origin = {
			5,
			6
		}
	}
	pg = var_2_66

	local var_2_67 = var_2_66.base.world_item_data_template

	var_2_67[6] = {
		item_transform_item_type = 0,
		name = "作战补给凭证",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "在大型作战中用于兑换补给资源的凭证代币，在作战结束后会统一回收，请及时花光哦。",
		icon = "Props/Wdashijiehuobi",
		sort_priority = 10,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 2000006,
		usage_arg = {},
		item_origin = {
			201,
			3,
			4,
			5,
			6,
			7
		}
	}
	pg = var_2_67

	local var_2_68 = var_2_67.base.world_item_data_template

	var_2_68[7] = {
		item_transform_item_type = 0,
		name = "作战补给凭证",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "在大型作战中用于兑换补给资源的凭证代币，在作战结束后会统一回收，请及时花光哦。",
		icon = "Props/Wdashijiehuobi",
		sort_priority = 10,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 2000007,
		usage_arg = {},
		item_origin = {
			201,
			3,
			4,
			5,
			6,
			7
		}
	}
	pg = var_2_68

	local var_2_69 = var_2_68.base.world_item_data_template

	var_2_69[8] = {
		item_transform_item_type = 0,
		name = "能源补给箱（小）",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "使用后，可获得大型作战海域行动力20点。",
		icon = "Props/Wxingdonglihuifu1",
		sort_priority = 10,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 2000008,
		usage_arg = {},
		item_origin = {
			100,
			201,
			4,
			7
		}
	}
	pg = var_2_69

	local var_2_70 = var_2_69.base.world_item_data_template

	var_2_70[9] = {
		item_transform_item_type = 0,
		name = "应急维修箱",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "使用后，恢复当前舰队中1名角色耐久值1000点。",
		icon = "Props/Wshengminghuifu1",
		sort_priority = 10,
		usage = "usage_world_healing_value",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 2000009,
		usage_arg = {},
		item_origin = {
			100,
			201,
			3,
			7
		}
	}
	pg = var_2_70

	local var_2_71 = var_2_70.base.world_item_data_template

	var_2_71[2100001] = {
		item_transform_item_type = 1,
		name = "海域坐标记录仪",
		item_transform_item_id = 3002,
		item_transform_item_number = 20,
		log_text = "",
		display = "一个记录有神秘坐标的仪器。解析显示坐标位于侵蚀等级3-4的海域，请指挥官小心应对。",
		icon = "Props/Wluopanputong",
		sort_priority = 1,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		usage_arg = "1000021",
		id = 2100001,
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_71

	local var_2_72 = var_2_71.base.world_item_data_template

	var_2_72[2100002] = {
		item_transform_item_type = 1,
		name = "海域坐标记录仪",
		item_transform_item_id = 3002,
		item_transform_item_number = 40,
		log_text = "",
		display = "一个记录有神秘坐标的仪器。解析显示坐标位于侵蚀等级4-6的海域，请指挥官小心应对。",
		icon = "Props/Wluopanputong",
		sort_priority = 1,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		usage_arg = "1000022",
		id = 2100002,
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_72

	local var_2_73 = var_2_72.base.world_item_data_template

	var_2_73[2100003] = {
		item_transform_item_type = 1,
		name = "塞壬坐标记录仪",
		item_transform_item_id = 3002,
		item_transform_item_number = 200,
		log_text = "",
		display = "一个包含可疑科技模块的记录仪器。解析显示坐标位于侵蚀等级4-6的海域，将会遭遇到强力塞壬旗舰，请指挥官小心应对。",
		icon = "Props/Wsairenluopanputong",
		sort_priority = 1,
		usage = "usage_drop",
		open_box = "",
		item_transform_num = 1,
		open_directly = 0,
		grid_num = 1,
		rarity = 5,
		expired_date = "",
		usage_arg = "1000023",
		id = 2100003,
		item_origin = {
			100,
			101,
			201,
			7
		}
	}
	pg = var_2_73

	local var_2_74 = var_2_73.base.world_item_data_template

	var_2_74[2100011] = {
		item_transform_item_type = 0,
		name = "装备研发物资箱T1",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "包含若干个随机稀有品质的装备研发物资。",
		icon = "Props/Wsucaixiang3",
		sort_priority = 2,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 2,
		expired_date = "",
		id = 2100011,
		usage_arg = {},
		item_origin = {
			100,
			201,
			7,
			8,
			9,
			10,
			11
		}
	}
	pg = var_2_74

	local var_2_75 = var_2_74.base.world_item_data_template

	var_2_75[2100012] = {
		item_transform_item_type = 0,
		name = "装备研发物资箱T2",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "包含若干个随机精锐品质的装备研发物资。",
		icon = "Props/Wsucaixiang2",
		sort_priority = 2,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 3,
		expired_date = "",
		id = 2100012,
		usage_arg = {},
		item_origin = {
			100,
			201,
			7,
			8,
			9,
			10,
			11
		}
	}
	pg = var_2_75

	local var_2_76 = var_2_75.base.world_item_data_template

	var_2_76[2100013] = {
		item_transform_item_type = 0,
		name = "装备研发物资箱T3",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "包含若干个随机超稀有品质的装备研发物资。",
		icon = "Props/Wsucaixiang1",
		sort_priority = 2,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2100013,
		usage_arg = {},
		item_origin = {
			100,
			201,
			7,
			8,
			9,
			10,
			11
		}
	}
	pg = var_2_76

	local var_2_77 = var_2_76.base.world_item_data_template

	var_2_77[2100014] = {
		item_transform_item_type = 0,
		name = "未知装备研发图纸SSR型",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "获得随机一张[装备研发图纸SSR型]，可用于进行装备研发",
		icon = "Props/Wshejitujin",
		sort_priority = 2,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2100014,
		usage_arg = {},
		item_origin = {
			100,
			201,
			7,
			8,
			9,
			10,
			11
		}
	}
	pg = var_2_77

	local var_2_78 = var_2_77.base.world_item_data_template

	var_2_78[2100015] = {
		item_transform_item_type = 0,
		name = "未知装备研发图纸UR型",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "获得随机一张[装备研发图纸UR型]，可用于进行装备研发",
		icon = "Props/Wshejitucai",
		sort_priority = 2,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 5,
		expired_date = "",
		id = 2100015,
		usage_arg = {},
		item_origin = {}
	}
	pg = var_2_78

	local var_2_79 = var_2_78.base.world_item_data_template

	var_2_79[2100021] = {
		item_transform_item_type = 0,
		name = "未知装备部件T4",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "获得随机一个装备部件T4，可用于进行装备研发",
		icon = "Props/Wsuijibujian",
		sort_priority = 2,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2100021,
		usage_arg = {},
		item_origin = {
			100,
			201,
			7,
			8,
			9,
			10,
			11
		}
	}
	pg = var_2_79

	local var_2_80 = var_2_79.base.world_item_data_template

	var_2_80[2100022] = {
		item_transform_item_type = 0,
		name = "试作型突破部件",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "能够开发出SSR型及以下装备额外性能的实验部件。",
		icon = "Props/17990",
		sort_priority = 2,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2100022,
		usage_arg = {},
		item_origin = {
			100,
			201,
			7,
			8,
			9,
			10,
			11
		}
	}
	pg = var_2_80
	var_2_80.base.world_item_data_template[2100030] = {
		item_transform_item_type = 0,
		name = "未知档案",
		item_transform_item_id = 0,
		item_transform_item_number = 0,
		log_text = "",
		display = "一份可供获取的未知档案，不知道记录着什么内容呢？",
		icon = "Props/Wdanganicon",
		sort_priority = 2,
		usage = "usage_undefined",
		open_box = "",
		item_transform_num = 0,
		open_directly = 0,
		grid_num = 1,
		rarity = 4,
		expired_date = "",
		id = 2100030,
		usage_arg = {},
		item_origin = {}
	}

	return
end)()

return
