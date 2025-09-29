-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_rogueliketouch.lua

module("logic.config.t_rogueliketouch", package.seeall)

local title = {
	id = 1,
	name = 2,
	plot = 5,
	effectIds = 6,
	prefabName = 3,
	condition = 4
}
local dataList = {
	{
		1,
		"bgScroll/view/sceneBg/interact_element1",
		"run_group_survey_panel_1",
		0,
		0
	},
	{
		2,
		"bgScroll/view/sceneBg/interact_element2",
		"run_group_survey_panel_1",
		0,
		0,
		{
			40000004
		}
	},
	{
		3,
		"bgScroll/view/sceneBg/interact_element3",
		"run_group_survey_panel_1",
		0,
		0
	},
	{
		4,
		"bgScroll/view/sceneBg/interact_element1",
		"run_group_survey_panel_2",
		0,
		5010107
	},
	{
		5,
		"bgScroll/view/sceneBg/interact_element2",
		"run_group_survey_panel_2",
		0,
		5010108
	},
	{
		6,
		"bgScroll/view/sceneBg/interact_element3",
		"run_group_survey_panel_2",
		0,
		5010109,
		{
			60000014
		}
	},
	{
		7,
		"bgScroll/view/sceneBg/interact_element4",
		"run_group_survey_panel_2",
		0,
		5010110
	},
	{
		8,
		"bgScroll/view/sceneBg/interact_element5",
		"run_group_survey_panel_2",
		0,
		5010111
	},
	{
		9,
		"bgScroll/view/sceneBg/interact_element1",
		"run_group_survey_panel_3",
		0,
		5010112
	},
	{
		10,
		"bgScroll/view/sceneBg/interact_element2",
		"run_group_survey_panel_3",
		0,
		5010113
	},
	{
		11,
		"bgScroll/view/sceneBg/interact_element3",
		"run_group_survey_panel_3",
		0,
		5010114
	},
	{
		12,
		"bgScroll/view/sceneBg/interact_element4",
		"run_group_survey_panel_3",
		0,
		5010115
	},
	{
		13,
		"bgScroll/view/sceneBg/interact_element1",
		"run_group_survey_panel_4",
		0,
		5010116
	},
	{
		14,
		"bgScroll/view/sceneBg/interact_element2",
		"run_group_survey_panel_4",
		0,
		5010117
	},
	{
		15,
		"bgScroll/view/sceneBg/interact_element3",
		"run_group_survey_panel_4",
		0,
		5010118
	},
	{
		16,
		"bgScroll/view/sceneBg/interact_element1",
		"run_group_survey_panel_5",
		0,
		5010119
	},
	{
		17,
		"bgScroll/view/sceneBg/interact_element2",
		"run_group_survey_panel_5",
		0,
		5010120
	},
	{
		18,
		"bgScroll/view/sceneBg/interact_element3",
		"run_group_survey_panel_5",
		0,
		5010121
	},
	{
		19,
		"bgScroll/view/sceneBg/interact_element4",
		"run_group_survey_panel_5",
		0,
		5010122,
		{
			60000012
		}
	},
	{
		20,
		"bgScroll/view/sceneBg/interact_element5",
		"run_group_survey_panel_5",
		0,
		5010123,
		{
			60000006
		}
	}
}
local t_rogueliketouch = {}

t_rogueliketouch.dataList = dataList

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
	t_rogueliketouch[v[1]] = v

	setmetatable(v, mt)
end

return t_rogueliketouch
