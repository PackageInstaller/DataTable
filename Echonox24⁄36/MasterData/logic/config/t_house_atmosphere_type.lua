-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_atmosphere_type.lua

module("logic.config.t_house_atmosphere_type", package.seeall)

local title = {
	name = 2,
	type = 1
}
local dataList = {
	{
		1,
		"普通"
	},
	{
		2,
		"生态"
	},
	{
		3,
		"科技"
	},
	{
		4,
		"娱乐"
	},
	{
		5,
		"灵感"
	},
	{
		6,
		"生活"
	}
}
local t_house_atmosphere_type = {}

t_house_atmosphere_type.dataList = dataList

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
	t_house_atmosphere_type[v[1]] = v

	setmetatable(v, mt)
end

return t_house_atmosphere_type
