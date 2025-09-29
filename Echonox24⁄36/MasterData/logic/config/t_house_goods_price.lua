-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_goods_price.lua

module("logic.config.t_house_goods_price", package.seeall)

local title = {
	id = 1,
	name = 2,
	stage = 3
}
local dataList = {
	{
		1,
		"波动型I",
		1
	},
	{
		1,
		"波动型I",
		2
	},
	{
		1,
		"波动型I",
		3
	},
	{
		1,
		"波动型I",
		4
	},
	{
		2,
		"波动型II",
		1
	},
	{
		2,
		"波动型II",
		2
	},
	{
		2,
		"波动型II",
		3
	},
	{
		2,
		"波动型II",
		4
	},
	{
		3,
		"递减型",
		1
	},
	{
		3,
		"递减型",
		2
	},
	{
		3,
		"递减型",
		3
	},
	{
		4,
		"暴涨暴跌型",
		1
	},
	{
		4,
		"暴涨暴跌型",
		2
	},
	{
		4,
		"暴涨暴跌型",
		3
	},
	{
		4,
		"暴涨暴跌型",
		4
	},
	{
		4,
		"暴涨暴跌型",
		5
	},
	{
		4,
		"暴涨暴跌型",
		6
	},
	{
		4,
		"暴涨暴跌型",
		7
	},
	{
		5,
		"四期型",
		1
	},
	{
		5,
		"四期型",
		2
	},
	{
		5,
		"四期型",
		3
	},
	{
		5,
		"四期型",
		4
	}
}
local t_house_goods_price = {}

t_house_goods_price.dataList = dataList

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
	local parent1 = t_house_goods_price[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_house_goods_price[v[1]] = parent1
	end

	parent1[v[3]] = v

	setmetatable(v, mt)
end

return t_house_goods_price
