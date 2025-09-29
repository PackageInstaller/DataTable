-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_player_create_plot.lua

module("logic.config.t_player_create_plot", package.seeall)

local title = {
	period = 2,
	choice2 = 6,
	choice1 = 5,
	type = 3,
	id = 1,
	choice3 = 7,
	choice4 = 8,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		1,
		"记忆构筑的灵魂之海，面具们在嗤笑，发出荒诞的质问",
		"",
		"",
		"",
		""
	},
	{
		2,
		1,
		1,
		"如果破坏规则可以获得更高的利益，你会？",
		"",
		"",
		"",
		""
	},
	{
		3,
		1,
		2,
		"",
		"遵守规则是我的人生信条",
		"我只遵守我认同的规则",
		"规则的存在意义就是被破坏",
		"我无法确定……"
	},
	{
		4,
		2,
		1,
		"现在，这里有一个谎言，它意味着？",
		"",
		"",
		"",
		""
	},
	{
		5,
		2,
		2,
		"",
		"一个灵魂将会备受煎熬",
		"它存在是因为有人渴求它",
		"好戏开场，不见不散",
		"我无法确定……"
	}
}
local t_player_create_plot = {}

t_player_create_plot.dataList = dataList

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
	t_player_create_plot[v[1]] = v

	setmetatable(v, mt)
end

return t_player_create_plot
