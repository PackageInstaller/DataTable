pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "puzzle_relics_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "puzzle_relics_template"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.puzzle_relics_template = var_0_2
pg = var_0

local var_0_3 = var_0.puzzle_relics_template

var_0_3.all = {
	10001
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.puzzle_relics_template = {}

;(function()
	pg = var_1_10000
	var_1_10000.base.puzzle_relics_template[10001] = {
		book_idx = 1,
		name = "测试一号",
		type = 1,
		id = 10001,
		icon = "10001",
		rarity = 1,
		desc = "测试",
		arg_list = {
			1
		}
	}

	return
end)()

return
