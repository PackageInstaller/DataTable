pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "island_manage_rank") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_manage_rank"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.island_manage_rank = var_0_2
pg = var_0

local var_0_3 = var_0.island_manage_rank

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
var_0_3.base.island_manage_rank = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_manage_rank

	var_1_0[1] = {
		name = "铜牌店铺",
		assistant_num = 1,
		bonus_coefficient = 90,
		id = 1,
		icon = "rank_tong",
		level_up_exp = {
			{
				601,
				10000
			},
			{
				602,
				10000
			},
			{
				603,
				10000
			},
			{
				604,
				10000
			},
			{
				901,
				10000
			}
		},
		slot_num = {
			2,
			5
		},
		assistant_unlock = {
			{
				601,
				0
			},
			{
				602,
				0
			},
			{
				603,
				0
			},
			{
				604,
				0
			},
			{
				901,
				0
			}
		},
		random_range = {
			-1,
			0
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_manage_rank

	var_1_1[2] = {
		name = "银牌店铺",
		assistant_num = 1,
		bonus_coefficient = 100,
		id = 2,
		icon = "rank_yin",
		level_up_exp = {
			{
				601,
				100000
			},
			{
				602,
				100000
			},
			{
				603,
				100000
			},
			{
				604,
				100000
			},
			{
				901,
				100000
			}
		},
		slot_num = {
			2,
			6
		},
		assistant_unlock = {
			{
				601,
				0
			},
			{
				602,
				0
			},
			{
				603,
				0
			},
			{
				604,
				0
			},
			{
				901,
				0
			}
		},
		random_range = {
			-1,
			0,
			1
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.island_manage_rank

	var_1_2[3] = {
		name = "金牌店铺",
		assistant_num = 2,
		bonus_coefficient = 110,
		id = 3,
		icon = "rank_jin",
		level_up_exp = {
			{
				601,
				1000000
			},
			{
				602,
				1000000
			},
			{
				603,
				1000000
			},
			{
				604,
				1000000
			},
			{
				901,
				1000000
			}
		},
		slot_num = {
			3,
			6
		},
		assistant_unlock = {
			{
				601,
				18006
			},
			{
				602,
				18007
			},
			{
				603,
				18008
			},
			{
				604,
				18009
			},
			{
				901,
				18002
			}
		},
		random_range = {
			-1,
			0,
			1,
			2
		}
	}
	pg = var_1_2
	var_1_2.base.island_manage_rank[4] = {
		name = "钻石店铺",
		assistant_num = 2,
		bonus_coefficient = 115,
		id = 4,
		icon = "rank_zuanshi",
		level_up_exp = {
			{
				601,
				0
			},
			{
				602,
				0
			},
			{
				603,
				0
			},
			{
				604,
				0
			},
			{
				901,
				0
			}
		},
		slot_num = {
			4,
			6
		},
		assistant_unlock = {
			{
				601,
				0
			},
			{
				602,
				0
			},
			{
				603,
				0
			},
			{
				604,
				0
			},
			{
				901,
				0
			}
		},
		random_range = {
			-1,
			0,
			1,
			2
		}
	}

	return
end)()

return
