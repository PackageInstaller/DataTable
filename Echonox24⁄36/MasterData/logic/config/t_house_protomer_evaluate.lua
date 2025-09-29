-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_protomer_evaluate.lua

module("logic.config.t_house_protomer_evaluate", package.seeall)

local title = {
	code = 1,
	a = 4,
	key = 2,
	c = 6,
	s = 3,
	b = 5
}
local dataList = {
	{
		101,
		25,
		80,
		10,
		5,
		5
	},
	{
		101,
		15,
		20,
		60,
		10,
		10
	},
	{
		101,
		10,
		10,
		20,
		60,
		10
	},
	{
		101,
		0,
		1,
		9,
		30,
		60
	},
	{
		102,
		15,
		80,
		10,
		5,
		5
	},
	{
		102,
		10,
		20,
		60,
		10,
		10
	},
	{
		102,
		5,
		10,
		20,
		60,
		10
	},
	{
		102,
		0,
		1,
		9,
		30,
		60
	},
	{
		103,
		10,
		80,
		10,
		5,
		5
	},
	{
		103,
		5,
		20,
		60,
		10,
		10
	},
	{
		103,
		1,
		10,
		20,
		60,
		10
	},
	{
		103,
		0,
		1,
		9,
		30,
		60
	}
}
local t_house_protomer_evaluate = {}

t_house_protomer_evaluate.dataList = dataList

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
	local parent1 = t_house_protomer_evaluate[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_house_protomer_evaluate[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_house_protomer_evaluate
