-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResStageReturnSuppress.lua

local RT = {}

RT[1] = {
	{
		suppress_state = 9800114
	},
	{
		suppress_state = 9800113
	},
	{
		suppress_state = 9800112
	},
	{
		suppress_state = 9800112
	},
	{
		suppress_state = 9800111
	},
	{
		suppress_state = 9800111
	}
}
RT[2] = {
	suppress_state = 9800112
}
RT[3] = {
	suppress_state = 9800111
}
RT[4] = {
	{
		suppress_state = 9800124
	},
	{
		suppress_state = 9800123
	},
	{
		suppress_state = 9800122
	},
	{
		suppress_state = 9800122
	},
	{
		suppress_state = 9800121
	},
	{
		suppress_state = 9800121
	}
}
RT[5] = {
	suppress_state = 9800122
}
RT[6] = {
	suppress_state = 9800121
}
RT[7] = {
	suppress_state = 9800132
}
RT[8] = {
	suppress_state = 9800131
}

local Data = {
	{
		suppress_id = 1,
		return_phase = RT[1]
	},
	{
		suppress_id = 2,
		return_phase = RT[1]
	},
	{
		suppress_id = 3,
		return_phase = RT[1]
	},
	{
		suppress_id = 4,
		return_phase = RT[4]
	},
	{
		suppress_id = 5,
		return_phase = RT[4]
	},
	{
		suppress_id = 6,
		return_phase = RT[4]
	},
	{
		suppress_id = 7,
		return_phase = {
			{
				suppress_state = 9800134
			},
			{
				suppress_state = 9800133
			},
			RT[7],
			RT[7],
			RT[8],
			RT[8]
		}
	}
}

return Data
