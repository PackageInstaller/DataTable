-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResArenaFormationHide.lua

local RT = {}

RT[1] = {
	hide = 0
}
RT[2] = {
	hide = 1
}

local Data = {
	{
		id = 1,
		formation = {
			RT[1],
			RT[1],
			RT[1]
		}
	},
	{
		id = 2,
		formation = {
			RT[1],
			RT[1],
			RT[2]
		}
	},
	{
		id = 3,
		formation = {
			RT[1],
			RT[2],
			RT[2]
		}
	},
	{
		id = 4,
		formation = {
			RT[2],
			RT[2],
			RT[2]
		}
	}
}

return Data
