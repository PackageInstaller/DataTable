-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_pool.lua

module("logic.config.t_air_studio_pool", package.seeall)

local title = {
	id = 1,
	range = 2
}
local dataList = {
	{
		1,
		{
			0,
			0.2
		}
	},
	{
		2,
		{
			0.2,
			0.4
		}
	},
	{
		3,
		{
			0.4,
			0.6
		}
	},
	{
		4,
		{
			0.6,
			0.8
		}
	},
	{
		5,
		{
			0.8,
			1
		}
	}
}
local t_air_studio_pool = {}

t_air_studio_pool.dataList = dataList

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
	t_air_studio_pool[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_pool
