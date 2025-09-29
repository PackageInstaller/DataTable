-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_item_chamber_clue.lua

module("logic.config.t_item_chamber_clue", package.seeall)

local title = {
	name = 2,
	quality = 6,
	useDesc = 7,
	type = 4,
	getWays = 9,
	light = 13,
	entry = 12,
	desc = 8,
	dungeonType = 11,
	subType = 5,
	isShowBag = 10,
	id = 1,
	icon = 3
}
local dataList = {
	{
		3000001,
		"标准体征盘",
		"disk_default",
		30,
		0,
		4,
		"维持理智水平，避免守秘人在密室时间中因理智过低而失控",
		"面对怪物的关键，是不让自己成为怪物。",
		nil,
		0,
		nil,
		{
			"10000#1"
		},
		"#ffffff"
	},
	{
		3010001,
		"超感官知觉-Ⅰ",
		"disk_perception",
		30,
		0,
		4,
		"可提升密室时间中的行动收益，但请注意同时出现的异常现象",
		"仔细听，那是年轮生成的预兆，水流逆行的频率，乌云坠落的声音。",
		nil,
		0,
		{
			1
		},
		{
			"30001#1",
			"70001#1",
			"60001#1"
		},
		"#ef6625"
	},
	{
		3010002,
		"隐秘高压-Ⅰ",
		"disk_pressure",
		30,
		0,
		4,
		"可提升密室时间中的行动收益，但请注意同时出现的异常现象",
		"红雾是标记，是警示，但要记住：决不能让它们成为这里的主人。",
		nil,
		0,
		{
			9
		},
		{
			"20000#1",
			"70002#1",
			"60002#1"
		},
		"#bd0c07"
	},
	{
		3010003,
		"大三角之底-Ⅰ",
		"disk_warp",
		30,
		0,
		4,
		"可提升密室时间中的行动收益，但请注意同时出现的异常现象",
		"在浓雾背后，没有幸存者……所以，那是什么？",
		nil,
		0,
		{
			4
		},
		{
			"20001#1",
			"70003#1",
			"60003#1"
		},
		"#6730a6"
	},
	{
		3010004,
		"巴甫洛夫刺激-Ⅰ",
		"disk_stimulate",
		30,
		0,
		4,
		"可提升密室时间中的行动收益，但请注意同时出现的异常现象",
		"被驯服的怪物，会从疼痛中获得兴奋。",
		nil,
		0,
		{
			7
		},
		{
			"40001#1",
			"70004#1",
			"60004#1"
		},
		"#237d55"
	},
	{
		3010005,
		"月球效应-Ⅰ",
		"disk_fullmoon",
		30,
		0,
		4,
		"可提升密室时间中的行动收益，但请注意同时出现的异常现象",
		"如果失去方向，不要挣扎，今夜是满月。",
		nil,
		0,
		{
			13,
			14,
			15
		},
		{
			"30002#1",
			"70005#1",
			"60005#1"
		},
		"#daca68"
	},
	{
		3010006,
		"管制失序-Ⅰ",
		"disk_eclipse",
		30,
		0,
		4,
		"可提升密室时间中的行动收益，但请注意同时出现的异常现象",
		"月已不再明亮，虫群开始肆虐，将此处蛀得百孔千疮。",
		nil,
		0,
		{
			8
		},
		{
			"50001#1",
			"70006#1",
			"60006#1"
		},
		"#132896"
	}
}
local t_item_chamber_clue = {}

t_item_chamber_clue.dataList = dataList

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
	t_item_chamber_clue[v[1]] = v

	setmetatable(v, mt)
end

return t_item_chamber_clue
