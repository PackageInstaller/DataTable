pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "island_collection") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_collection"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.island_collection = var_0_2
pg = var_0

local var_0_3 = var_0.island_collection

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
var_0_3.base.island_collection = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_collection

	var_1_0[1] = {
		name = "飞行器",
		type = 1,
		story = "这是一个神秘的飞行器，巴拉巴拉巴拉巴拉",
		ability_id = 16001,
		desc = "飞行器-港口",
		tech_id = 0,
		id = 1,
		icon = "IslandProps/gold",
		end_time = {
			{
				2125,
				1,
				1
			},
			{
				0,
				0,
				0
			}
		},
		fragment_list = {
			1010,
			1011,
			1012
		},
		award = {},
		jump_page = {}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_collection

	var_1_1[2] = {
		name = "飞行器",
		type = 1,
		story = "这是一个神秘的飞行器，巴拉巴拉巴拉巴拉",
		ability_id = 16002,
		desc = "飞行器-野外",
		tech_id = 0,
		id = 2,
		icon = "IslandProps/gold",
		end_time = {
			{
				2125,
				1,
				1
			},
			{
				0,
				0,
				0
			}
		},
		fragment_list = {
			1006,
			1007,
			1008,
			1009
		},
		award = {},
		jump_page = {}
	}
	pg = var_1_1
	var_1_1.base.island_collection[3] = {
		name = "飞行器",
		type = 1,
		story = "这是一个神秘的飞行器，巴拉巴拉巴拉巴拉",
		ability_id = 16003,
		desc = "飞行器-农场",
		tech_id = 0,
		id = 3,
		icon = "IslandProps/gold",
		end_time = {
			{
				2125,
				1,
				1
			},
			{
				0,
				0,
				0
			}
		},
		fragment_list = {
			1001,
			1002,
			1003,
			1004,
			1005
		},
		award = {},
		jump_page = {}
	}

	return
end)()

return
