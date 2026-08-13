pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "world_SLGbuff_data") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "world_SLGbuff_data"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.world_SLGbuff_data = var_0_2
pg = var_0

local var_0_3 = var_0.world_SLGbuff_data

var_0_3.all = {
	1,
	2,
	200,
	201,
	202,
	301,
	302,
	303,
	304,
	305,
	306,
	307,
	308,
	309,
	310,
	311,
	312,
	313,
	314,
	315,
	316,
	317,
	318,
	320,
	321,
	322,
	323,
	324,
	325,
	326,
	401,
	402,
	403,
	600,
	601,
	602,
	610,
	620,
	630,
	700,
	710,
	1010,
	1020,
	1030,
	1040,
	1050,
	1060,
	1110,
	1120,
	1130,
	1210,
	1220,
	1230,
	1240,
	1250,
	1260,
	1270,
	1280,
	1290,
	1300,
	1310,
	1320,
	1410,
	1420,
	1430,
	1440,
	1450,
	1460,
	1470,
	1480,
	1490,
	1500,
	1510,
	1520,
	1530,
	1540,
	1550,
	1560,
	2000,
	2010,
	2020,
	2100,
	2110,
	2120,
	2200,
	2210,
	2220,
	2300,
	2310,
	2320,
	2400,
	2410,
	2420,
	2500,
	2510,
	2520,
	4000,
	4010,
	4020
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.world_SLGbuff_data = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.world_SLGbuff_data

	var_1_0[1] = {
		name = "战损",
		trap_type = 0,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "舰装在近期遭受过致命损伤。雷击、反潜、航空、防空、机动降低60%。可通过港口维修与舰队指令移除这个状态。",
		buff_maxfloor = 1,
		icon = "",
		buff_type = 0,
		delete_move = 0,
		id = 1,
		trap_lua = "",
		buff_attr = {
			"cannon",
			"torpedo",
			"antiaircraft",
			"antisub",
			"air",
			"dodge"
		},
		percent = {
			1,
			1,
			1,
			1,
			1,
			1
		},
		buff_effect = {
			-6000,
			-6000,
			-6000,
			-6000,
			-6000,
			-6000
		},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.world_SLGbuff_data

	var_1_1[2] = {
		name = "塞壬干扰",
		trap_type = 0,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "遭受到了塞壬干扰，舰队进入移动异常状态，无法进行远距离连续移动",
		buff_maxfloor = 1,
		icon = "3070",
		buff_type = 0,
		delete_move = 0,
		id = 2,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.world_SLGbuff_data

	var_1_2[200] = {
		name = "士气低落LV1",
		trap_type = 0,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "舰队士气低落。炮击、雷击、反潜、航空、防空、机动降低10%。可通过取得任意战斗胜利与舰队指令移除这个状态。",
		buff_maxfloor = 1,
		icon = "200",
		buff_type = 0,
		delete_move = 0,
		id = 200,
		trap_lua = "",
		buff_attr = {
			"cannon",
			"torpedo",
			"antiaircraft",
			"antisub",
			"air",
			"dodge"
		},
		percent = {
			1,
			1,
			1,
			1,
			1,
			1
		},
		buff_effect = {
			-1000,
			-1000,
			-1000,
			-1000,
			-1000,
			-1000
		},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.world_SLGbuff_data

	var_1_3[201] = {
		name = "士气低落LV2",
		trap_type = 0,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "舰队士气低落。炮击、雷击、反潜、航空、防空、机动降低30%。可通过取得任意战斗胜利与舰队指令移除这个状态。",
		buff_maxfloor = 1,
		icon = "201",
		buff_type = 0,
		delete_move = 0,
		id = 201,
		trap_lua = "",
		buff_attr = {
			"cannon",
			"torpedo",
			"antiaircraft",
			"antisub",
			"air",
			"dodge"
		},
		percent = {
			1,
			1,
			1,
			1,
			1,
			1
		},
		buff_effect = {
			-3000,
			-3000,
			-3000,
			-3000,
			-3000,
			-3000
		},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.world_SLGbuff_data

	var_1_4[202] = {
		name = "士气低落LV3",
		trap_type = 0,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "舰队士气低落。炮击、雷击、反潜、航空、防空、机动降低60%。可通过取得任意战斗胜利与舰队指令移除这个状态。",
		buff_maxfloor = 1,
		icon = "202",
		buff_type = 0,
		delete_move = 0,
		id = 202,
		trap_lua = "",
		buff_attr = {
			"cannon",
			"torpedo",
			"antiaircraft",
			"antisub",
			"air",
			"dodge"
		},
		percent = {
			1,
			1,
			1,
			1,
			1,
			1
		},
		buff_effect = {
			-6000,
			-6000,
			-6000,
			-6000,
			-6000,
			-6000
		},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.world_SLGbuff_data

	var_1_5[301] = {
		name = "异常：电磁干扰",
		trap_type = 1,
		lua_id = 0,
		buff_fx = "xuehuaping01",
		delete_round = 5,
		desc = "因为遭受异常电磁干扰，G.M系统显示暂时失效。异常状态将会持续若干行动轮。",
		buff_maxfloor = 1,
		icon = "3010",
		buff_type = 3,
		delete_move = 0,
		id = 301,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.world_SLGbuff_data

	var_1_6[302] = {
		name = "异常：漩涡扰动",
		trap_type = 2,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "舰队处于漩涡之中，每次移动有一定概率失败。",
		buff_maxfloor = 1,
		icon = "3020",
		buff_type = 3,
		delete_move = 1,
		id = 302,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			30
		},
		delete_traptype = {}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.world_SLGbuff_data

	var_1_7[303] = {
		name = "异常：燃烧",
		trap_type = 3,
		lua_id = 0,
		buff_fx = "SLG_huohit01",
		delete_round = 2,
		desc = "舰队处于燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		buff_maxfloor = 3,
		icon = "3030",
		buff_type = 3,
		delete_move = 0,
		id = 303,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			1000
		},
		delete_traptype = {
			6
		}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.world_SLGbuff_data

	var_1_8[304] = {
		name = "异常：导航干扰",
		trap_type = 4,
		lua_id = 0,
		buff_fx = "SLG_hunluan",
		delete_round = 0,
		desc = "导航系统遭受EMP攻击，舰队进入移动异常状态，无法准确前往目标区域。",
		buff_maxfloor = 1,
		icon = "3040",
		buff_type = 3,
		delete_move = 1,
		id = 304,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.world_SLGbuff_data

	var_1_9[305] = {
		name = "异常：移动受限",
		trap_type = 5,
		lua_id = 0,
		buff_fx = "SLG_dunzu",
		delete_round = 0,
		desc = "导航系统遭受EMP干扰，舰队进入移动异常状态，每次行动移动范围将会降低。",
		buff_maxfloor = 1,
		icon = "3050",
		buff_type = 3,
		delete_move = 2,
		id = 305,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			50,
			1,
			50
		},
		delete_traptype = {}
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.world_SLGbuff_data

	var_1_10[306] = {
		name = "异常：结冰",
		trap_type = 6,
		lua_id = 0,
		buff_fx = "SLG_hanqi",
		delete_round = 5,
		desc = "舰队大量设备处于结冰状态，战斗能力下降。结冰状态将会持续若干行动轮。",
		buff_maxfloor = 3,
		icon = "3060",
		buff_type = 3,
		delete_move = 2,
		id = 306,
		trap_lua = "",
		buff_attr = {
			"cannon",
			"torpedo"
		},
		percent = {
			1,
			1
		},
		buff_effect = {
			-2000,
			-2000
		},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {
			3
		}
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.world_SLGbuff_data

	var_1_11[307] = {
		name = "异常：移动受限",
		trap_type = 5,
		lua_id = 0,
		buff_fx = "SLG_dunzu",
		delete_round = 999,
		desc = "导航系统遭受EMP干扰，舰队进入移动异常状态，每次行动移动范围将会降低。",
		buff_maxfloor = 1,
		icon = "3050",
		buff_type = 3,
		delete_move = 0,
		id = 307,
		trap_lua = "警告：遭遇到塞壬陷阱干扰。",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			50,
			2,
			100
		},
		delete_traptype = {}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.world_SLGbuff_data

	var_1_12[308] = {
		name = "异常：燃烧",
		trap_type = 3,
		lua_id = 0,
		buff_fx = "SLG_huohit01",
		delete_round = 1,
		desc = "舰队处于燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		buff_maxfloor = 3,
		icon = "3030",
		buff_type = 3,
		delete_move = 0,
		id = 308,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			500
		},
		delete_traptype = {
			6
		}
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.world_SLGbuff_data

	var_1_13[309] = {
		name = "异常：导航干扰",
		trap_type = 4,
		lua_id = 0,
		buff_fx = "SLG_hunluan",
		delete_round = 0,
		desc = "导航系统遭受EMP攻击，舰队进入移动异常状态，无法准确前往目标区域。",
		buff_maxfloor = 1,
		icon = "3040",
		buff_type = 3,
		delete_move = 2,
		id = 309,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.world_SLGbuff_data

	var_1_14[310] = {
		name = "异常：移动受限",
		trap_type = 5,
		lua_id = 0,
		buff_fx = "SLG_dunzu",
		delete_round = 0,
		desc = "导航系统遭受EMP干扰，舰队进入移动异常状态，每次行动移动范围将会降低。",
		buff_maxfloor = 1,
		icon = "3050",
		buff_type = 3,
		delete_move = 5,
		id = 310,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			50,
			1,
			80
		},
		delete_traptype = {}
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.world_SLGbuff_data

	var_1_15[311] = {
		name = "异常：导航干扰",
		trap_type = 4,
		lua_id = 0,
		buff_fx = "SLG_hunluan",
		delete_round = 0,
		desc = "导航系统遭受EMP攻击，舰队进入移动异常状态，无法准确前往目标区域。",
		buff_maxfloor = 1,
		icon = "3040",
		buff_type = 3,
		delete_move = 2,
		id = 311,
		trap_lua = "警告：指挥官，遭受了异常电磁干扰，G.M系统显示暂时失效。",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.world_SLGbuff_data

	var_1_16[312] = {
		name = "异常：移动受限",
		trap_type = 5,
		lua_id = 0,
		buff_fx = "SLG_dunzu",
		delete_round = 0,
		desc = "导航系统遭受EMP干扰，舰队进入移动异常状态，每次行动移动范围将会降低。",
		buff_maxfloor = 1,
		icon = "3050",
		buff_type = 3,
		delete_move = 2,
		id = 312,
		trap_lua = "警告：遭遇到塞壬陷阱干扰。",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			50,
			1,
			50
		},
		delete_traptype = {}
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.world_SLGbuff_data

	var_1_17[313] = {
		name = "异常：电磁干扰",
		trap_type = 1,
		lua_id = 0,
		buff_fx = "xuehuaping01",
		delete_round = 5,
		desc = "因为遭受异常电磁干扰，G.M系统显示暂时失效。异常状态将会持续若干行动轮。",
		buff_maxfloor = 1,
		icon = "3010",
		buff_type = 3,
		delete_move = 0,
		id = 313,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.world_SLGbuff_data

	var_1_18[314] = {
		name = "异常：强力电磁干扰",
		trap_type = 1,
		lua_id = 0,
		buff_fx = "xuehuaping01",
		delete_round = 10,
		desc = "遭受严重异常电磁干扰，G.M系统显示暂时失效。异常状态将会持续若干行动轮。",
		buff_maxfloor = 1,
		icon = "3010",
		buff_type = 3,
		delete_move = 0,
		id = 314,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.world_SLGbuff_data

	var_1_19[315] = {
		name = "异常：燃烧",
		trap_type = 3,
		lua_id = 0,
		buff_fx = "SLG_huohit01",
		delete_round = 2,
		desc = "舰队处于燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		buff_maxfloor = 3,
		icon = "3030",
		buff_type = 3,
		delete_move = 0,
		id = 315,
		trap_lua = "警告：指挥官，舰队周边海域正在燃烧，请尽快脱离危险区域。",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			500
		},
		delete_traptype = {
			1006
		}
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.world_SLGbuff_data

	var_1_20[316] = {
		name = "异常：结冰",
		trap_type = 6,
		lua_id = 0,
		buff_fx = "SLG_hanqi",
		delete_round = 5,
		desc = "舰队大量设备处于结冰状态，战斗能力下降。结冰状态将会持续若干行动轮。",
		buff_maxfloor = 3,
		icon = "3060",
		buff_type = 3,
		delete_move = 0,
		id = 316,
		trap_lua = "",
		buff_attr = {
			"cannon",
			"torpedo"
		},
		percent = {
			1,
			1
		},
		buff_effect = {
			-2000,
			-2000
		},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {
			1003
		}
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.world_SLGbuff_data

	var_1_21[317] = {
		name = "异常：漩涡扰动",
		trap_type = 2,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "舰队处于漩涡之中，每次移动有一定概率失败。",
		buff_maxfloor = 1,
		icon = "3020",
		buff_type = 3,
		delete_move = 1,
		id = 317,
		trap_lua = "警告：指挥官，舰队进入了漩涡之中，行动能力受到限制。",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			30
		},
		delete_traptype = {}
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.world_SLGbuff_data

	var_1_22[318] = {
		name = "异常：强力导航干扰",
		trap_type = 4,
		lua_id = 0,
		buff_fx = "SLG_hunluan",
		delete_round = 0,
		desc = "导航系统遭受EMP攻击，舰队进入移动异常状态，无法准确前往目标区域。",
		buff_maxfloor = 1,
		icon = "3040",
		buff_type = 3,
		delete_move = 3,
		id = 318,
		trap_lua = "警告：指挥官，舰队正在遭受异常海况影响。",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.world_SLGbuff_data

	var_1_23[320] = {
		name = "异常：烧灼",
		trap_type = 3,
		lua_id = 0,
		buff_fx = "SLG_huohit02",
		delete_round = 2,
		desc = "舰队处于烧灼状态，每次行动将会受到一定伤害。烧灼状态将会持续若干行动轮。",
		buff_maxfloor = 3,
		icon = "3030",
		buff_type = 3,
		delete_move = 0,
		id = 320,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			800
		},
		delete_traptype = {
			6
		}
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.world_SLGbuff_data

	var_1_24[321] = {
		name = "异常：电磁干扰",
		trap_type = 1,
		lua_id = 0,
		buff_fx = "xuehuaping01",
		delete_round = 5,
		desc = "因为遭受异常电磁干扰，G.M系统显示暂时失效。异常状态将会持续若干行动轮。",
		buff_maxfloor = 1,
		icon = "3010",
		buff_type = 3,
		delete_move = 0,
		id = 321,
		trap_lua = "警告：指挥官，舰队正在遭受异常海况影响。",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.world_SLGbuff_data

	var_1_25[322] = {
		name = "异常：漩涡扰动",
		trap_type = 2,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "舰队处于漩涡之中，每次移动有一定概率失败。",
		buff_maxfloor = 1,
		icon = "3020",
		buff_type = 3,
		delete_move = 1,
		id = 322,
		trap_lua = "警告：指挥官，舰队正在遭受异常海况影响。",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			30
		},
		delete_traptype = {}
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.world_SLGbuff_data

	var_1_26[323] = {
		name = "异常：燃烧",
		trap_type = 3,
		lua_id = 0,
		buff_fx = "SLG_huohit01",
		delete_round = 2,
		desc = "舰队处于燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		buff_maxfloor = 2,
		icon = "3030",
		buff_type = 3,
		delete_move = 0,
		id = 323,
		trap_lua = "警告：指挥官，舰队正在遭受异常海况影响。",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			500
		},
		delete_traptype = {
			1016
		}
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.world_SLGbuff_data

	var_1_27[324] = {
		name = "异常：导航干扰",
		trap_type = 4,
		lua_id = 0,
		buff_fx = "SLG_hunluan",
		delete_round = 0,
		desc = "导航系统遭受EMP攻击，舰队进入移动异常状态，无法准确前往目标区域。",
		buff_maxfloor = 1,
		icon = "3040",
		buff_type = 3,
		delete_move = 1,
		id = 324,
		trap_lua = "警告：指挥官，舰队正在遭受异常海况影响。",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_27

	local var_1_28 = var_1_27.base.world_SLGbuff_data

	var_1_28[325] = {
		name = "异常：移动受限",
		trap_type = 5,
		lua_id = 0,
		buff_fx = "SLG_dunzu",
		delete_round = 0,
		desc = "导航系统遭受EMP干扰，舰队进入移动异常状态，每次行动移动范围将会降低。",
		buff_maxfloor = 1,
		icon = "3050",
		buff_type = 3,
		delete_move = 3,
		id = 325,
		trap_lua = "警告：指挥官，舰队正在遭受异常海况影响。",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			50,
			1,
			50
		},
		delete_traptype = {}
	}
	pg = var_1_28

	local var_1_29 = var_1_28.base.world_SLGbuff_data

	var_1_29[326] = {
		name = "异常：结冰",
		trap_type = 6,
		lua_id = 0,
		buff_fx = "SLG_hanqi",
		delete_round = 5,
		desc = "舰队大量设备处于结冰状态，战斗能力下降。结冰状态将会持续若干行动轮。",
		buff_maxfloor = 2,
		icon = "3060",
		buff_type = 3,
		delete_move = 0,
		id = 326,
		trap_lua = "警告：指挥官，舰队正在遭受异常海况影响。",
		buff_attr = {
			"cannon",
			"torpedo"
		},
		percent = {
			1,
			1
		},
		buff_effect = {
			-2000,
			-2000
		},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {
			1013
		}
	}
	pg = var_1_29

	local var_1_30 = var_1_29.base.world_SLGbuff_data

	var_1_30[401] = {
		name = "适应性调整-攻击",
		trap_type = 0,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "攻击适应性影响塞壬单位的攻击力倍率。",
		buff_maxfloor = 999,
		icon = "4010",
		buff_type = 4,
		delete_move = 0,
		id = 401,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			1,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_30

	local var_1_31 = var_1_30.base.world_SLGbuff_data

	var_1_31[402] = {
		name = "适应性调整-耐久",
		trap_type = 0,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "耐久适应性影响塞壬单位的生命值倍率。",
		buff_maxfloor = 999,
		icon = "4020",
		buff_type = 4,
		delete_move = 0,
		id = 402,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			1,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_31

	local var_1_32 = var_1_31.base.world_SLGbuff_data

	var_1_32[403] = {
		name = "适应性调整-恢复",
		trap_type = 0,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "恢复适应性影响塞壬单位对战斗中我方治疗恢复的干扰衰减。",
		buff_maxfloor = 999,
		icon = "4030",
		buff_type = 4,
		delete_move = 0,
		id = 403,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			1
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_32

	local var_1_33 = var_1_32.base.world_SLGbuff_data

	var_1_33[600] = {
		name = "异常：移动受限",
		trap_type = 5,
		lua_id = 0,
		buff_fx = "SLG_dunzu",
		delete_round = 2,
		desc = "导航系统遭受EMP干扰，舰队进入移动异常状态，每次行动移动范围将会降低。",
		buff_maxfloor = 1,
		icon = "3050",
		buff_type = 5,
		delete_move = 0,
		id = 600,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			50,
			1,
			50
		},
		delete_traptype = {}
	}
	pg = var_1_33

	local var_1_34 = var_1_33.base.world_SLGbuff_data

	var_1_34[601] = {
		name = "异常：导航干扰",
		trap_type = 4,
		lua_id = 0,
		buff_fx = "SLG_hunluan",
		delete_round = 0,
		desc = "导航系统遭受EMP攻击，舰队进入移动异常状态，无法准确前往目标区域。",
		buff_maxfloor = 1,
		icon = "3040",
		buff_type = 3,
		delete_move = 1,
		id = 601,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_34

	local var_1_35 = var_1_34.base.world_SLGbuff_data

	var_1_35[602] = {
		name = "感染地形",
		trap_type = 8,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "感染buff测试",
		buff_maxfloor = 1,
		icon = "3070",
		buff_type = 5,
		delete_move = 2,
		id = 602,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			0,
			0,
			6,
			1
		},
		delete_traptype = {}
	}
	pg = var_1_35

	local var_1_36 = var_1_35.base.world_SLGbuff_data

	var_1_36[610] = {
		name = "观测·VIII",
		trap_type = 0,
		lua_id = 0,
		buff_fx = "",
		delete_round = 3,
		desc = "舰队受到未知干扰，周期性的在当前舰队位置生成重力陷阱，吸附周围舰队。",
		buff_maxfloor = 1,
		icon = "3100",
		buff_type = 5,
		delete_move = 0,
		id = 610,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_36

	local var_1_37 = var_1_36.base.world_SLGbuff_data

	var_1_37[620] = {
		name = "观测·XIV",
		trap_type = 7,
		lua_id = 0,
		buff_fx = "",
		delete_round = 3,
		desc = "舰队受到未知干扰，周期性的在当前舰队位置生成电磁场，电磁场中的舰队数量超过1时，传导电磁干扰。",
		buff_maxfloor = 1,
		icon = "3090",
		buff_type = 5,
		delete_move = 0,
		id = 620,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			201
		},
		delete_traptype = {}
	}
	pg = var_1_37

	local var_1_38 = var_1_37.base.world_SLGbuff_data

	var_1_38[630] = {
		name = "观测·IX",
		trap_type = 9,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "舰队受到未知干扰，周期性的在当前舰队移动路径上生成持续若干回合的异常地形。",
		buff_maxfloor = 1,
		icon = "3080",
		buff_type = 5,
		delete_move = 3,
		id = 630,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {
			202
		},
		delete_traptype = {}
	}
	pg = var_1_38

	local var_1_39 = var_1_38.base.world_SLGbuff_data

	var_1_39[700] = {
		name = "炮击支援",
		trap_type = 0,
		lua_id = 78000,
		buff_fx = "",
		delete_round = 0,
		desc = "获得了来自炮击支援群的火力支援。",
		buff_maxfloor = 1,
		icon = "700",
		buff_type = 0,
		delete_move = 0,
		id = 700,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_39

	local var_1_40 = var_1_39.base.world_SLGbuff_data

	var_1_40[710] = {
		name = "航空支援",
		trap_type = 0,
		lua_id = 78010,
		buff_fx = "",
		delete_round = 0,
		desc = "获得了来自航空支援群的火力支援。",
		buff_maxfloor = 1,
		icon = "710",
		buff_type = 0,
		delete_move = 0,
		id = 710,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_40

	local var_1_41 = var_1_40.base.world_SLGbuff_data

	var_1_41[1010] = {
		name = "炮击强化",
		trap_type = 0,
		lua_id = 70100,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的炮击增加50%",
		buff_maxfloor = 1,
		icon = "1010",
		buff_type = 2,
		delete_move = 0,
		id = 1010,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_41

	local var_1_42 = var_1_41.base.world_SLGbuff_data

	var_1_42[1020] = {
		name = "雷击强化",
		trap_type = 0,
		lua_id = 70200,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的雷击增加50%",
		buff_maxfloor = 1,
		icon = "1020",
		buff_type = 2,
		delete_move = 0,
		id = 1020,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_42

	local var_1_43 = var_1_42.base.world_SLGbuff_data

	var_1_43[1030] = {
		name = "防空强化",
		trap_type = 0,
		lua_id = 70300,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的防空增加50%",
		buff_maxfloor = 1,
		icon = "1030",
		buff_type = 2,
		delete_move = 0,
		id = 1030,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_43

	local var_1_44 = var_1_43.base.world_SLGbuff_data

	var_1_44[1040] = {
		name = "航空强化",
		trap_type = 0,
		lua_id = 70400,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的航空增加50%",
		buff_maxfloor = 1,
		icon = "1040",
		buff_type = 2,
		delete_move = 0,
		id = 1040,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_44

	local var_1_45 = var_1_44.base.world_SLGbuff_data

	var_1_45[1050] = {
		name = "装填强化",
		trap_type = 0,
		lua_id = 70500,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的装填增加50%",
		buff_maxfloor = 1,
		icon = "1050",
		buff_type = 2,
		delete_move = 0,
		id = 1050,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_45

	local var_1_46 = var_1_45.base.world_SLGbuff_data

	var_1_46[1060] = {
		name = "航速强化",
		trap_type = 0,
		lua_id = 70900,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的航速增加30%",
		buff_maxfloor = 1,
		icon = "1060",
		buff_type = 2,
		delete_move = 0,
		id = 1060,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_46

	local var_1_47 = var_1_46.base.world_SLGbuff_data

	var_1_47[1110] = {
		name = "炮击抗性",
		trap_type = 0,
		lua_id = 71000,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰受到的炮击伤害降低50%",
		buff_maxfloor = 1,
		icon = "1110",
		buff_type = 2,
		delete_move = 0,
		id = 1110,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_47

	local var_1_48 = var_1_47.base.world_SLGbuff_data

	var_1_48[1120] = {
		name = "雷击抗性",
		trap_type = 0,
		lua_id = 71100,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰受到的雷击伤害降低50%",
		buff_maxfloor = 1,
		icon = "1120",
		buff_type = 2,
		delete_move = 0,
		id = 1120,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_48

	local var_1_49 = var_1_48.base.world_SLGbuff_data

	var_1_49[1130] = {
		name = "航空抗性",
		trap_type = 0,
		lua_id = 71200,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰受到的航空伤害降低50%",
		buff_maxfloor = 1,
		icon = "1130",
		buff_type = 2,
		delete_move = 0,
		id = 1130,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_49

	local var_1_50 = var_1_49.base.world_SLGbuff_data

	var_1_50[1210] = {
		name = "炮击易伤LV1",
		trap_type = 0,
		lua_id = 71050,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰受到的炮击伤害增加30%",
		buff_maxfloor = 1,
		icon = "1210",
		buff_type = 2,
		delete_move = 0,
		id = 1210,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_50

	local var_1_51 = var_1_50.base.world_SLGbuff_data

	var_1_51[1220] = {
		name = "炮击易伤LV2",
		trap_type = 0,
		lua_id = 71150,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰受到的炮击伤害增加50%",
		buff_maxfloor = 1,
		icon = "1210",
		buff_type = 2,
		delete_move = 0,
		id = 1220,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_51

	local var_1_52 = var_1_51.base.world_SLGbuff_data

	var_1_52[1230] = {
		name = "炮击易伤LV3",
		trap_type = 0,
		lua_id = 71250,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰受到的炮击伤害增加100%",
		buff_maxfloor = 1,
		icon = "1210",
		buff_type = 2,
		delete_move = 0,
		id = 1230,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_52

	local var_1_53 = var_1_52.base.world_SLGbuff_data

	var_1_53[1240] = {
		name = "雷击易伤LV1",
		trap_type = 0,
		lua_id = 71350,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰受到的雷击伤害增加30%",
		buff_maxfloor = 1,
		icon = "1220",
		buff_type = 2,
		delete_move = 0,
		id = 1240,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_53

	local var_1_54 = var_1_53.base.world_SLGbuff_data

	var_1_54[1250] = {
		name = "雷击易伤LV2",
		trap_type = 0,
		lua_id = 71450,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰受到的雷击伤害增加50%",
		buff_maxfloor = 1,
		icon = "1220",
		buff_type = 2,
		delete_move = 0,
		id = 1250,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_54

	local var_1_55 = var_1_54.base.world_SLGbuff_data

	var_1_55[1260] = {
		name = "雷击易伤LV3",
		trap_type = 0,
		lua_id = 71550,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰受到的雷击伤害增加100%",
		buff_maxfloor = 1,
		icon = "1220",
		buff_type = 2,
		delete_move = 0,
		id = 1260,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_55

	local var_1_56 = var_1_55.base.world_SLGbuff_data

	var_1_56[1270] = {
		name = "航空易伤LV1",
		trap_type = 0,
		lua_id = 71650,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰受到的航空伤害增加30%",
		buff_maxfloor = 1,
		icon = "1230",
		buff_type = 2,
		delete_move = 0,
		id = 1270,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_56

	local var_1_57 = var_1_56.base.world_SLGbuff_data

	var_1_57[1280] = {
		name = "航空易伤LV2",
		trap_type = 0,
		lua_id = 71750,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰受到的航空伤害增加50%",
		buff_maxfloor = 1,
		icon = "1230",
		buff_type = 2,
		delete_move = 0,
		id = 1280,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_57

	local var_1_58 = var_1_57.base.world_SLGbuff_data

	var_1_58[1290] = {
		name = "航空易伤LV3",
		trap_type = 0,
		lua_id = 71850,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰受到的航空伤害增加100%",
		buff_maxfloor = 1,
		icon = "1230",
		buff_type = 2,
		delete_move = 0,
		id = 1290,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_58

	local var_1_59 = var_1_58.base.world_SLGbuff_data

	var_1_59[1300] = {
		name = "猎手",
		trap_type = 0,
		lua_id = 72000,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰对我方所有角色造成的伤害增加30%",
		buff_maxfloor = 1,
		icon = "1300",
		buff_type = 2,
		delete_move = 0,
		id = 1300,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_59

	local var_1_60 = var_1_59.base.world_SLGbuff_data

	var_1_60[1310] = {
		name = "先锋猎手",
		trap_type = 0,
		lua_id = 72100,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰对我方前排先锋造成的伤害增加50%",
		buff_maxfloor = 1,
		icon = "1310",
		buff_type = 2,
		delete_move = 0,
		id = 1310,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_60

	local var_1_61 = var_1_60.base.world_SLGbuff_data

	var_1_61[1320] = {
		name = "主力猎手",
		trap_type = 0,
		lua_id = 72200,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰对我方后排主力造成的伤害增加50%",
		buff_maxfloor = 1,
		icon = "1320",
		buff_type = 2,
		delete_move = 0,
		id = 1320,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_61

	local var_1_62 = var_1_61.base.world_SLGbuff_data

	var_1_62[1410] = {
		name = "毁灭",
		trap_type = 0,
		lua_id = 73000,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰登场后，每过10秒对我方全体角色造成最大耐久值5%的伤害",
		buff_maxfloor = 1,
		icon = "1410",
		buff_type = 2,
		delete_move = 0,
		id = 1410,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_62

	local var_1_63 = var_1_62.base.world_SLGbuff_data

	var_1_63[1420] = {
		name = "盛大登场",
		trap_type = 0,
		lua_id = 73100,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰登场后，每过10秒提高自身全属性提升10%，最高叠加5层",
		buff_maxfloor = 1,
		icon = "1420",
		buff_type = 2,
		delete_move = 0,
		id = 1420,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_63

	local var_1_64 = var_1_63.base.world_SLGbuff_data

	var_1_64[1430] = {
		name = "护盾：大量耐久",
		trap_type = 0,
		lua_id = 73200,
		buff_fx = "",
		delete_round = 0,
		desc = "每隔20秒，敌方旗舰会生成一个可以吸收自身最大耐久值20%伤害的护盾，持续5秒",
		buff_maxfloor = 1,
		icon = "1430",
		buff_type = 2,
		delete_move = 0,
		id = 1430,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_64

	local var_1_65 = var_1_64.base.world_SLGbuff_data

	var_1_65[1440] = {
		name = "护盾：重点防御",
		trap_type = 0,
		lua_id = 73300,
		buff_fx = "",
		delete_round = 0,
		desc = "每隔20秒，敌方旗舰会生成一个降低被暴击概率100%的护盾，持续10秒",
		buff_maxfloor = 1,
		icon = "1440",
		buff_type = 2,
		delete_move = 0,
		id = 1440,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_65

	local var_1_66 = var_1_65.base.world_SLGbuff_data

	var_1_66[1450] = {
		name = "护盾：伤害偏转",
		trap_type = 0,
		lua_id = 73400,
		buff_fx = "",
		delete_round = 0,
		desc = "每隔20秒，敌方旗舰会生成一个将所受攻击伤害变为1的护盾，护盾最多偏转15次攻击伤害，持续8秒",
		buff_maxfloor = 1,
		icon = "1450",
		buff_type = 2,
		delete_move = 0,
		id = 1450,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_66

	local var_1_67 = var_1_66.base.world_SLGbuff_data

	var_1_67[1460] = {
		name = "火力超载模块",
		trap_type = 0,
		lua_id = 73500,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰耐久值下降至30%以下时，炮击、雷击上升100%，每场战斗仅会触发一次",
		buff_maxfloor = 1,
		icon = "1460",
		buff_type = 2,
		delete_move = 0,
		id = 1460,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_67

	local var_1_68 = var_1_67.base.world_SLGbuff_data

	var_1_68[1470] = {
		name = "装甲超载模块",
		trap_type = 0,
		lua_id = 73600,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰耐久值下降至30%以下时，有50%概率将受到的炮击伤害降为1，每场战斗仅会触发一次",
		buff_maxfloor = 1,
		icon = "1470",
		buff_type = 2,
		delete_move = 0,
		id = 1470,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_68

	local var_1_69 = var_1_68.base.world_SLGbuff_data

	var_1_69[1480] = {
		name = "维修超载模块",
		trap_type = 0,
		lua_id = 73700,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰耐久值下降至30%以下时，每隔3秒回复自身最大耐久值的5%，持续15秒，每场战斗仅会触发一次",
		buff_maxfloor = 1,
		icon = "1480",
		buff_type = 2,
		delete_move = 0,
		id = 1480,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_69

	local var_1_70 = var_1_69.base.world_SLGbuff_data

	var_1_70[1490] = {
		name = "护盾超载模块",
		trap_type = 0,
		lua_id = 73800,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰耐久值下降至30%以下时，生成一面能够阻挡子弹的护盾，护盾永久存在",
		buff_maxfloor = 1,
		icon = "1490",
		buff_type = 2,
		delete_move = 0,
		id = 1490,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_70

	local var_1_71 = var_1_70.base.world_SLGbuff_data

	var_1_71[1500] = {
		name = "恢复反转",
		trap_type = 0,
		lua_id = 73900,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰在场时，我方全部角色受到的恢复效果会被反转为伤害效果",
		buff_maxfloor = 1,
		icon = "1500",
		buff_type = 2,
		delete_move = 0,
		id = 1500,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_71

	local var_1_72 = var_1_71.base.world_SLGbuff_data

	var_1_72[1510] = {
		name = "恢复转移",
		trap_type = 0,
		lua_id = 74000,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰在场时，针对我方角色的恢复效果将会全部转移至敌方旗舰上",
		buff_maxfloor = 1,
		icon = "1510",
		buff_type = 2,
		delete_move = 0,
		id = 1510,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_72

	local var_1_73 = var_1_72.base.world_SLGbuff_data

	var_1_73[1520] = {
		name = "暴击转移",
		trap_type = 0,
		lua_id = 74100,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰在场时，每次我方角色暴击都将导致整个舰队暴击率降低A%，提高敌方旗舰暴击率B%，最高叠加C层，持续D秒",
		buff_maxfloor = 1,
		icon = "1520",
		buff_type = 2,
		delete_move = 0,
		id = 1520,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_73

	local var_1_74 = var_1_73.base.world_SLGbuff_data

	var_1_74[1530] = {
		name = "穿透",
		trap_type = 0,
		lua_id = 74200,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰对我方角色造成5次伤害后，下一次造成的伤害提升至300%",
		buff_maxfloor = 1,
		icon = "1530",
		buff_type = 2,
		delete_move = 0,
		id = 1530,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_74

	local var_1_75 = var_1_74.base.world_SLGbuff_data

	var_1_75[1540] = {
		name = "干涉",
		trap_type = 0,
		lua_id = 74300,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰对我方角色造成5次伤害后，下一次造成的伤害将会降低被命中角色航速70%，持续8秒",
		buff_maxfloor = 1,
		icon = "1540",
		buff_type = 2,
		delete_move = 0,
		id = 1540,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_75

	local var_1_76 = var_1_75.base.world_SLGbuff_data

	var_1_76[1550] = {
		name = "附加损伤",
		trap_type = 0,
		lua_id = 74400,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰每次造成伤害时，我方角色受到的伤害额外增加10点",
		buff_maxfloor = 1,
		icon = "1550",
		buff_type = 2,
		delete_move = 0,
		id = 1550,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_76

	local var_1_77 = var_1_76.base.world_SLGbuff_data

	var_1_77[1560] = {
		name = "精准",
		trap_type = 0,
		lua_id = 70600,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的命中率大幅度提升",
		buff_maxfloor = 1,
		icon = "1560",
		buff_type = 2,
		delete_move = 0,
		id = 1560,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_77

	local var_1_78 = var_1_77.base.world_SLGbuff_data

	var_1_78[2000] = {
		name = "炮击强化",
		trap_type = 0,
		lua_id = 70100,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的炮击增加30%",
		buff_maxfloor = 1,
		icon = "2000",
		buff_type = 2,
		delete_move = 0,
		id = 2000,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_78

	local var_1_79 = var_1_78.base.world_SLGbuff_data

	var_1_79[2010] = {
		name = "炮击强化",
		trap_type = 0,
		lua_id = 70100,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的炮击增加50%",
		buff_maxfloor = 1,
		icon = "2010",
		buff_type = 2,
		delete_move = 0,
		id = 2010,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_79

	local var_1_80 = var_1_79.base.world_SLGbuff_data

	var_1_80[2020] = {
		name = "炮击强化",
		trap_type = 0,
		lua_id = 70100,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的炮击增加100%",
		buff_maxfloor = 1,
		icon = "2020",
		buff_type = 2,
		delete_move = 0,
		id = 2020,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_80

	local var_1_81 = var_1_80.base.world_SLGbuff_data

	var_1_81[2100] = {
		name = "雷击强化",
		trap_type = 0,
		lua_id = 70200,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的雷击增加30%",
		buff_maxfloor = 1,
		icon = "2100",
		buff_type = 2,
		delete_move = 0,
		id = 2100,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_81

	local var_1_82 = var_1_81.base.world_SLGbuff_data

	var_1_82[2110] = {
		name = "雷击强化",
		trap_type = 0,
		lua_id = 70200,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的雷击增加50%",
		buff_maxfloor = 1,
		icon = "2110",
		buff_type = 2,
		delete_move = 0,
		id = 2110,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_82

	local var_1_83 = var_1_82.base.world_SLGbuff_data

	var_1_83[2120] = {
		name = "雷击强化",
		trap_type = 0,
		lua_id = 70200,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的雷击增加100%",
		buff_maxfloor = 1,
		icon = "2120",
		buff_type = 2,
		delete_move = 0,
		id = 2120,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_83

	local var_1_84 = var_1_83.base.world_SLGbuff_data

	var_1_84[2200] = {
		name = "防空强化",
		trap_type = 0,
		lua_id = 70300,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的防空增加30%",
		buff_maxfloor = 1,
		icon = "2200",
		buff_type = 2,
		delete_move = 0,
		id = 2200,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_84

	local var_1_85 = var_1_84.base.world_SLGbuff_data

	var_1_85[2210] = {
		name = "防空强化",
		trap_type = 0,
		lua_id = 70300,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的防空增加50%",
		buff_maxfloor = 1,
		icon = "2210",
		buff_type = 2,
		delete_move = 0,
		id = 2210,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_85

	local var_1_86 = var_1_85.base.world_SLGbuff_data

	var_1_86[2220] = {
		name = "防空强化",
		trap_type = 0,
		lua_id = 70300,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的防空增加100%",
		buff_maxfloor = 1,
		icon = "2220",
		buff_type = 2,
		delete_move = 0,
		id = 2220,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_86

	local var_1_87 = var_1_86.base.world_SLGbuff_data

	var_1_87[2300] = {
		name = "航空强化",
		trap_type = 0,
		lua_id = 70400,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的航空增加30%",
		buff_maxfloor = 1,
		icon = "2300",
		buff_type = 2,
		delete_move = 0,
		id = 2300,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_87

	local var_1_88 = var_1_87.base.world_SLGbuff_data

	var_1_88[2310] = {
		name = "航空强化",
		trap_type = 0,
		lua_id = 70400,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的航空增加50%",
		buff_maxfloor = 1,
		icon = "2310",
		buff_type = 2,
		delete_move = 0,
		id = 2310,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_88

	local var_1_89 = var_1_88.base.world_SLGbuff_data

	var_1_89[2320] = {
		name = "航空强化",
		trap_type = 0,
		lua_id = 70400,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的航空增加100%",
		buff_maxfloor = 1,
		icon = "2320",
		buff_type = 2,
		delete_move = 0,
		id = 2320,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_89

	local var_1_90 = var_1_89.base.world_SLGbuff_data

	var_1_90[2400] = {
		name = "装填强化",
		trap_type = 0,
		lua_id = 70500,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的装填增加30%",
		buff_maxfloor = 1,
		icon = "2400",
		buff_type = 2,
		delete_move = 0,
		id = 2400,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_90

	local var_1_91 = var_1_90.base.world_SLGbuff_data

	var_1_91[2410] = {
		name = "装填强化",
		trap_type = 0,
		lua_id = 70500,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的装填增加50%",
		buff_maxfloor = 1,
		icon = "2410",
		buff_type = 2,
		delete_move = 0,
		id = 2410,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_91

	local var_1_92 = var_1_91.base.world_SLGbuff_data

	var_1_92[2420] = {
		name = "装填强化",
		trap_type = 0,
		lua_id = 70500,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的装填增加100%",
		buff_maxfloor = 1,
		icon = "2420",
		buff_type = 2,
		delete_move = 0,
		id = 2420,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_92

	local var_1_93 = var_1_92.base.world_SLGbuff_data

	var_1_93[2500] = {
		name = "航速强化",
		trap_type = 0,
		lua_id = 70900,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的航速增加30%",
		buff_maxfloor = 1,
		icon = "2500",
		buff_type = 2,
		delete_move = 0,
		id = 2500,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_93

	local var_1_94 = var_1_93.base.world_SLGbuff_data

	var_1_94[2510] = {
		name = "航速强化",
		trap_type = 0,
		lua_id = 70900,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的航速增加50%",
		buff_maxfloor = 1,
		icon = "2510",
		buff_type = 2,
		delete_move = 0,
		id = 2510,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_94

	local var_1_95 = var_1_94.base.world_SLGbuff_data

	var_1_95[2520] = {
		name = "航速强化",
		trap_type = 0,
		lua_id = 70900,
		buff_fx = "",
		delete_round = 0,
		desc = "敌方旗舰的航速增加100%",
		buff_maxfloor = 1,
		icon = "2520",
		buff_type = 2,
		delete_move = 0,
		id = 2520,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_95

	local var_1_96 = var_1_95.base.world_SLGbuff_data

	var_1_96[4000] = {
		name = "分离式作战模块",
		trap_type = 0,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "仲裁者·天帕岚斯·XIV在战斗中会召唤一个特殊的机械水母型作战单位。\n特殊单位在场时，天帕岚斯造成伤害提高15%，受到伤害降低10%。\n特殊单位被击破后，天帕岚斯受到伤害提高10%。",
		buff_maxfloor = 1,
		icon = "5000",
		buff_type = 2,
		delete_move = 0,
		id = 4000,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_96

	local var_1_97 = var_1_96.base.world_SLGbuff_data

	var_1_97[4010] = {
		name = "质量防御场",
		trap_type = 0,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "仲裁者·司特莲库斯·VIII在战斗中会为自身添加一层特殊防御场。\n防御场生效期间，会为司特莲库斯提供25%炮击和航空减伤，司特莲库斯自身造成伤害下降15%。\n同时防御力场会为司特莲库斯提供最多可以抵挡160000伤害的力场盾，力场盾只会出现一次。",
		buff_maxfloor = 1,
		icon = "5010",
		buff_type = 2,
		delete_move = 0,
		id = 4010,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}
	pg = var_1_97
	var_1_97.base.world_SLGbuff_data[4020] = {
		name = "腐蚀雾化模块",
		trap_type = 0,
		lua_id = 0,
		buff_fx = "",
		delete_round = 0,
		desc = "仲裁者·赫米忒·IX在战斗中会释放笼罩海域的腐蚀性雾气。\n进入毒雾的舰船航速降低12%，命中下降200。",
		buff_maxfloor = 1,
		icon = "5020",
		buff_type = 2,
		delete_move = 0,
		id = 4020,
		trap_lua = "",
		buff_attr = {},
		percent = {},
		buff_effect = {},
		buff_map_attr = {
			0,
			0,
			0
		},
		trap_parameter = {},
		delete_traptype = {}
	}

	return
end)()

return
