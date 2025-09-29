-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_rank.lua

module("logic.config.t_rank", package.seeall)

local title = {
	online = 5,
	name = 2,
	totalRankCount = 8,
	tabName = 4,
	id = 1,
	showCount = 7,
	logicType = 3,
	lastRank = 6
}
local dataList = {
	{
		10001,
		"守密人",
		2,
		"收集率",
		1,
		0,
		100,
		10000
	},
	{
		10002,
		"残响",
		2,
		"收集率",
		1,
		0,
		100,
		10000
	},
	{
		10003,
		"职级",
		3,
		"职级",
		1,
		0,
		100,
		10000
	},
	{
		10004,
		"月之暗面",
		4,
		"月之暗面",
		1,
		0,
		100,
		10000
	},
	{
		10005,
		"空气工坊",
		5,
		"空气工坊",
		1,
		0,
		100,
		10000
	},
	{
		10006,
		"普通",
		6,
		"主线",
		1,
		0,
		100,
		10000
	},
	{
		10007,
		"困难",
		6,
		"主线",
		1,
		0,
		100,
		10000
	},
	{
		10008,
		"足球",
		1,
		"足球",
		1,
		0,
		100,
		10000
	},
	{
		10009,
		"上一赛季-空气工坊",
		5,
		"",
		1,
		1,
		100,
		10000
	},
	{
		10010,
		"空气工坊无尽模式",
		0,
		"",
		1,
		0,
		100,
		10000
	},
	{
		10011,
		"上一赛季-月之暗面",
		4,
		"月之暗面",
		1,
		1,
		100,
		10000
	}
}
local t_rank = {}

t_rank.dataList = dataList

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
	t_rank[v[1]] = v

	setmetatable(v, mt)
end

return t_rank
