pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "child2_minigame") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "child2_minigame"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.child2_minigame = var_0_2
pg = var_0

local var_0_3 = var_0.child2_minigame

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
var_0_3.base.child2_minigame = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.child2_minigame

	var_1_0[1] = {
		id = 1,
		view_name = "NewEducateScratchGame",
		config_data = {
			finish_score = 1
		},
		result_data = {
			{
				{
					0,
					99
				},
				{
					3209504
				}
			}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.child2_minigame

	var_1_1[2] = {
		id = 2,
		view_name = "NewEducateNailingGame",
		config_data = {
			red_nail_count = 1,
			nail_score = 1,
			count = 3,
			hammer_spd = 350,
			red_nail_score = -1,
			nail_count = 3
		},
		result_data = {
			{
				{
					0,
					1
				},
				{
					3209504
				}
			},
			{
				{
					2,
					3
				},
				{
					3209504
				}
			},
			{
				{
					4,
					99
				},
				{
					3209504
				}
			}
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.child2_minigame

	var_1_2[3] = {
		id = 3,
		view_name = "NewEducateNailingGame",
		config_data = {
			red_nail_count = 1,
			nail_score = 1,
			count = 6,
			hammer_spd = 350,
			red_nail_score = -1,
			nail_count = 3
		},
		result_data = {
			{
				{
					0,
					1
				},
				{
					3209514
				}
			},
			{
				{
					2,
					3
				},
				{
					3209512
				}
			},
			{
				{
					4,
					99
				},
				{
					3209519
				}
			}
		}
	}
	pg = var_1_2
	var_1_2.base.child2_minigame[4] = {
		id = 4,
		view_name = "NewEducateNailingGame",
		config_data = {
			red_nail_count = 3,
			nail_score = 1,
			count = 6,
			hammer_spd = 400,
			red_nail_score = -1,
			nail_count = 3
		},
		result_data = {
			{
				{
					0,
					1
				},
				{
					3209514
				}
			},
			{
				{
					2,
					3
				},
				{
					3209512
				}
			},
			{
				{
					4,
					99
				},
				{
					3209519
				}
			}
		}
	}

	return
end)()

return
