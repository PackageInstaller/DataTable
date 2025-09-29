-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_end_option.lua

module("logic.config.t_roguelike_end_option", package.seeall)

local title = {
	param = 7,
	desc = 6,
	id = 1,
	type = 5,
	propsId = 3,
	condition = 4,
	win = 2
}
local dataList = {
	{
		1,
		false,
		90001,
		0,
		"RecycleGold",
		"下一次探索本记忆开局获得%s熊熊币",
		"50"
	},
	{
		2,
		false,
		90002,
		40000035,
		"PickCard",
		"组合一张卡牌，下一次探索记忆选择一个人赋予",
		""
	},
	{
		3,
		false,
		90003,
		0,
		"GetItem",
		"获得%s个%s(本周上限%s/%s)",
		"1100013#30"
	},
	{
		4,
		false,
		90004,
		0,
		"Defy",
		"下次通关成功可以双倍获得成功奖励",
		""
	},
	{
		5,
		true,
		90005,
		0,
		"GetItem",
		"获得%s个%s(本周上限%s/%s)",
		"1100013#300"
	}
}
local t_roguelike_end_option = {}

t_roguelike_end_option.dataList = dataList

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
	t_roguelike_end_option[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_end_option
