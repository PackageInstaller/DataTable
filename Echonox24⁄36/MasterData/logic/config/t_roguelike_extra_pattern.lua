-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_extra_pattern.lua

module("logic.config.t_roguelike_extra_pattern", package.seeall)

local title = {
	matchDice = 4,
	effect = 3,
	name = 2,
	id = 1,
	desc = 5
}
local dataList = {
	{
		111,
		"成功面1",
		0,
		1,
		""
	},
	{
		112,
		"成功面2",
		0,
		2,
		""
	},
	{
		113,
		"成功面3",
		0,
		3,
		""
	},
	{
		114,
		"成功面4",
		0,
		4,
		""
	},
	{
		115,
		"成功面5",
		0,
		5,
		""
	},
	{
		116,
		"成功面6",
		0,
		6,
		""
	},
	{
		121,
		"流血面1",
		81000001,
		1,
		""
	},
	{
		122,
		"流血面2",
		81000002,
		2,
		""
	},
	{
		123,
		"流血面3",
		81000003,
		3,
		""
	},
	{
		124,
		"流血面4",
		81000004,
		4,
		""
	},
	{
		125,
		"流血面5",
		81000005,
		5,
		""
	},
	{
		126,
		"流血面6",
		81000006,
		6,
		""
	},
	{
		131,
		"恍惚面1",
		81000007,
		1,
		""
	},
	{
		132,
		"恍惚面2",
		81000008,
		2,
		""
	},
	{
		133,
		"恍惚面3",
		81000009,
		3,
		""
	},
	{
		134,
		"恍惚面4",
		81000010,
		4,
		""
	},
	{
		135,
		"恍惚面5",
		81000011,
		5,
		""
	},
	{
		136,
		"恍惚面6",
		81000012,
		6,
		""
	},
	{
		141,
		"献祭面1",
		81000001,
		1,
		""
	},
	{
		142,
		"献祭面2",
		81000002,
		2,
		""
	},
	{
		143,
		"献祭面3",
		81000003,
		3,
		""
	},
	{
		144,
		"献祭面4",
		81000004,
		4,
		""
	},
	{
		145,
		"献祭面5",
		81000005,
		5,
		""
	},
	{
		146,
		"献祭面6",
		81000006,
		6,
		""
	},
	{
		151,
		"蚀智面1",
		81000007,
		1,
		""
	},
	{
		152,
		"蚀智面2",
		81000008,
		2,
		""
	},
	{
		153,
		"蚀智面3",
		81000009,
		3,
		""
	},
	{
		154,
		"蚀智面4",
		81000010,
		4,
		""
	},
	{
		155,
		"蚀智面5",
		81000011,
		5,
		""
	},
	{
		156,
		"蚀智面6",
		81000012,
		6,
		""
	}
}
local t_roguelike_extra_pattern = {}

t_roguelike_extra_pattern.dataList = dataList

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
	t_roguelike_extra_pattern[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_extra_pattern
