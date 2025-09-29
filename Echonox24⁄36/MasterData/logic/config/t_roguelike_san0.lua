-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_san0.lua

module("logic.config.t_roguelike_san0", package.seeall)

local title = {
	count = 1,
	props = 2
}
local dataList = {
	{
		1,
		{
			20002,
			20003,
			20004
		}
	},
	{
		2,
		{
			20002,
			20003,
			20004
		}
	},
	{
		3,
		{
			20002,
			20003,
			20004
		}
	},
	{
		4,
		{
			20001,
			20001,
			20001
		}
	}
}
local t_roguelike_san0 = {}

t_roguelike_san0.dataList = dataList

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
	t_roguelike_san0[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_san0
