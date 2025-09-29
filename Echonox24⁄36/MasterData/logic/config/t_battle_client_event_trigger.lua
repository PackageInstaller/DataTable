-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_battle_client_event_trigger.lua

module("logic.config.t_battle_client_event_trigger", package.seeall)

local title = {
	id = 1,
	resPath = 3,
	type = 2
}
local dataList = {
	{
		110003001,
		1,
		"sx_s109_juqing_terrains_fx"
	}
}
local t_battle_client_event_trigger = {}

t_battle_client_event_trigger.dataList = dataList

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
	t_battle_client_event_trigger[v[1]] = v

	setmetatable(v, mt)
end

return t_battle_client_event_trigger
