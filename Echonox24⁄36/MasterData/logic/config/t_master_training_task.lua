-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_master_training_task.lua

module("logic.config.t_master_training_task", package.seeall)

local title = {
	param = 4,
	priority = 7,
	reward = 5,
	jump = 6,
	id = 1,
	text = 2,
	content = 3,
	isOnline = 8
}
local dataList = {
	{
		90001001,
		"通关【稳定】\n主线1.17",
		102,
		"110112",
		"{1001001:20}",
		"10500001",
		99,
		1
	},
	{
		90001002,
		"通关红雾区域\n切尔纳伯格02",
		102,
		"132102",
		"{2803002:1}",
		"12000001",
		98,
		1
	},
	{
		90001003,
		"通关梦境档案\n【罪与罚】1次",
		301,
		"1#101",
		"{1001002:30}",
		"30001000",
		97,
		1
	},
	{
		90001004,
		"通关【异常】\n主线1.8",
		102,
		"110138",
		"{1001001:50}",
		"10500002",
		96,
		1
	}
}
local t_master_training_task = {}

t_master_training_task.dataList = dataList

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
	t_master_training_task[v[1]] = v

	setmetatable(v, mt)
end

return t_master_training_task
