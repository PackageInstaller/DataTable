-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_equip_filter.lua

module("logic.config.t_equip_filter", package.seeall)

local title = {
	id = 1,
	suit = 2
}
local dataList = {
	{
		1,
		{
			1007,
			1008,
			1009
		}
	},
	{
		2,
		{
			1007,
			1008,
			1009
		}
	}
}
local t_equip_filter = {}

t_equip_filter.dataList = dataList

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
	t_equip_filter[v[1]] = v

	setmetatable(v, mt)
end

return t_equip_filter
