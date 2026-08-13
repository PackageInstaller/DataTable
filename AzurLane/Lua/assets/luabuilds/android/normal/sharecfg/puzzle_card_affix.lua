pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "puzzle_card_affix") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "puzzle_card_affix"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.puzzle_card_affix = var_0_2
pg = var_0

local var_0_3 = var_0.puzzle_card_affix

var_0_3.all = {
	100,
	101,
	102,
	103,
	301,
	306
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.puzzle_card_affix = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.puzzle_card_affix

	var_1_0[100] = {
		name = "跨射",
		affix_type = 0,
		name_EN = "",
		discript = "该卡牌只有在主力舰拥有跨射标签时才能够被加入卡池",
		id = 100,
		icon = "100",
		condition = 2,
		show = 1
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.puzzle_card_affix

	var_1_1[101] = {
		name = "空袭",
		affix_type = 0,
		name_EN = "",
		discript = "该卡牌只有在主力舰拥有空袭标签时才能够被加入卡池",
		id = 101,
		icon = "101",
		condition = 2,
		show = 1
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.puzzle_card_affix

	var_1_2[102] = {
		name = "雷击",
		affix_type = 0,
		name_EN = "",
		discript = "该卡牌只有在先锋舰拥有雷击标签时才能够被加入卡池",
		id = 102,
		icon = "102",
		condition = 1,
		show = 1
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.puzzle_card_affix

	var_1_3[103] = {
		name = "维修",
		affix_type = 0,
		name_EN = "",
		discript = "",
		id = 103,
		icon = "102",
		condition = 0,
		show = 1
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.puzzle_card_affix

	var_1_4[301] = {
		name = "循环",
		affix_type = 2,
		name_EN = "Reload",
		discript = "指令被打出后会回到待抽取指令的末尾",
		id = 301,
		icon = "301",
		condition = 0,
		show = 0
	}
	pg = var_1_4
	var_1_4.base.puzzle_card_affix[306] = {
		name = "自动武器",
		affix_type = 2,
		name_EN = "Auto Fire",
		discript = "可以给角色添加定时发射的攻击武器",
		id = 306,
		icon = "400",
		condition = 0,
		show = 0
	}

	return
end)()

return
