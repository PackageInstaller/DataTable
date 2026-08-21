-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResBusinessOrder.lua

local RT = {}

RT[1] = {
	1,
	1,
	1
}

local Data = {
	{
		id = 1,
		order_quality = 1,
		material_count = RT[1],
		material_quality = {
			2,
			2,
			2
		}
	},
	{
		id = 2,
		order_quality = 1,
		material_count = {
			2,
			1
		},
		material_quality = {
			2,
			2
		}
	},
	{
		id = 3,
		order_quality = 1,
		material_count = {
			3
		},
		material_quality = {
			2
		}
	},
	{
		id = 4,
		order_quality = 2,
		material_count = RT[1],
		material_quality = {
			3,
			3,
			3
		}
	},
	{
		id = 5,
		order_quality = 3,
		material_count = RT[1],
		material_quality = {
			4,
			4,
			4
		}
	},
	{
		id = 6,
		order_quality = 4,
		material_count = RT[1],
		material_quality = {
			5,
			5,
			5
		}
	}
}

return Data
