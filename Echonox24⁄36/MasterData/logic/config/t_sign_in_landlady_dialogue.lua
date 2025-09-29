-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_sign_in_landlady_dialogue.lua

module("logic.config.t_sign_in_landlady_dialogue", package.seeall)

local title = {
	dialogue = 4,
	voice = 3,
	weight = 2,
	formula = 1
}
local dataList = {
	{
		1,
		10,
		"gacha_backsword",
		"你好"
	},
	{
		2,
		10,
		"gacha_bell",
		"早上好"
	},
	{
		3,
		10,
		"gacha_cheers",
		"中午好"
	},
	{
		4,
		10,
		"gacha_crow",
		"晚上好"
	},
	{
		5,
		10,
		"gacha_kids",
		"该喝茶啦"
	},
	{
		6,
		10,
		"gacha_march",
		"午饭吃什么好呢"
	},
	{
		7,
		10,
		"gacha_policewhistle",
		"最近总是下雨"
	},
	{
		8,
		10,
		"gacha_symphony",
		"天气好热呀"
	}
}
local t_sign_in_landlady_dialogue = {}

t_sign_in_landlady_dialogue.dataList = dataList

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
	t_sign_in_landlady_dialogue[v[1]] = v

	setmetatable(v, mt)
end

return t_sign_in_landlady_dialogue
