-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_task_label.lua

module("logic.config.t_roguelike_task_label", package.seeall)

local title = {
	taskLimit = 3,
	id = 1,
	pointIds = 5,
	type = 2,
	pointLimit = 4,
	endTime = 7,
	startTime = 6
}
local dataList = {
	{
		100011,
		11,
		7,
		0
	},
	{
		100013,
		13,
		999,
		0
	}
}
local t_roguelike_task_label = {}

t_roguelike_task_label.dataList = dataList

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
	t_roguelike_task_label[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_task_label
