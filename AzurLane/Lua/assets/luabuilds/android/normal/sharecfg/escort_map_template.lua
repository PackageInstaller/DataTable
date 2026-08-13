pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "escort_map_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "escort_map_template"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.escort_map_template = var_0_2
pg = var_0

local var_0_3 = var_0.escort_map_template

var_0_3.all = {
	70000
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.escort_map_template = {}

;(function()
	pg = var_1_10000
	var_1_10000.base.escort_map_template[70000] = {
		level_limit = 40,
		id = 70000,
		refresh_time = 21600,
		escort_id_list = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11
		},
		drop_by_warn = {
			1,
			1,
			1,
			1,
			1
		}
	}

	return
end)()

return
