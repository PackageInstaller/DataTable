-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResEquipQualityRand.lua

local RT = {}

RT[1] = {
	2,
	3,
	4
}
RT[2] = {
	40,
	45,
	15
}
RT[3] = {
	1
}
RT[4] = {
	2
}
RT[5] = {
	2,
	3
}
RT[6] = {
	45,
	45,
	10
}

local Data = {
	{
		rand_count = 1,
		id = 1,
		rand_data = {
			0
		},
		rand_weight = RT[3]
	},
	{
		rand_count = 1,
		id = 2,
		rand_data = RT[3],
		rand_weight = RT[3]
	},
	{
		rand_count = 1,
		id = 3,
		rand_data = RT[4],
		rand_weight = RT[3]
	},
	{
		rand_count = 1,
		id = 4,
		rand_data = {
			3
		},
		rand_weight = RT[3]
	},
	{
		rand_count = 1,
		id = 5,
		rand_data = {
			4
		},
		rand_weight = RT[3]
	},
	[103] = {
		rand_count = 3,
		id = 103,
		rand_data = RT[4],
		rand_weight = RT[3]
	},
	[110] = {
		rand_count = 3,
		id = 110,
		rand_data = RT[4],
		rand_weight = RT[3]
	},
	[120] = {
		rand_count = 3,
		id = 120,
		rand_data = RT[5],
		rand_weight = {
			85,
			15
		}
	},
	[210] = {
		rand_count = 3,
		id = 210,
		rand_data = RT[5],
		rand_weight = {
			90,
			10
		}
	},
	[220] = {
		rand_count = 3,
		id = 220,
		rand_data = RT[1],
		rand_weight = RT[6]
	},
	[310] = {
		rand_count = 3,
		id = 310,
		rand_data = RT[1],
		rand_weight = RT[6]
	},
	[320] = {
		rand_count = 3,
		id = 320,
		rand_data = RT[1],
		rand_weight = RT[2]
	},
	[410] = {
		rand_count = 3,
		id = 410,
		rand_data = RT[1],
		rand_weight = RT[6]
	},
	[420] = {
		rand_count = 3,
		id = 420,
		rand_data = RT[1],
		rand_weight = RT[2]
	},
	[510] = {
		rand_count = 3,
		id = 510,
		rand_data = RT[1],
		rand_weight = RT[6]
	},
	[520] = {
		rand_count = 3,
		id = 520,
		rand_data = RT[1],
		rand_weight = RT[2]
	}
}

return Data
