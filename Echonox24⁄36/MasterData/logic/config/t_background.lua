-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_background.lua

module("logic.config.t_background", package.seeall)

local title = {
	name = 2,
	quality = 6,
	repeatItem = 9,
	type = 3,
	getWays = 8,
	priority = 10,
	desc = 7,
	subType = 4,
	isShowBag = 11,
	id = 1,
	icon = 5
}
local dataList = {
	{
		1601001,
		"通用背景",
		16,
		1,
		"1601001",
		3,
		"这是平平无奇的通用背景",
		"",
		"{1100001:100,1100002:500}",
		0,
		0
	},
	{
		1601002,
		"灵感之间",
		16,
		1,
		"1601002",
		4,
		"毁灭，重生，从来都是相伴相生",
		"",
		"{1100001:500,1100002:1000}",
		0,
		0
	},
	{
		1601003,
		"梦境OR现实",
		16,
		1,
		"1601003",
		5,
		"隐秘、背叛、理智、梦境还是现实？",
		"活动[毁灭]获得",
		"{1100001:500,1100002:1000}",
		0,
		0
	}
}
local t_background = {}

t_background.dataList = dataList

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
	t_background[v[1]] = v

	setmetatable(v, mt)
end

return t_background
