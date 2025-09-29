-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_activity_task_label.lua

module("logic.config.t_activity_task_label", package.seeall)

local title = {
	id = 1,
	taskLimit = 3,
	type = 2
}
local dataList = {
	{
		100037,
		37,
		10
	},
	{
		100040,
		40,
		30
	},
	{
		100041,
		41,
		30
	},
	{
		100042,
		42,
		30
	}
}
local t_activity_task_label = {}

t_activity_task_label.dataList = dataList

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
	t_activity_task_label[v[1]] = v

	setmetatable(v, mt)
end

return t_activity_task_label
