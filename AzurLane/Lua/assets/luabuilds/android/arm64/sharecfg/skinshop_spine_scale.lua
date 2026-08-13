pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "skinshop_spine_scale") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "skinshop_spine_scale"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.skinshop_spine_scale = var_0_2
pg = var_0

local var_0_3 = var_0.skinshop_spine_scale

var_0_3.all = {
	701023,
	402083,
	502091,
	501061
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.skinshop_spine_scale = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.skinshop_spine_scale

	var_1_0[701023] = {
		id = 701023,
		skinshop_scale = 0.7
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.skinshop_spine_scale

	var_1_1[402083] = {
		id = 402083,
		skinshop_scale = 0.8
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.skinshop_spine_scale

	var_1_2[502091] = {
		id = 502091,
		skinshop_scale = 0.8
	}
	pg = var_1_2
	var_1_2.base.skinshop_spine_scale[501061] = {
		id = 501061,
		skinshop_scale = 0.8
	}

	return
end)()

return
