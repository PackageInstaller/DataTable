-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_item_protomer.lua

module("logic.config.t_item_protomer", package.seeall)

local title = {
	name = 2,
	quality = 5,
	useDesc = 10,
	type = 3,
	getWays = 8,
	priority = 11,
	repeatItem = 13,
	desc = 9,
	subType = 4,
	model = 7,
	isShowBag = 12,
	id = 1,
	icon = 6
}
local dataList = {
	{
		1901001,
		"厄运预告",
		19,
		0,
		5,
		"1004033",
		"",
		"",
		"",
		"解锁基地新的异化物",
		0,
		0,
		"{1100003:1000}"
	},
	{
		1901002,
		"原体2",
		19,
		0,
		5,
		"1004033",
		"",
		"",
		"",
		"解锁基地新的异化物",
		0,
		0,
		"{1100003:1000}"
	},
	{
		1901003,
		"原体3",
		19,
		0,
		5,
		"1004033",
		"",
		"",
		"",
		"解锁基地新的异化物",
		0,
		0,
		"{1100003:1000}"
	},
	{
		1901004,
		"原体4",
		19,
		0,
		5,
		"1004033",
		"",
		"",
		"",
		"解锁基地新的异化物",
		0,
		0,
		"{1100003:1000}"
	},
	{
		1901005,
		"原体5",
		19,
		0,
		5,
		"1004033",
		"",
		"",
		"",
		"解锁基地新的异化物",
		0,
		0,
		"{1100003:1000}"
	},
	{
		1901006,
		"原体6",
		19,
		0,
		5,
		"1004033",
		"",
		"",
		"",
		"解锁基地新的异化物",
		0,
		0,
		"{1100003:1000}"
	},
	{
		1901007,
		"原体7",
		19,
		0,
		5,
		"1004033",
		"",
		"",
		"",
		"解锁基地新的异化物",
		0,
		0,
		"{1100003:1000}"
	}
}
local t_item_protomer = {}

t_item_protomer.dataList = dataList

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
	t_item_protomer[v[1]] = v

	setmetatable(v, mt)
end

return t_item_protomer
