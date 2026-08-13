pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "island_minigame_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_minigame_template"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.island_minigame_template = var_0_2
pg = var_0

local var_0_3 = var_0.island_minigame_template

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
var_0_3.base.island_minigame_template = {}

;(function()
	pg = var_1_10000
	var_1_10000.base.island_minigame_template[1] = {
		id = 1,
		result_ui = "IslandSeekGameUI",
		bt = "island/nodecanvas/seekgame/seekgame",
		interactive_objects = {
			10100003,
			10100004,
			10100005,
			10100006,
			10100012,
			10100013,
			10100014
		}
	}

	return
end)()

return
