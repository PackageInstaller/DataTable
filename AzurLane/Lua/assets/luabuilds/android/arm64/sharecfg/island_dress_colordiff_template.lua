pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "island_dress_colordiff_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_dress_colordiff_template"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.island_dress_colordiff_template = var_0_2
pg = var_0

local var_0_3 = var_0.island_dress_colordiff_template

var_0_3.all = {
	104000101,
	104000102,
	104000201,
	104000202,
	104000301,
	104000302
}
pg = var_0_3

local var_0_4 = var_0_3.island_dress_colordiff_template

var_0_4.get_id_list_by_belongto_dress = {
	{
		104000101,
		104000102
	},
	{
		104000201,
		104000202
	},
	{
		104000301,
		104000302
	}
}
pg = var_0_4
pg = var_1

local var_0_5

if not var_1.base then
	var_0_5 = {}
end

var_0_4.base = var_0_5
pg = var_0_4
var_0_4.base.island_dress_colordiff_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_dress_colordiff_template

	var_1_0[104000101] = {
		related_dress = 0,
		model = "island/character/9001/prefab/9001_02_hair_component_desc_ext_mat_0",
		id = 104000101,
		color_icon = "color_104000101",
		belongto_dress = 1040001,
		cost = {
			{
				3,
				1
			}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_dress_colordiff_template

	var_1_1[104000102] = {
		related_dress = 0,
		model = "island/character/9001/prefab/9001_02_hair_component_desc_ext_mat_1",
		id = 104000102,
		color_icon = "color_104000102",
		belongto_dress = 1040001,
		cost = {
			{
				3,
				1
			}
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.island_dress_colordiff_template

	var_1_2[104000201] = {
		related_dress = 0,
		model = "island/character/9001/prefab/9001_01_hair_component_desc_ext_mat_0",
		id = 104000201,
		color_icon = "color_104000101",
		belongto_dress = 1040002,
		cost = {
			{
				3,
				1
			}
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.island_dress_colordiff_template

	var_1_3[104000202] = {
		related_dress = 0,
		model = "island/character/9001/prefab/9001_01_hair_component_desc_ext_mat_1",
		id = 104000202,
		color_icon = "color_104000102",
		belongto_dress = 1040002,
		cost = {
			{
				3,
				1
			}
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.island_dress_colordiff_template

	var_1_4[104000301] = {
		related_dress = 0,
		model = "island/character/9001/prefab/9001_00_hair_component_desc_ext_mat_0",
		id = 104000301,
		color_icon = "color_104000101",
		belongto_dress = 1040003,
		cost = {
			{
				3,
				1
			}
		}
	}
	pg = var_1_4
	var_1_4.base.island_dress_colordiff_template[104000302] = {
		related_dress = 0,
		model = "island/character/9001/prefab/9001_00_hair_component_desc_ext_mat_1",
		id = 104000302,
		color_icon = "color_104000102",
		belongto_dress = 1040003,
		cost = {
			{
				3,
				1
			}
		}
	}

	return
end)()

return
