pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "world_expedition_data_by_map") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "world_expedition_data_by_map"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.world_expedition_data_by_map = var_0_2
pg = var_0

local var_0_3 = var_0.world_expedition_data_by_map

var_0_3.all = {
	1
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.world_expedition_data_by_map = {}

;(function()
	pg = var_1_10000
	var_1_10000.base.world_expedition_data_by_map[1] = {
		map = 1,
		name = "大世界主地图",
		bgm = "level",
		bg = {
			"world_map_1_1",
			"world_map_1_2",
			"world_map_1_3"
		},
		size = {
			3072,
			989
		}
	}

	return
end)()

return
