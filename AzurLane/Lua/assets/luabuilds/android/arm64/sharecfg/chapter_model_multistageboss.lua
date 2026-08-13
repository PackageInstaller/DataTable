pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "chapter_model_multistageboss") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "chapter_model_multistageboss"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.chapter_model_multistageboss = var_0_2
pg = var_0

local var_0_3 = var_0.chapter_model_multistageboss

var_0_3.all = {
	1503,
	1504
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.chapter_model_multistageboss = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.chapter_model_multistageboss

	var_1_0[1503] = {
		boss_expedition_id = {
			153013,
			153014
		},
		boss_refresh = {
			3,
			2
		},
		guild_buff = {
			96
		}
	}
	pg = var_1_0
	var_1_0.base.chapter_model_multistageboss[1504] = {
		boss_expedition_id = {
			154013,
			154014,
			154015
		},
		boss_refresh = {
			3,
			2,
			1
		},
		guild_buff = {
			96
		}
	}

	return
end)()

return
