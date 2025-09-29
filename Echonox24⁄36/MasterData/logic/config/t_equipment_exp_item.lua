-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_equipment_exp_item.lua

module("logic.config.t_equipment_exp_item", package.seeall)

local title = {
	itemId = 1,
	exp = 2
}
local dataList = {
	{
		1008001,
		100
	},
	{
		1008002,
		500
	},
	{
		1008003,
		5000
	}
}
local t_equipment_exp_item = {}

t_equipment_exp_item.dataList = dataList

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
	t_equipment_exp_item[v[1]] = v

	setmetatable(v, mt)
end

return t_equipment_exp_item
