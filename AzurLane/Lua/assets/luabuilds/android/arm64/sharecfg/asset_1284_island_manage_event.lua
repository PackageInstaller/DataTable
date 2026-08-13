pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "island_manage_event") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_manage_event"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.island_manage_event = var_0_2
pg = var_0

local var_0_3 = var_0.island_manage_event

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
var_0_3.base.island_manage_event = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_manage_event

	var_1_0[1] = {
		name = "啾啾旅行团",
		influence_bonus = 10,
		id = 1,
		banner = 0,
		desc = "啾啾旅行团拜访岛屿开发区，在$1订餐",
		event_effect = {
			{
				10,
				3
			}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_manage_event

	var_1_1[2] = {
		name = "健康开发日",
		influence_bonus = 20,
		id = 2,
		banner = 0,
		desc = "岛屿开发团队准备一起在$1聚餐",
		event_effect = {
			{
				20,
				2
			}
		}
	}
	pg = var_1_1
	var_1_1.base.island_manage_event[3] = {
		name = "美食评审",
		influence_bonus = 30,
		id = 3,
		banner = 0,
		desc = "今日的岛屿最佳美食已经选出，快去$1尝尝吧",
		event_effect = {
			{
				30,
				1
			}
		}
	}

	return
end)()

return
