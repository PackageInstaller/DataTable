-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_protomer_degree.lua

module("logic.config.t_house_protomer_degree", package.seeall)

local title = {
	id = 1,
	name = 2,
	icon = 3,
	back = 4
}
local dataList = {
	{
		1,
		"Lunatic",
		"room_holding_threat_1",
		"room_holding_threat_di_1"
	},
	{
		2,
		"Ritual",
		"room_holding_threat_2",
		"room_holding_threat_di_2"
	},
	{
		3,
		"Alter",
		"room_holding_threat_3",
		"room_holding_threat_di_3"
	},
	{
		4,
		"Majestic",
		"room_holding_threat_4",
		"room_holding_threat_di_4"
	},
	{
		5,
		"Eternal",
		"room_holding_threat_5",
		"room_holding_threat_di_5"
	}
}
local t_house_protomer_degree = {}

t_house_protomer_degree.dataList = dataList

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
	t_house_protomer_degree[v[1]] = v

	setmetatable(v, mt)
end

return t_house_protomer_degree
