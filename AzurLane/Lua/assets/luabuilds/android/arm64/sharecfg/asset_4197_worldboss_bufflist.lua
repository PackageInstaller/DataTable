pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "worldboss_bufflist") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "worldboss_bufflist"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.worldboss_bufflist = var_0_2
pg = var_0

local var_0_3 = var_0.worldboss_bufflist

var_0_3.all = {
	1001,
	1002,
	1003,
	1004,
	1005,
	1006,
	1007,
	1008,
	1009,
	1010,
	1011,
	1012,
	1013,
	1014,
	1015,
	1016,
	1017,
	1018,
	1019,
	1020,
	1021,
	101701,
	101801
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.worldboss_bufflist = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.worldboss_bufflist

	var_1_0[1001] = {
		buff_icon = "1001",
		lua_id = 59010,
		bonus = "0.1",
		id = 1001,
		buff_target = 1,
		desc = "敌方旗舰的炮击增加50%"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.worldboss_bufflist

	var_1_1[1002] = {
		buff_icon = "1002",
		lua_id = 59020,
		bonus = "0.1",
		id = 1002,
		buff_target = 1,
		desc = "敌方旗舰的雷击增加50%"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.worldboss_bufflist

	var_1_2[1003] = {
		buff_icon = "1003",
		lua_id = 59030,
		bonus = "0.1",
		id = 1003,
		buff_target = 1,
		desc = "敌方旗舰的航空增加50%"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.worldboss_bufflist

	var_1_3[1004] = {
		buff_icon = "1004",
		lua_id = 59040,
		bonus = "0.05",
		id = 1004,
		buff_target = 1,
		desc = "敌方旗舰受到的炮击伤害降低30%"
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.worldboss_bufflist

	var_1_4[1005] = {
		buff_icon = "1005",
		lua_id = 59050,
		bonus = "0.05",
		id = 1005,
		buff_target = 1,
		desc = "敌方旗舰受到的雷击伤害降低30%"
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.worldboss_bufflist

	var_1_5[1006] = {
		buff_icon = "1006",
		lua_id = 59060,
		bonus = "0.05",
		id = 1006,
		buff_target = 1,
		desc = "敌方旗舰受到的航空伤害降低30%"
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.worldboss_bufflist

	var_1_6[1007] = {
		buff_icon = "1007",
		lua_id = 59070,
		bonus = "0.1",
		id = 1007,
		buff_target = 1,
		desc = "敌方旗舰的伤害提高20%"
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.worldboss_bufflist

	var_1_7[1008] = {
		buff_icon = "1008",
		lua_id = 59080,
		bonus = "0.05",
		id = 1008,
		buff_target = 1,
		desc = "在本次战斗中，我方全部角色受到的恢复效果会被反转为伤害效果"
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.worldboss_bufflist

	var_1_8[1009] = {
		buff_icon = "1009",
		lua_id = 59090,
		bonus = "0.03",
		id = 1009,
		buff_target = 1,
		desc = "敌方旗舰耐久值下降至20%以下时，生成一面能够阻挡子弹的护盾，护盾永久存在"
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.worldboss_bufflist

	var_1_9[1010] = {
		buff_icon = "1010",
		lua_id = 59100,
		bonus = "0.05",
		id = 1010,
		buff_target = 1,
		desc = "敌方旗舰的航速增加30%"
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.worldboss_bufflist

	var_1_10[1011] = {
		buff_icon = "1011",
		lua_id = 59110,
		bonus = "0.05",
		id = 1011,
		buff_target = 1,
		desc = "敌方旗舰的防空增加30%"
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.worldboss_bufflist

	var_1_11[1012] = {
		buff_icon = "1012",
		lua_id = 59120,
		bonus = "0.05",
		id = 1012,
		buff_target = 1,
		desc = "敌方旗舰对我方前排先锋造成的伤害增加20%"
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.worldboss_bufflist

	var_1_12[1013] = {
		buff_icon = "1013",
		lua_id = 59130,
		bonus = "0.05",
		id = 1013,
		buff_target = 1,
		desc = "敌方旗舰对我方后排主力造成的伤害增加20%"
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.worldboss_bufflist

	var_1_13[1014] = {
		buff_icon = "1014",
		lua_id = 59140,
		bonus = "0.05",
		id = 1014,
		buff_target = 1,
		desc = "敌方旗舰登场后，每过15秒对我方全体角色造成最大耐久值5%的伤害"
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.worldboss_bufflist

	var_1_14[1015] = {
		buff_icon = "1015",
		lua_id = 59150,
		bonus = "0.05",
		id = 1015,
		buff_target = 1,
		desc = "在战斗中每间隔一段时间会生成减速力场，进入力场的我方舰船角色减速10%"
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.worldboss_bufflist

	var_1_15[1016] = {
		buff_icon = "1016",
		lua_id = 59160,
		bonus = "0.05",
		id = 1016,
		buff_target = 1,
		desc = "我方航母以外的单位命中率下降5%"
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.worldboss_bufflist

	var_1_16[1017] = {
		buff_icon = "1017",
		lua_id = 59170,
		bonus = "0.03",
		id = 1017,
		buff_target = 1,
		desc = "战斗中每隔一段时间，敌方旗舰会发射一轮特殊弹幕"
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.worldboss_bufflist

	var_1_17[1018] = {
		buff_icon = "1018",
		lua_id = 59180,
		bonus = "0.03",
		id = 1018,
		buff_target = 1,
		desc = "战斗随机出现敌方的航空编队支援"
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.worldboss_bufflist

	var_1_18[1019] = {
		buff_icon = "1019",
		lua_id = 59190,
		bonus = "0.1",
		id = 1019,
		buff_target = 1,
		desc = "每间隔一段时间敌方旗舰会生成一个极大幅度降低被暴击概率的护盾，持续5秒"
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.worldboss_bufflist

	var_1_19[1020] = {
		buff_icon = "1020",
		lua_id = 59200,
		bonus = "0.1",
		id = 1020,
		buff_target = 1,
		desc = "敌方旗舰登场后，每过15秒提高自身全属性提升10%，最高叠加5层"
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.worldboss_bufflist

	var_1_20[1021] = {
		buff_icon = "1021",
		lua_id = 59210,
		bonus = "0.05",
		id = 1021,
		buff_target = 1,
		desc = "每间隔一段时间，敌方旗舰会生成一个可以吸收自身最大耐久值10%伤害的护盾，持续5秒"
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.worldboss_bufflist

	var_1_21[101701] = {
		buff_icon = "1017",
		lua_id = 59220,
		bonus = "0.03",
		id = 101701,
		buff_target = 1,
		desc = "战斗中每隔一段时间，敌方旗舰会发射一轮特殊弹幕"
	}
	pg = var_1_21
	var_1_21.base.worldboss_bufflist[101801] = {
		buff_icon = "1018",
		lua_id = 59230,
		bonus = "0.03",
		id = 101801,
		buff_target = 1,
		desc = "战斗随机出现敌方的航空编队支援"
	}

	return
end)()

return
