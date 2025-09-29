-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_item_roguelike_equip.lua

module("logic.config.t_item_roguelike_equip", package.seeall)

local title = {
	rejectedScripts = 11,
	quality = 6,
	useDesc = 7,
	type = 4,
	getWays = 12,
	name = 2,
	priority = 9,
	desc = 8,
	repeatItem = 13,
	subType = 5,
	isShowBag = 10,
	id = 1,
	icon = 3
}
local dataList = {
	{
		1800001,
		"回旋陀螺",
		"5001001",
		18,
		1,
		3,
		"在记忆世界中可用以维持理智。强化后还可以通过维持高理智来帮助守秘人探索记忆",
		"回旋的陀螺能指引你进入更深层梦境。",
		0,
		0,
		nil,
		"",
		"{1100003:100}"
	},
	{
		1800002,
		"抉择药丸",
		"5001002",
		18,
		1,
		3,
		"在记忆世界中可用以治疗伤口。强化后还可以通过维持高生命值来帮助守秘人探索记忆",
		"请谨慎对待每一个选择。",
		0,
		0,
		nil,
		"",
		"{1100003:100}"
	},
	{
		1800003,
		"蝠鲼标本",
		"5001003",
		18,
		1,
		4,
		"在记忆世界中能高效地维持理智，还能让携带者游刃有余地应对突发事件",
		"你可以在审视中回归过去，或前往未来。",
		0,
		0,
		nil,
		"",
		"{1100003:100}"
	},
	{
		1800004,
		"怪诞走廊",
		"5001004",
		18,
		1,
		4,
		"在记忆世界中能高效地维持理智，还能让记忆中的贩卖机价格大打折扣",
		"沿着弯曲的走廊走向未知的路。",
		0,
		0,
		nil,
		"",
		"{1100003:100}"
	},
	{
		1800005,
		"蝴蝶匣子",
		"5001005",
		18,
		1,
		4,
		"在记忆世界中能高效地维持理智，还能让记忆中的幸运屋游玩价格大打折扣",
		"被钉在匣子上的幼虫能否破蛹而出？",
		0,
		0,
		nil,
		"",
		"{1100003:100}"
	},
	{
		1800006,
		"恋人的眼眸",
		"5001006",
		18,
		1,
		4,
		"在记忆世界中能高效地维持理智，还能提高携带者的力量",
		"落寞的眼眸眺向窗外，恋人今夜能否回家？",
		0,
		0,
		nil,
		"",
		"{1100003:100}"
	}
}
local t_item_roguelike_equip = {}

t_item_roguelike_equip.dataList = dataList

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
	t_item_roguelike_equip[v[1]] = v

	setmetatable(v, mt)
end

return t_item_roguelike_equip
