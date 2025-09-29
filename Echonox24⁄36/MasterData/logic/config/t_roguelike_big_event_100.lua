-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_big_event_100.lua

module("logic.config.t_roguelike_big_event_100", package.seeall)

local title = {
	id = 2,
	name = 3,
	scriptId = 1,
	startEventId = 4
}
local dataList = {
	{
		100,
		10001,
		"大事件1",
		1000109
	},
	{
		100,
		10002,
		"大事件2",
		1000213
	},
	{
		100,
		10003,
		"大事件3",
		1000309
	},
	{
		100,
		10004,
		"大事件4",
		1000410
	}
}
local t_roguelike_big_event_100 = {}

t_roguelike_big_event_100.dataList = dataList

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
	local parent1 = t_roguelike_big_event_100[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_roguelike_big_event_100[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_roguelike_big_event_100
