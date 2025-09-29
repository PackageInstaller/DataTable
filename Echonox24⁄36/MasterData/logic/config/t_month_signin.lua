-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_month_signin.lua

module("logic.config.t_month_signin", package.seeall)

local title = {
	reward = 2,
	isSpecial = 3,
	day = 1
}
local dataList = {
	{
		1,
		1700101,
		0
	},
	{
		2,
		1700102,
		0
	},
	{
		3,
		1700103,
		0
	},
	{
		4,
		1700104,
		0
	},
	{
		5,
		1700105,
		0
	},
	{
		6,
		1700106,
		0
	},
	{
		7,
		1700107,
		1
	},
	{
		8,
		1700108,
		0
	},
	{
		9,
		1700109,
		0
	},
	{
		10,
		1700110,
		0
	},
	{
		11,
		1700111,
		0
	},
	{
		12,
		1700112,
		0
	},
	{
		13,
		1700113,
		0
	},
	{
		14,
		1700114,
		1
	},
	{
		15,
		1700115,
		0
	},
	{
		16,
		1700116,
		0
	},
	{
		17,
		1700117,
		0
	},
	{
		18,
		1700118,
		0
	},
	{
		19,
		1700119,
		0
	},
	{
		20,
		1700120,
		0
	},
	{
		21,
		1700121,
		1
	},
	{
		22,
		1700122,
		0
	},
	{
		23,
		1700123,
		0
	},
	{
		24,
		1700124,
		0
	},
	{
		25,
		1700125,
		0
	},
	{
		26,
		1700126,
		0
	},
	{
		27,
		1700127,
		0
	},
	{
		28,
		1700128,
		1
	},
	{
		29,
		1700129,
		0
	},
	{
		30,
		1700130,
		0
	},
	{
		31,
		1700131,
		0
	}
}
local t_month_signin = {}

t_month_signin.dataList = dataList

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
	t_month_signin[v[1]] = v

	setmetatable(v, mt)
end

return t_month_signin
