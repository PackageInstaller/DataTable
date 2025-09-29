-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_score_activity.lua

module("logic.config.t_score_activity", package.seeall)

local title = {
	reward = 4,
	score = 3,
	coinId = 5,
	code = 1,
	order = 2
}
local dataList = {
	{
		70001,
		1,
		100,
		2270101,
		1100016
	},
	{
		70001,
		2,
		200,
		2270102,
		1100016
	},
	{
		70001,
		3,
		300,
		2270103,
		1100016
	},
	{
		70001,
		4,
		400,
		2270104,
		1100016
	},
	{
		70001,
		5,
		500,
		2270105,
		1100016
	},
	{
		70001,
		6,
		600,
		2270106,
		1100016
	},
	{
		70001,
		7,
		700,
		2270107,
		1100016
	},
	{
		70001,
		8,
		800,
		2270108,
		1100016
	},
	{
		70001,
		9,
		900,
		2270109,
		1100016
	},
	{
		70001,
		10,
		1000,
		2270110,
		1100016
	},
	{
		70001,
		11,
		1100,
		2270111,
		1100016
	},
	{
		70001,
		12,
		1200,
		2270112,
		1100016
	},
	{
		70001,
		13,
		1300,
		2270113,
		1100016
	},
	{
		70001,
		14,
		1400,
		2270114,
		1100016
	},
	{
		70001,
		15,
		1500,
		2270115,
		1100016
	},
	{
		70001,
		16,
		1600,
		2270116,
		1100016
	},
	{
		70001,
		17,
		1700,
		2270117,
		1100016
	},
	{
		70001,
		18,
		1800,
		2270118,
		1100016
	},
	{
		70001,
		19,
		1900,
		2270119,
		1100016
	},
	{
		70001,
		20,
		2000,
		2270120,
		1100016
	}
}
local t_score_activity = {}

t_score_activity.dataList = dataList

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
	local parent1 = t_score_activity[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_score_activity[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_score_activity
