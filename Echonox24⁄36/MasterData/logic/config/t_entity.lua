-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_entity.lua

module("logic.config.t_entity", package.seeall)

local title = {
	defense = 13,
	passiveSkills = 10,
	weakHP = 18,
	sanity = 5,
	code = 1,
	trumpSkill = 9,
	career = 4,
	name = 2,
	normalSkill = 7,
	activeSkill = 8,
	yitai_defense = 15,
	attack = 12,
	modelCode = 3,
	weakPosition = 17,
	yitai_attack = 14,
	afflatus = 16,
	hp = 11,
	mobility = 6,
	weakCareer = 19
}
local dataList = {
	{
		1000001,
		"伊卡洛斯",
		100001,
		1,
		1,
		2,
		10001,
		0,
		20004,
		nil,
		150,
		100,
		50,
		100,
		50,
		5,
		nil,
		0,
		0
	},
	{
		1000002,
		"飞鸟",
		100002,
		1,
		1,
		2,
		10002,
		0,
		20001,
		nil,
		600,
		100,
		50,
		100,
		50,
		7,
		nil,
		0,
		0
	},
	{
		1000003,
		"一云",
		100004,
		3,
		1,
		3,
		10003,
		0,
		20002,
		nil,
		600,
		100,
		50,
		100,
		50,
		7,
		nil,
		0,
		0
	},
	{
		1000004,
		"芬里尔",
		100003,
		2,
		1,
		2,
		10004,
		0,
		20003,
		nil,
		150,
		50,
		50,
		120,
		70,
		7,
		nil,
		0,
		0
	},
	{
		2000001,
		"龟小怪",
		200001,
		1,
		1,
		2,
		1001,
		0,
		0,
		nil,
		70,
		100,
		50,
		100,
		50,
		3,
		nil,
		0,
		0
	},
	{
		2000002,
		"机械臂",
		200002,
		1,
		1,
		2,
		1002,
		0,
		0,
		nil,
		70,
		100,
		50,
		100,
		50,
		3,
		nil,
		0,
		0
	},
	{
		2000003,
		"龟boss",
		200003,
		1,
		1,
		1,
		1003,
		0,
		2001,
		nil,
		300,
		100,
		50,
		100,
		50,
		5,
		{
			1,
			1
		},
		100,
		3
	},
	{
		2000004,
		"鸟boss",
		200004,
		1,
		1,
		3,
		1004,
		0,
		2002,
		nil,
		300,
		150,
		20,
		100,
		50,
		5,
		{
			0,
			1
		},
		100,
		2
	}
}
local t_entity = {
	[1000001] = dataList[1],
	[1000002] = dataList[2],
	[1000003] = dataList[3],
	[1000004] = dataList[4],
	[2000001] = dataList[5],
	[2000002] = dataList[6],
	[2000003] = dataList[7],
	[2000004] = dataList[8]
}

t_entity.dataList = dataList

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

return t_entity
