pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "equip_data_limit") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "equip_data_limit"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.equip_data_limit = var_0_2
pg = var_0

local var_0_3 = var_0.equip_data_limit

var_0_3.all = {
	3660,
	91260
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.equip_data_limit = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.equip_data_limit

	var_1_0[3660] = {
		restore_id = 647,
		group_id = 3660,
		max = 2
	}
	pg = var_1_0
	var_1_0.base.equip_data_limit[91260] = {
		restore_id = 648,
		group_id = 91260,
		max = 2
	}

	return
end)()

return
