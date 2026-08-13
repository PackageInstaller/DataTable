pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "fleet_tech_group") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "fleet_tech_group"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.fleet_tech_group = var_0_2
pg = var_0

local var_0_3 = var_0.fleet_tech_group

var_0_3.all = {
	1,
	2,
	3,
	4
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.fleet_tech_group = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.fleet_tech_group

	var_1_0[1] = {
		name = "作战技术-白鹰",
		id = 1,
		nation = {
			1
		},
		shiptype = {},
		techs = {
			1001,
			1002,
			1003,
			1004,
			1005,
			1006,
			1007,
			1008,
			1009
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.fleet_tech_group

	var_1_1[2] = {
		name = "作战技术-皇家",
		id = 2,
		nation = {
			2
		},
		shiptype = {},
		techs = {
			2001,
			2002,
			2003,
			2004,
			2005,
			2006,
			2007,
			2008,
			2009
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.fleet_tech_group

	var_1_2[3] = {
		name = "作战技术-重樱",
		id = 3,
		nation = {
			3
		},
		shiptype = {},
		techs = {
			3001,
			3002,
			3003,
			3004,
			3005,
			3006,
			3007,
			3008,
			3009
		}
	}
	pg = var_1_2
	var_1_2.base.fleet_tech_group[4] = {
		name = "作战技术-铁血",
		id = 4,
		nation = {
			4
		},
		shiptype = {},
		techs = {
			4001,
			4002,
			4003,
			4004,
			4005,
			4006,
			4007,
			4008,
			4009
		}
	}

	return
end)()

return
