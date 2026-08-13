pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "island_achievement_group") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_achievement_group"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.island_achievement_group = var_0_2
pg = var_0

local var_0_3 = var_0.island_achievement_group

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
var_0_3.base.island_achievement_group = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_achievement_group

	var_1_0[1] = {
		id = 1,
		name = "筑梦之章",
		icon = "achv_type_2",
		achievement_list = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_achievement_group

	var_1_1[2] = {
		id = 2,
		name = "繁荣之道",
		icon = "achv_type_1",
		achievement_list = {
			101,
			102,
			103,
			104,
			105,
			106,
			107,
			108
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.island_achievement_group

	var_1_2[3] = {
		id = 3,
		name = "商贸之路",
		icon = "achv_type_3",
		achievement_list = {
			201,
			202,
			203,
			204,
			205
		}
	}
	pg = var_1_2
	var_1_2.base.island_achievement_group[4] = {
		id = 4,
		name = "成长之旅",
		icon = "achv_type_4",
		achievement_list = {
			301,
			302,
			303,
			304,
			305,
			306,
			307,
			308
		}
	}

	return
end)()

return
