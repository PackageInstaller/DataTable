-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_event_reply.lua

module("logic.config.t_roguelike_event_reply", package.seeall)

local title = {
	description = 2,
	effect = 5,
	prop = 4,
	id = 1,
	limit = 3
}
local dataList = {
	{
		1,
		"选项描述1",
		nil,
		2
	},
	{
		2,
		"选项描述2",
		{
			19
		},
		0
	},
	{
		3,
		"选项描述3",
		nil,
		0
	},
	{
		4,
		"选项描述4",
		nil,
		0
	}
}
local t_roguelike_event_reply = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_roguelike_event_reply.dataList = dataList

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

return t_roguelike_event_reply
