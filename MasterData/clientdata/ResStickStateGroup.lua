-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResStickStateGroup.lua

local RT = {}

RT[1] = {
	2500030,
	2500040
}
RT[2] = {
	1,
	1
}
RT[3] = {
	2,
	2
}
RT[4] = {
	3,
	3
}
RT[5] = {
	4,
	4
}
RT[6] = {
	2500050,
	2500060
}
RT[7] = {
	2500010,
	2500020
}

local Data = {
	{
		{
			group_id = 1,
			level = 1,
			state_ids = RT[1],
			state_levels = RT[2]
		},
		{
			group_id = 1,
			level = 2,
			state_ids = RT[1],
			state_levels = RT[3]
		},
		{
			group_id = 1,
			level = 3,
			state_ids = RT[1],
			state_levels = RT[4]
		},
		{
			group_id = 1,
			level = 4,
			state_ids = RT[1],
			state_levels = RT[5]
		}
	},
	{
		{
			group_id = 2,
			level = 1,
			state_ids = RT[1],
			state_levels = RT[2]
		},
		{
			group_id = 2,
			level = 2,
			state_ids = RT[1],
			state_levels = {
				1,
				2
			}
		}
	},
	{
		{
			group_id = 3,
			level = 1,
			state_ids = RT[6],
			state_levels = RT[2]
		},
		{
			group_id = 3,
			level = 2,
			state_ids = RT[6],
			state_levels = {
				2,
				1
			}
		}
	},
	{
		{
			group_id = 4,
			level = 1,
			state_ids = RT[7],
			state_levels = RT[2]
		},
		{
			group_id = 4,
			level = 2,
			state_ids = RT[7],
			state_levels = RT[3]
		},
		{
			group_id = 4,
			level = 3,
			state_ids = RT[7],
			state_levels = RT[4]
		},
		{
			group_id = 4,
			level = 4,
			state_ids = RT[7],
			state_levels = RT[5]
		}
	}
}

return Data
