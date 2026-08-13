pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "world_regions_data") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "world_regions_data"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.world_regions_data = var_0_2
pg = var_0

local var_0_3 = var_0.world_regions_data

var_0_3.all = {
	1,
	2,
	3,
	4,
	5
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.world_regions_data = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.world_regions_data

	var_1_0[1] = {
		maskid = 101,
		name = "NA海域西北",
		id = 1,
		regions_pos = {
			625,
			926
		},
		regions_rotation = {
			180
		},
		open_stage = {
			50
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.world_regions_data

	var_1_1[2] = {
		maskid = 141,
		name = "NA海域东北",
		id = 2,
		regions_pos = {
			1397,
			926
		},
		regions_rotation = {
			180
		},
		open_stage = {
			25
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.world_regions_data

	var_1_2[3] = {
		maskid = 11,
		name = "NA海域西南",
		id = 3,
		regions_pos = {
			625,
			413
		},
		regions_rotation = {
			0
		},
		open_stage = {
			0
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.world_regions_data

	var_1_3[4] = {
		maskid = 61,
		name = "NA海域东南",
		id = 4,
		regions_pos = {
			1397,
			413
		},
		regions_rotation = {
			0
		},
		open_stage = {
			75
		}
	}
	pg = var_1_3
	var_1_3.base.world_regions_data[5] = {
		maskid = 151,
		name = "NA海域中心",
		id = 5,
		regions_pos = {
			991,
			559
		},
		regions_rotation = {
			45
		},
		open_stage = {
			110
		}
	}

	return
end)()

return
