pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "island_activity_pt_page") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_activity_pt_page"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.island_activity_pt_page = var_0_2
pg = var_0

local var_0_3 = var_0.island_activity_pt_page

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
var_0_3.base.island_activity_pt_page = {}

;(function()
	pg = var_1_10000
	var_1_10000.base.island_activity_pt_page[1] = {
		activity_id = 990013,
		point_type = 2,
		id = 1,
		btn_param = {
			{
				"goButton",
				"island_activity_pt_jump_1",
				{
					"IslandCheaterTavernPrepareMainPage"
				},
				{
					1,
					{
						990014,
						"island_activity_pt_jump_close"
					}
				}
			}
		},
		task_id = {
			90001001,
			90001002,
			90001003,
			90001004,
			90001005,
			90001006,
			90001007,
			90001008,
			90001009,
			90001010,
			90001011,
			90001012,
			90001020
		},
		import = {
			{
				90001003,
				"island_activity_pt_task_reward_tip_1"
			},
			{
				90001008,
				"island_activity_pt_task_reward_tip_2"
			},
			{
				90001012,
				"island_activity_pt_task_reward_tip_3"
			},
			{
				90001020,
				"island_activity_pt_task_reward_tip_4"
			}
		}
	}

	return
end)()

return
