-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_newbie_task_group.lua

module("logic.config.t_newbie_task_group", package.seeall)

local title = {
	group = 1,
	currencyId = 2
}
local dataList = {
	{
		1,
		1100011
	},
	{
		2,
		1100020
	}
}
local t_newbie_task_group = {}

t_newbie_task_group.dataList = dataList

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
	t_newbie_task_group[v[1]] = v

	setmetatable(v, mt)
end

return t_newbie_task_group
