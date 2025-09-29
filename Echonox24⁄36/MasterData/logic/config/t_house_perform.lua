-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_perform.lua

module("logic.config.t_house_perform", package.seeall)

local title = {
	performList = 7,
	weight = 6,
	interrupt = 5,
	breakConditions = 9,
	breakPerformList = 10,
	breakTextList = 11,
	heroIds = 3,
	statusCondition = 4,
	id = 1,
	peopleNum = 2,
	textList = 8
}
local dataList = {
	{
		100000,
		1,
		"",
		"",
		0,
		1,
		"2;0#A#1",
		"",
		"0",
		"",
		""
	},
	{
		100001,
		1,
		"",
		"",
		0,
		1,
		"",
		"",
		"0",
		"",
		""
	}
}
local t_house_perform = {}

for _, v in ipairs(dataList) do
	t_house_perform[v[1]] = v
end

t_house_perform.dataList = dataList

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
	setmetatable(v, mt)
end

return t_house_perform
