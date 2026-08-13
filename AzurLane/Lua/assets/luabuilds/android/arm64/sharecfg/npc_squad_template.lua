pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "npc_squad_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "npc_squad_template"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.npc_squad_template = var_0_2
pg = var_0

local var_0_3 = var_0.npc_squad_template

var_0_3.all = {
	1,
	2,
	3,
	4,
	5,
	6,
	7
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.npc_squad_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.npc_squad_template

	var_1_0[1] = {
		type = 2,
		id = 1,
		task_id = 10048,
		vanguard_list = {
			{
				900020,
				100
			}
		},
		main_list = {}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.npc_squad_template

	var_1_1[2] = {
		type = 2,
		id = 2,
		task_id = 10049,
		vanguard_list = {
			{
				900020,
				100
			}
		},
		main_list = {}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.npc_squad_template

	var_1_2[3] = {
		type = 2,
		id = 3,
		task_id = 10050,
		vanguard_list = {
			{
				900020,
				100
			}
		},
		main_list = {}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.npc_squad_template

	var_1_3[4] = {
		type = 1,
		id = 4,
		task_id = 0,
		vanguard_list = {
			{
				900185,
				90
			},
			{
				900186,
				90
			}
		},
		main_list = {
			{
				900184,
				104
			}
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.npc_squad_template

	var_1_4[5] = {
		type = 1,
		id = 5,
		task_id = 0,
		vanguard_list = {
			{
				900185,
				90
			},
			{
				900186,
				90
			}
		},
		main_list = {
			{
				900184,
				104
			}
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.npc_squad_template

	var_1_5[6] = {
		type = 1,
		id = 6,
		task_id = 0,
		vanguard_list = {
			{
				900186,
				90
			},
			{
				900187,
				91
			},
			{
				900188,
				93
			}
		},
		main_list = {
			{
				900184,
				104
			}
		}
	}
	pg = var_1_5
	var_1_5.base.npc_squad_template[7] = {
		type = 1,
		id = 7,
		task_id = 0,
		vanguard_list = {
			{
				900185,
				90
			},
			{
				900187,
				91
			},
			{
				900188,
				93
			}
		},
		main_list = {
			{
				900184,
				104
			}
		}
	}

	return
end)()

return
