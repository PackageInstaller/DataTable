pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "child_resource") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "child_resource"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.child_resource = var_0_2
pg = var_0

local var_0_3 = var_0.child_resource

var_0_3.all = {
	1,
	2,
	3,
	4
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.child_resource = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.child_resource

	var_1_0[1] = {
		min_value = 0,
		name = "金钱",
		max_value = 99999,
		id = 1,
		icon = "10003",
		default_value = 20,
		desc = "虚拟小镇的货币，用处多多"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.child_resource

	var_1_1[2] = {
		min_value = 0,
		name = "心情",
		max_value = 100,
		id = 2,
		icon = "10002",
		default_value = 50,
		desc = "$1\n心情将会影响属性、能力、金钱的收益\n0~19:收益减少40%      20~39:收益减少20%\n40~59:收益不变             60~100: 收益增加40%"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.child_resource

	var_1_2[3] = {
		min_value = 0,
		name = "行动力",
		max_value = 2000,
		id = 3,
		icon = "10001",
		default_value = 0,
		desc = "用于大地图出行，每周会回复至满值。\n在系统升级后，行动力上限将会得到提升。"
	}
	pg = var_1_2
	var_1_2.base.child_resource[4] = {
		min_value = 0,
		name = "好感度",
		max_value = 500,
		id = 4,
		icon = "10014",
		default_value = 30,
		desc = "完成心事任务与主界面对话事件均可增加好感度。\n可用于解锁「心与心的交汇」剧情。"
	}

	return
end)()

return
