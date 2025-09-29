-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_buff.lua

module("logic.config.t_house_buff", package.seeall)

local title = {
	effects = 5,
	name = 2,
	icon = 3,
	description = 6,
	id = 1,
	maxLayer = 4
}
local dataList = {
	{
		1,
		"test",
		101,
		1,
		{
			17
		},
		"自身每小时心情消耗-1.0，持续1小时"
	}
}
local t_house_buff = {}

t_house_buff.dataList = dataList

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
	t_house_buff[v[1]] = v

	setmetatable(v, mt)
end

return t_house_buff
