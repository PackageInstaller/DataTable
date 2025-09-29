-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_map_group.lua

module("logic.config.t_roguelike_map_group", package.seeall)

local title = {
	id = 1,
	mapIds = 2
}
local dataList = {
	{
		1000,
		{
			100101,
			100102,
			100103
		}
	},
	{
		1001,
		{
			100201,
			100202,
			100203
		}
	},
	{
		1002,
		{
			100301,
			100302,
			100303
		}
	},
	{
		1003,
		{
			100401,
			100402,
			100403
		}
	}
}
local t_roguelike_map_group = {
	[1000] = dataList[1],
	[1001] = dataList[2],
	[1002] = dataList[3],
	[1003] = dataList[4]
}

t_roguelike_map_group.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_roguelike_map_group
