pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "draw_data_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "draw_data_template"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.draw_data_template = var_0_2
pg = var_0

local var_0_3 = var_0.draw_data_template

var_0_3.all = {
	1,
	2
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.draw_data_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.draw_data_template

	var_1_0[1] = {
		name = "钻石建造",
		type = 1,
		id = 1,
		use_gem_1 = {
			10,
			100,
			200
		},
		use_gem_10 = {
			1000,
			2000
		},
		bgs = {
			"bg_adv",
			"bg_adv"
		}
	}
	pg = var_1_0
	var_1_0.base.draw_data_template[2] = {
		name = "钻石建造-活动",
		type = 2,
		id = 2,
		use_gem_1 = {
			10,
			100,
			200
		},
		use_gem_10 = {
			1000,
			2000
		},
		bgs = {
			"bg_adv",
			"bg_adv"
		}
	}

	return
end)()

return
