-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResEquipPropsRand.lua

local RT = {}

RT[1] = {
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1
}
RT[2] = {
	1,
	1,
	1,
	1,
	1,
	1
}
RT[3] = {
	1,
	1,
	1,
	1
}

local Data = {
	[1000] = {
		id = 1000,
		dump_count = 1,
		rand_count = 10,
		effect_type = RT[1],
		rand_prop_data = {
			11,
			13,
			24,
			12,
			14,
			25,
			4,
			3,
			23,
			26
		},
		rand_prop_weight = RT[1]
	},
	[1001] = {
		id = 1001,
		dump_count = 2,
		rand_count = 6,
		effect_type = RT[2],
		rand_prop_data = {
			11,
			12,
			4,
			3,
			23,
			26
		},
		rand_prop_weight = RT[2]
	},
	[1002] = {
		id = 1002,
		dump_count = 2,
		rand_count = 6,
		effect_type = RT[2],
		rand_prop_data = {
			13,
			24,
			14,
			25,
			23,
			26
		},
		rand_prop_weight = RT[2]
	},
	[1010] = {
		id = 1010,
		dump_count = 1,
		rand_count = 4,
		effect_type = RT[3],
		rand_prop_data = {
			24,
			12,
			3,
			26
		},
		rand_prop_weight = RT[3]
	},
	[1011] = {
		id = 1011,
		dump_count = 1,
		rand_count = 4,
		effect_type = RT[3],
		rand_prop_data = {
			12,
			3,
			4,
			26
		},
		rand_prop_weight = RT[3]
	},
	[1012] = {
		id = 1012,
		dump_count = 1,
		rand_count = 4,
		effect_type = RT[3],
		rand_prop_data = {
			24,
			13,
			25,
			23
		},
		rand_prop_weight = RT[3]
	}
}

return Data
