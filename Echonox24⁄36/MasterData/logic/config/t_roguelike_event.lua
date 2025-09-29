-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_event.lua

module("logic.config.t_roguelike_event", package.seeall)

local title = {
	description = 7,
	name = 6,
	repeated = 11,
	type = 2,
	illustration = 8,
	layer = 10,
	eventType = 3,
	weekness = 4,
	prestory = 14,
	triggerCondition = 13,
	replyIds = 15,
	id = 1,
	icon = 9,
	weight = 12,
	diff = 5
}
local dataList = {
	{
		1,
		0,
		1,
		{
			1
		},
		3,
		"事件名1",
		"描述阿萨德阿萨德阿萨德阿萨德",
		"",
		"",
		nil,
		0,
		0,
		0,
		0,
		{
			1,
			2,
			3
		}
	},
	{
		2,
		0,
		2,
		{
			2
		},
		6,
		"事件名2",
		"描述区委区为请问请问",
		"",
		"",
		nil,
		0,
		0,
		0,
		0,
		{
			3
		}
	},
	{
		3,
		0,
		3,
		{
			6
		},
		3,
		"事件名3",
		"描述自行车V字形从",
		"",
		"",
		nil,
		0,
		0,
		0,
		0,
		{
			4
		}
	}
}
local t_roguelike_event = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_roguelike_event.dataList = dataList

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

return t_roguelike_event
