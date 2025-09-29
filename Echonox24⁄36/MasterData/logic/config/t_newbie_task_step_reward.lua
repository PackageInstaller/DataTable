-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_newbie_task_step_reward.lua

module("logic.config.t_newbie_task_step_reward", package.seeall)

local title = {
	group = 1,
	stepPoint = 2,
	reward = 3
}
local dataList = {
	{
		1,
		8,
		"{1013001:1}"
	},
	{
		1,
		18,
		"{1100002:300}"
	},
	{
		1,
		30,
		"{1001001:2}"
	},
	{
		1,
		46,
		"{1013001:1}"
	},
	{
		1,
		65,
		"{2000055:1}"
	},
	{
		2,
		8,
		"{1001001:2}"
	},
	{
		2,
		16,
		"{1013001:1}"
	},
	{
		2,
		27,
		"{1100002:300}"
	},
	{
		2,
		40,
		"{1013001:1}"
	},
	{
		2,
		55,
		"{1505501:1}"
	}
}
local t_newbie_task_step_reward = {}

t_newbie_task_step_reward.dataList = dataList

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
	local parent1 = t_newbie_task_step_reward[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_newbie_task_step_reward[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_newbie_task_step_reward
