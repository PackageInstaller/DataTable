-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_big_event_101.lua

module("logic.config.t_roguelike_big_event_101", package.seeall)

local title = {
	id = 2,
	name = 3,
	scriptId = 1,
	startEventId = 4
}
local dataList = {}
local t_roguelike_big_event_101 = {}

t_roguelike_big_event_101.dataList = dataList

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
	local parent1 = t_roguelike_big_event_101[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_roguelike_big_event_101[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_roguelike_big_event_101
