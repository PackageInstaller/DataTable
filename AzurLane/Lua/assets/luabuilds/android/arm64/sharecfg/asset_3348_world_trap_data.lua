pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "world_trap_data") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "world_trap_data"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.world_trap_data = var_0_2
pg = var_0

local var_0_3 = var_0.world_trap_data

var_0_3.all = {
	1,
	2,
	3,
	4,
	5,
	6,
	100,
	101,
	102,
	103,
	110,
	200,
	201,
	202,
	1001,
	1002,
	1003,
	1004,
	1005,
	1006,
	1007,
	1008,
	1011,
	1012,
	1013,
	1014,
	1015,
	1016,
	1021,
	1022,
	1023,
	1024,
	1025,
	1026,
	2001,
	2002,
	2003,
	2010,
	2011
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.world_trap_data = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.world_trap_data

	var_1_0[1] = {
		buff_id = 301,
		name = "电磁异常",
		repeat_trap = 0,
		trap_fx = "shanguang01",
		trap_type = 0,
		desc = "区域内电磁异常，进入后G.M系统显示将会暂时失效。异常状态将会持续若干行动轮。",
		obstacle = 2,
		id = 1,
		trap_range = {}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.world_trap_data

	var_1_1[2] = {
		buff_id = 302,
		name = "旋涡海域",
		repeat_trap = 1,
		trap_fx = "SLG_xuanwo",
		trap_type = 0,
		desc = "区域中存在巨型漩涡，舰队通过时，每次移动有一定概率失败。",
		obstacle = 2,
		id = 2,
		trap_range = {}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.world_trap_data

	var_1_2[3] = {
		buff_id = 303,
		name = "燃烧海域",
		repeat_trap = 1,
		trap_fx = "shanguang02",
		trap_type = 0,
		desc = "区域内的海面正在燃烧，进入后舰队会进入燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		obstacle = 2,
		id = 3,
		trap_range = {}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.world_trap_data

	var_1_3[4] = {
		buff_id = 304,
		name = "EMP干扰TYPEI",
		repeat_trap = 0,
		trap_fx = "shanguang01",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，无法准确前往目标区域。",
		obstacle = 2,
		id = 4,
		trap_range = {}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.world_trap_data

	var_1_4[5] = {
		buff_id = 305,
		name = "EMP干扰TYPEII",
		repeat_trap = 0,
		trap_fx = "shanguang01",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，每次行动移动范围将会降低。",
		obstacle = 2,
		id = 5,
		trap_range = {}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.world_trap_data

	var_1_5[6] = {
		buff_id = 306,
		name = "低温海域",
		repeat_trap = 1,
		trap_fx = "shanguang02",
		trap_type = 0,
		desc = "区域中温度很低，舰队进入后将会进入结冰状态，舰队战斗能力下降。结冰状态将会持续若干行动轮。",
		obstacle = 2,
		id = 6,
		trap_range = {}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.world_trap_data

	var_1_6[100] = {
		buff_id = 307,
		name = "EMP干扰TYPEII",
		repeat_trap = 0,
		trap_fx = "",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，每次行动移动范围将会降低。",
		obstacle = 2,
		id = 100,
		trap_range = {}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.world_trap_data

	var_1_7[101] = {
		buff_id = 308,
		name = "燃烧海域",
		repeat_trap = 0,
		trap_fx = "SLG_xuanwo",
		trap_type = 0,
		desc = "区域内的海面正在燃烧，进入后舰队会进入燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		obstacle = 2,
		id = 101,
		trap_range = {}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.world_trap_data

	var_1_8[102] = {
		buff_id = 309,
		name = "EMP干扰TYPEI",
		repeat_trap = 0,
		trap_fx = "shanguang01",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，无法准确前往目标区域。",
		obstacle = 2,
		id = 102,
		trap_range = {}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.world_trap_data

	var_1_9[103] = {
		buff_id = 310,
		name = "EMP干扰TYPEII",
		repeat_trap = 0,
		trap_fx = "shanguang01",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，每次行动移动范围将会降低。",
		obstacle = 2,
		id = 103,
		trap_range = {}
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.world_trap_data

	var_1_10[110] = {
		buff_id = 308,
		name = "燃烧海域",
		repeat_trap = 0,
		trap_fx = "SLG_qipao",
		trap_type = 0,
		desc = "区域内的海面正在燃烧，进入后舰队会进入燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		obstacle = 2,
		id = 110,
		trap_range = {}
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.world_trap_data

	var_1_11[200] = {
		buff_id = 600,
		name = "EMP干扰TYPEII",
		repeat_trap = 2,
		trap_fx = "zhongcaizhe_zhonglichang_slg",
		trap_type = 1,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，每次行动移动范围将会降低。",
		obstacle = 2,
		id = 200,
		trap_range = {
			3,
			3,
			2
		}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.world_trap_data

	var_1_12[201] = {
		buff_id = 601,
		name = "EMP干扰TYPEI",
		repeat_trap = 2,
		trap_fx = "zhongcaizhe_shandianqiang",
		trap_type = 2,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，无法准确前往目标区域。",
		obstacle = 2,
		id = 201,
		trap_range = {
			2
		}
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.world_trap_data

	var_1_13[202] = {
		buff_id = 320,
		name = "异常燃烧海域",
		repeat_trap = 2,
		trap_fx = "SLG_huo02",
		trap_type = 0,
		desc = "区域内的海面正在燃烧，进入后舰队会进入燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		obstacle = 2,
		id = 202,
		trap_range = {
			1,
			1,
			1
		}
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.world_trap_data

	var_1_14[1001] = {
		buff_id = 311,
		name = "EMP干扰TYPEI",
		repeat_trap = 0,
		trap_fx = "shanguang01",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，无法准确前往目标区域。",
		obstacle = 2,
		id = 1001,
		trap_range = {}
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.world_trap_data

	var_1_15[1002] = {
		buff_id = 312,
		name = "EMP干扰TYPEII",
		repeat_trap = 0,
		trap_fx = "shanguang01",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，每次行动移动范围将会降低。",
		obstacle = 2,
		id = 1002,
		trap_range = {}
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.world_trap_data

	var_1_16[1003] = {
		buff_id = 313,
		name = "电磁异常",
		repeat_trap = 0,
		trap_fx = "shanguang01",
		trap_type = 0,
		desc = "区域内电磁异常，进入后G.M系统显示将会暂时失效。异常状态将会持续若干行动轮。",
		obstacle = 2,
		id = 1003,
		trap_range = {}
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.world_trap_data

	var_1_17[1004] = {
		buff_id = 314,
		name = "强力电磁异常",
		repeat_trap = 0,
		trap_fx = "shanguang01",
		trap_type = 0,
		desc = "区域内电磁极度异常，进入后G.M系统显示将会暂时失效。异常状态将会持续若干行动轮。",
		obstacle = 2,
		id = 1004,
		trap_range = {}
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.world_trap_data

	var_1_18[1005] = {
		buff_id = 315,
		name = "燃烧海域",
		repeat_trap = 1,
		trap_fx = "SLG_huo01",
		trap_type = 0,
		desc = "区域内的海面正在燃烧，进入后舰队会进入燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		obstacle = 2,
		id = 1005,
		trap_range = {}
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.world_trap_data

	var_1_19[1006] = {
		buff_id = 316,
		name = "低温海域",
		repeat_trap = 1,
		trap_fx = "SLG_bingwu",
		trap_type = 0,
		desc = "区域中温度很低，舰队进入后将会进入结冰状态，舰队战斗能力下降。结冰状态将会持续若干行动轮。",
		obstacle = 2,
		id = 1006,
		trap_range = {}
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.world_trap_data

	var_1_20[1007] = {
		buff_id = 317,
		name = "旋涡海域",
		repeat_trap = 1,
		trap_fx = "SLG_xuanwo",
		trap_type = 0,
		desc = "区域中存在巨型漩涡，舰队通过时，每次移动有一定概率失败。",
		obstacle = 2,
		id = 1007,
		trap_range = {}
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.world_trap_data

	var_1_21[1008] = {
		buff_id = 318,
		name = "EMP干扰TYPEI",
		repeat_trap = 0,
		trap_fx = "SLG_EMP01_1",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，无法准确前往目标区域。",
		obstacle = 1,
		id = 1008,
		trap_range = {}
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.world_trap_data

	var_1_22[1011] = {
		buff_id = 321,
		name = "电磁异常",
		repeat_trap = 0,
		trap_fx = "SLG_qipao",
		trap_type = 0,
		desc = "区域内电磁异常，进入后G.M系统显示将会暂时失效。异常状态将会持续若干行动轮。",
		obstacle = 2,
		id = 1011,
		trap_range = {}
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.world_trap_data

	var_1_23[1012] = {
		buff_id = 322,
		name = "旋涡海域",
		repeat_trap = 1,
		trap_fx = "SLG_xuanwo",
		trap_type = 0,
		desc = "区域中存在巨型漩涡，舰队通过时，每次移动有一定概率失败。",
		obstacle = 2,
		id = 1012,
		trap_range = {}
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.world_trap_data

	var_1_24[1013] = {
		buff_id = 323,
		name = "燃烧海域",
		repeat_trap = 1,
		trap_fx = "SLG_huo01",
		trap_type = 0,
		desc = "区域内的海面正在燃烧，进入后舰队会进入燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		obstacle = 2,
		id = 1013,
		trap_range = {}
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.world_trap_data

	var_1_25[1014] = {
		buff_id = 324,
		name = "EMP干扰TYPEI",
		repeat_trap = 0,
		trap_fx = "SLG_EMP01_1",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，无法准确前往目标区域。",
		obstacle = 1,
		id = 1014,
		trap_range = {}
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.world_trap_data

	var_1_26[1015] = {
		buff_id = 325,
		name = "EMP干扰TYPEII",
		repeat_trap = 0,
		trap_fx = "SLG_EMP02_1",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，每次行动移动范围将会降低。",
		obstacle = 1,
		id = 1015,
		trap_range = {}
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.world_trap_data

	var_1_27[1016] = {
		buff_id = 326,
		name = "低温海域",
		repeat_trap = 1,
		trap_fx = "SLG_bingwu",
		trap_type = 0,
		desc = "区域中温度很低，舰队进入后将会进入结冰状态，舰队战斗能力下降。结冰状态将会持续若干行动轮。",
		obstacle = 2,
		id = 1016,
		trap_range = {}
	}
	pg = var_1_27

	local var_1_28 = var_1_27.base.world_trap_data

	var_1_28[1021] = {
		buff_id = 321,
		name = "电磁异常",
		repeat_trap = 0,
		trap_fx = "SLG_qipao",
		trap_type = 0,
		desc = "区域内电磁异常，进入后G.M系统显示将会暂时失效。异常状态将会持续若干行动轮。",
		obstacle = 2,
		id = 1021,
		trap_range = {}
	}
	pg = var_1_28

	local var_1_29 = var_1_28.base.world_trap_data

	var_1_29[1022] = {
		buff_id = 322,
		name = "旋涡海域",
		repeat_trap = 1,
		trap_fx = "SLG_xuanwo",
		trap_type = 0,
		desc = "区域中存在巨型漩涡，舰队通过时，每次移动有一定概率失败。",
		obstacle = 2,
		id = 1022,
		trap_range = {}
	}
	pg = var_1_29

	local var_1_30 = var_1_29.base.world_trap_data

	var_1_30[1023] = {
		buff_id = 323,
		name = "燃烧海域",
		repeat_trap = 1,
		trap_fx = "SLG_huo01",
		trap_type = 0,
		desc = "区域内的海面正在燃烧，进入后舰队会进入燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		obstacle = 2,
		id = 1023,
		trap_range = {}
	}
	pg = var_1_30

	local var_1_31 = var_1_30.base.world_trap_data

	var_1_31[1024] = {
		buff_id = 324,
		name = "EMP干扰TYPEI",
		repeat_trap = 0,
		trap_fx = "SLG_EMP01_1",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，无法准确前往目标区域。",
		obstacle = 1,
		id = 1024,
		trap_range = {}
	}
	pg = var_1_31

	local var_1_32 = var_1_31.base.world_trap_data

	var_1_32[1025] = {
		buff_id = 325,
		name = "EMP干扰TYPEII",
		repeat_trap = 0,
		trap_fx = "SLG_EMP02_1",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，每次行动移动范围将会降低。",
		obstacle = 1,
		id = 1025,
		trap_range = {}
	}
	pg = var_1_32

	local var_1_33 = var_1_32.base.world_trap_data

	var_1_33[1026] = {
		buff_id = 326,
		name = "低温海域",
		repeat_trap = 1,
		trap_fx = "SLG_bingwu",
		trap_type = 0,
		desc = "区域中温度很低，舰队进入后将会进入结冰状态，舰队战斗能力下降。结冰状态将会持续若干行动轮。",
		obstacle = 2,
		id = 1026,
		trap_range = {}
	}
	pg = var_1_33

	local var_1_34 = var_1_33.base.world_trap_data

	var_1_34[2001] = {
		buff_id = 315,
		name = "燃烧海域",
		repeat_trap = 0,
		trap_fx = "SLG_huo01",
		trap_type = 0,
		desc = "区域内的海面正在燃烧，进入后舰队会进入燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		obstacle = 2,
		id = 2001,
		trap_range = {}
	}
	pg = var_1_34

	local var_1_35 = var_1_34.base.world_trap_data

	var_1_35[2002] = {
		buff_id = 317,
		name = "旋涡海域",
		repeat_trap = 1,
		trap_fx = "SLG_xuanwo",
		trap_type = 0,
		desc = "区域中存在巨型漩涡，舰队通过时，每次移动有一定概率失败。",
		obstacle = 2,
		id = 2002,
		trap_range = {}
	}
	pg = var_1_35

	local var_1_36 = var_1_35.base.world_trap_data

	var_1_36[2003] = {
		buff_id = 311,
		name = "EMP干扰TYPEI",
		repeat_trap = 0,
		trap_fx = "SLG_EMP01_1",
		trap_type = 0,
		desc = "区域中存在周期性的EMP冲击，进入后将会使得舰队进入移动异常状态，无法准确前往目标区域。",
		obstacle = 1,
		id = 2003,
		trap_range = {}
	}
	pg = var_1_36

	local var_1_37 = var_1_36.base.world_trap_data

	var_1_37[2010] = {
		buff_id = 320,
		name = "异常燃烧海域",
		repeat_trap = 0,
		trap_fx = "SLG_huo02",
		trap_type = 0,
		desc = "区域内的海面正在燃烧，进入后舰队会进入燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		obstacle = 2,
		id = 2010,
		trap_range = {}
	}
	pg = var_1_37
	var_1_37.base.world_trap_data[2011] = {
		buff_id = 323,
		name = "燃烧海域",
		repeat_trap = 0,
		trap_fx = "SLG_huo01",
		trap_type = 0,
		desc = "区域内的海面正在燃烧，进入后舰队会进入燃烧状态，每次行动将会受到一定伤害。燃烧状态将会持续若干行动轮。",
		obstacle = 2,
		id = 2011,
		trap_range = {}
	}

	return
end)()

return
