-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_mall_showbubble.lua

module("logic.config.t_mall_showbubble", package.seeall)

local title = {
	factor = 2,
	animationName = 3,
	code = 1,
	content = 4,
	voice = 5
}
local dataList = {
	{
		1000001,
		1,
		"idle",
		"你完成任务了 好厉害哟",
		"gacha_bell"
	},
	{
		1000002,
		2,
		"idle",
		"你杵在这里啥也不干干嘛",
		"gacha_bell"
	},
	{
		1000003,
		3,
		"idle",
		"呀主管，好久不见，进来想买点什么补给1？",
		""
	},
	{
		1000004,
		4,
		"idle",
		"呀主管，好久不见，进来想买点什么补给2？",
		"gacha_bell"
	},
	{
		1000005,
		1,
		"idle",
		"呀主管，好久不见，进来想买点什么补给3？",
		""
	},
	{
		1000006,
		5,
		"idle",
		"",
		""
	}
}
local t_mall_showbubble = {}

t_mall_showbubble.dataList = dataList

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
	t_mall_showbubble[v[1]] = v

	setmetatable(v, mt)
end

return t_mall_showbubble
