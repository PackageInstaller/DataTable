-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_live_room.lua

module("logic.config.t_house_live_room", package.seeall)

local title = {
	bgIcon = 7,
	name = 2,
	priority = 3,
	type = 1,
	hint = 10,
	desc = 6,
	atmosphere = 9,
	heroCount = 5,
	size = 4,
	ftCount = 8
}
local dataList = {
	{
		0,
		"默认设施",
		0,
		0,
		0,
		"默认设施",
		"room_template_0000",
		5,
		0,
		"默认设施"
	},
	{
		1,
		"宿舍",
		8,
		0,
		4,
		"方便实用的空间，可满足多人生活起居需求",
		"room_template_0000",
		5,
		0,
		"提供基础氛围值加成"
	},
	{
		2,
		"单人房",
		6,
		0,
		1,
		"置身于专属空间，使身心得到最大放松",
		"room_template_0005",
		5,
		0,
		"提供基础氛围值加成"
	},
	{
		3,
		"娱乐空间",
		5,
		0,
		0,
		"这里不提供知识，请专注玩乐与解压",
		"room_template_0006",
		5,
		4,
		"提供娱乐值加成"
	},
	{
		4,
		"生活空间",
		4,
		0,
		0,
		"美食永远是最好的犒劳方式",
		"room_template_0003",
		5,
		6,
		"提供生活值加成"
	},
	{
		5,
		"科技中心",
		3,
		0,
		0,
		"每个算式都自有其含义，每次研究都是发展的根基",
		"room_template_0001",
		5,
		3,
		"提供科技值加成"
	},
	{
		6,
		"生态馆",
		2,
		1,
		0,
		"自然或非自然的产物会揭示万物更迭的法则",
		"room_template_0004",
		5,
		2,
		"提供生态值加成"
	},
	{
		7,
		"神秘空间",
		1,
		1,
		0,
		"熟知或陌生的物品，必然的和可能的事件",
		"room_template_0002",
		5,
		5,
		"提供灵感值加成"
	}
}
local t_house_live_room = {}

t_house_live_room.dataList = dataList

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
	t_house_live_room[v[1]] = v

	setmetatable(v, mt)
end

return t_house_live_room
