pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "island_fish_rod") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_fish_rod"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.island_fish_rod = var_0_2
pg = var_0

local var_0_3 = var_0.island_fish_rod

var_0_3.all = {
	1,
	2,
	3
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.island_fish_rod = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_fish_rod

	var_1_0[1] = {
		attachment_id = 10008,
		name = "普通钓竿",
		qte_effect = "fish_rod1",
		id = 1,
		hard = 3
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_fish_rod

	var_1_1[2] = {
		attachment_id = 10014,
		name = "高级鱼竿",
		qte_effect = "fish_rod2",
		id = 2,
		hard = 6
	}
	pg = var_1_1
	var_1_1.base.island_fish_rod[3] = {
		attachment_id = 10015,
		name = "专业鱼竿",
		qte_effect = "fish_rod3",
		id = 3,
		hard = 9
	}

	return
end)()

return
