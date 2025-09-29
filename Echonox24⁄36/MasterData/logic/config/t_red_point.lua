-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_red_point.lua

module("logic.config.t_red_point", package.seeall)

local title = {
	online = 2,
	numerable = 4,
	load = 3,
	id = 1
}
local dataList = {
	{
		1,
		true,
		true,
		true
	},
	{
		2,
		true,
		true,
		false
	},
	{
		3,
		true,
		true,
		false
	}
}
local t_red_point = {}

t_red_point.dataList = dataList

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
	t_red_point[v[1]] = v

	setmetatable(v, mt)
end

return t_red_point
