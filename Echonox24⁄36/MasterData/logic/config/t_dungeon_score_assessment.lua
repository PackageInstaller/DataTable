-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dungeon_score_assessment.lua

module("logic.config.t_dungeon_score_assessment", package.seeall)

local title = {
	scoreRange = 3,
	showText = 4,
	index = 2,
	color = 5,
	group = 1
}
local dataList = {
	{
		101,
		1,
		{
			0,
			0
		},
		"情报不明",
		"#FFFFFF"
	},
	{
		101,
		2,
		{
			0,
			749
		},
		"灾厄",
		"#FF3E48"
	},
	{
		101,
		3,
		{
			750,
			849
		},
		"危险",
		"#C99448"
	},
	{
		101,
		4,
		{
			850,
			949
		},
		"棘手",
		"#FFD996"
	},
	{
		101,
		5,
		{
			950,
			1199
		},
		"稳定",
		"#548F71"
	},
	{
		101,
		6,
		{
			1200,
			"max"
		},
		"安全",
		"#307A9B"
	},
	{
		102,
		1,
		{
			0,
			0
		},
		"情报不明",
		"#FFFFFF"
	},
	{
		102,
		2,
		{
			0,
			749
		},
		"灾厄",
		"#FF3E48"
	},
	{
		102,
		3,
		{
			750,
			849
		},
		"危险",
		"#C99448"
	},
	{
		102,
		4,
		{
			850,
			949
		},
		"棘手",
		"#FFD996"
	},
	{
		102,
		5,
		{
			950,
			1199
		},
		"稳定",
		"#548F71"
	},
	{
		102,
		6,
		{
			1200,
			"max"
		},
		"安全",
		"#307A9B"
	}
}
local t_dungeon_score_assessment = {}

t_dungeon_score_assessment.dataList = dataList

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
	local parent1 = t_dungeon_score_assessment[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_dungeon_score_assessment[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_dungeon_score_assessment
