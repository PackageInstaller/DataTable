pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "island_unit_interactive_item") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_unit_interactive_item"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.island_unit_interactive_item = var_0_2
pg = var_0

local var_0_3 = var_0.island_unit_interactive_item

var_0_3.all = {
	100203,
	100204,
	100205,
	100206
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.island_unit_interactive_item = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_unit_interactive_item

	var_1_0[100203] = {
		navAgentParam = "",
		name = "互动椅子",
		model = "island/item/collider/1002/prefab/chair_collider",
		id = 100203,
		slot_cnt = 1,
		timeline = {
			14
		},
		param = {
			{}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_unit_interactive_item

	var_1_1[100204] = {
		navAgentParam = "",
		name = "门",
		model = "island/item/collider/1002/prefab/chair_collider",
		id = 100204,
		slot_cnt = 1,
		timeline = {
			1111,
			1112
		},
		param = {
			{
				"open",
				true
			},
			{
				"open",
				false
			}
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.island_unit_interactive_item

	var_1_2[100205] = {
		navAgentParam = "",
		name = "床",
		model = "island/item/collider/1002/prefab/chair_collider",
		id = 100205,
		slot_cnt = 1,
		timeline = {
			15
		},
		param = {
			{}
		}
	}
	pg = var_1_2
	var_1_2.base.island_unit_interactive_item[100206] = {
		navAgentParam = "",
		name = "躺椅",
		model = "island/item/collider/1002/prefab/chair_collider",
		id = 100206,
		slot_cnt = 1,
		timeline = {
			16
		},
		param = {
			{}
		}
	}

	return
end)()

return
