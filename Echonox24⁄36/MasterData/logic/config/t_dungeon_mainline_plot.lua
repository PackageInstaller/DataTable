-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dungeon_mainline_plot.lua

module("logic.config.t_dungeon_mainline_plot", package.seeall)

local title = {
	plotBeforeBattle = 4,
	name = 2,
	imgName = 6,
	type = 5,
	index = 3,
	firstPassReward = 9,
	desc = 8,
	imgbigName = 7,
	id = 1
}
local dataList = {
	{
		1101061,
		"求救声",
		"1.8",
		1010601,
		1,
		"instance_chapter01_drama01",
		"instance_story_001",
		"庞大的信息流，所有过去与未来都将汇聚于此，走向一个必然的末路。",
		1001001
	},
	{
		1101111,
		"访客",
		"2.5",
		1011101,
		1,
		"instance_chapter01_drama02",
		"instance_story_002",
		"雪中的歌声，误入密室的访客，新的故事。",
		1001001
	},
	{
		1101171,
		"朱庇特",
		"2.11",
		1011701,
		1,
		"instance_chapter01_drama03",
		"instance_story_003",
		"命运女神已经开始织网，将所有事件都指向一个结果。",
		1001001
	},
	{
		1101181,
		"休憩时光",
		"2.12",
		1011801,
		1,
		"instance_chapter01_drama01",
		"instance_story_001",
		"无人知晓，但是我会铭记。",
		1001001
	},
	{
		1201031,
		"密室挑战",
		"A-3",
		2010105,
		1,
		"instance_chapter01_drama04",
		"instance_story_004",
		"在这一刻，任务开始。",
		1001001
	},
	{
		1102011,
		"症候群",
		"3.1",
		1020101,
		1,
		"instance_chapter02_drama01",
		"instance_story_005",
		"知觉障碍、强迫动作、严重焦虑、情绪失控……沉沦的人被折断翅膀，雪原的阳光炙烤希望。",
		1001001
	},
	{
		1102051,
		"鸟雀",
		"3.5",
		1020501,
		1,
		"instance_chapter02_drama02",
		"instance_story_006",
		"有些饲养者，并不期待它开口歌唱，只是想用牢笼束缚鸟雀，永远的，没有尽头的。",
		1001001
	},
	{
		1102081,
		"留言",
		"3.8",
		1020801,
		1,
		"instance_chapter02_drama03",
		"instance_story_007",
		"不需要话语温存，不需要祷告实现，一点点音讯，就能抚慰尚存于世的人。",
		1001001
	},
	{
		1102151,
		"棋盘",
		"3.15",
		1021501,
		1,
		"instance_chapter02_drama04",
		"instance_story_008",
		"棋子自认为摆脱了控制，殊不知步入的是下一个棋局。",
		1001001
	},
	{
		1202031,
		"深陷",
		"A-3",
		2020105,
		1,
		"instance_chapter02_drama05",
		"instance_story_009",
		"屠龙者终成恶龙。",
		1001001
	},
	{
		1103011,
		"4.1",
		"4.1",
		1030101,
		1,
		"instance_chapter02_drama05",
		"instance_story_009",
		"【敬请期待】",
		1001001
	},
	{
		1103051,
		"4.5",
		"4.5",
		1030501,
		1,
		"instance_chapter02_drama05",
		"instance_story_009",
		"【敬请期待】",
		1001001
	},
	{
		1103071,
		"4.7",
		"4.7",
		1030701,
		1,
		"instance_chapter02_drama05",
		"instance_story_009",
		"【敬请期待】",
		1001001
	},
	{
		1103181,
		"4.18",
		"4.18",
		1031801,
		1,
		"instance_chapter02_drama05",
		"instance_story_009",
		"【敬请期待】",
		1001001
	}
}
local t_dungeon_mainline_plot = {}

t_dungeon_mainline_plot.dataList = dataList

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
	t_dungeon_mainline_plot[v[1]] = v

	setmetatable(v, mt)
end

return t_dungeon_mainline_plot
