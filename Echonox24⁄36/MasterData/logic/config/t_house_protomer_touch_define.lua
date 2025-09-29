-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_protomer_touch_define.lua

module("logic.config.t_house_protomer_touch_define", package.seeall)

local title = {
	id = 1,
	name = 2,
	billboardicon = 3
}
local dataList = {
	{
		1,
		"观测",
		"room_holding1_3"
	},
	{
		2,
		"维护",
		"room_holding1_3"
	},
	{
		3,
		"压迫",
		"room_holding1_3"
	},
	{
		4,
		"沟通",
		"room_holding1_3"
	},
	{
		5,
		"满足",
		"room_holding1_3"
	},
	{
		6,
		"特殊",
		"room_holding1_3"
	}
}
local t_house_protomer_touch_define = {}

t_house_protomer_touch_define.dataList = dataList

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
	t_house_protomer_touch_define[v[1]] = v

	setmetatable(v, mt)
end

return t_house_protomer_touch_define
