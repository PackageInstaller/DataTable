-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_reply_100.lua

module("logic.config.t_roguelike_reply_100", package.seeall)

local title = {
	description = 3,
	scriptId = 1,
	successStory = 10,
	type = 5,
	successImage = 11,
	successDescription = 9,
	condition = 4,
	failEffect = 12,
	failDescription = 13,
	failImage = 15,
	testedAttribute = 6,
	failStory = 14,
	id = 2,
	successEffect = 8,
	difficulty = 7
}
local dataList = {
	{
		100,
		10000001,
		"补充体力",
		0,
		4,
		1,
		0,
		{
			40002021
		},
		"你吃下来历不明的三明治，浓郁的酱汁与金黄的鸡蛋为你提供了不少营养，精神焕发。",
		0,
		"sj_zhixian01_start",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10000002,
		"恢复理智",
		0,
		4,
		1,
		0,
		{
			40002022
		},
		"你喝下来历不明的胡萝卜汁，丰厚的胡萝卜素和维生素为你驱散了体内的疲劳，抚慰了你不安的心。",
		0,
		"sj_zhixian01_start",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10000003,
		"获取零钱",
		0,
		4,
		1,
		0,
		{
			40000004
		},
		"你将来历不明的皮夹子装入口袋中，皮夹中的金币或许能在迷雾旅途中能发挥出一些作用。",
		0,
		"sj_zhixian01_start",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10000004,
		"什么都不要",
		0,
		5,
		1,
		0,
		nil,
		"你的警惕心不允许你收下任何来历不明的东西，你在篝火旁歇息一会儿后继续走上了旅途。",
		0,
		"sj_xiangjing",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10000991,
		"补充体力",
		0,
		4,
		1,
		0,
		{
			40002021
		},
		"你吃下来历不明的三明治，浓郁的酱汁与金黄的鸡蛋为你提供了不少营养，精神焕发。",
		0,
		"",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10000992,
		"更多熊熊币",
		0,
		4,
		1,
		0,
		{
			40002004
		},
		"“熊熊币，我有好多好多，好多好多！哈哈哈哈哈！”一抹金色晃过眼底，硬币伴随着大笑声从虚空掉落到你的掌心。",
		0,
		"",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10000993,
		"不需要",
		0,
		5,
		1,
		0,
		nil,
		"“不需要吗？真是遗憾。下次请告诉我你的愿望吧。”",
		0,
		"",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10001011,
		"继续",
		0,
		4,
		1,
		0,
		nil,
		"",
		0,
		"",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10001021,
		"敲门",
		0,
		1,
		4,
		1,
		nil,
		"你的敲门声打断了女孩的哼唱声，等待片刻后，眼前的门开了一道小缝。\r\n“您要找谁？”门缝后传来了怯乏的声音。",
		510010101,
		"sj_xiangjing_win",
		nil,
		"夜晚突兀响起的敲门声也许会让每一个人心生警惕。门后的歌唱声突兀停了下来，无论你如何解释，都再没有回响。",
		0,
		"sj_xiangjing_loss"
	},
	{
		100,
		10001022,
		"离开",
		0,
		4,
		1,
		0,
		nil,
		"",
		0,
		"",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10001031,
		"继续",
		0,
		4,
		1,
		0,
		nil,
		"",
		0,
		"",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10001041,
		"遭遇梦魇！",
		0,
		4,
		1,
		0,
		{
			40009125
		},
		"",
		0,
		"",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10001051,
		"照镜子",
		0,
		2,
		6,
		3,
		nil,
		"镜子映出了你疲劳的脸，在寂静的夜晚中显得有些诡异。但更诡异的是镜子中的你站在一条空旷的马路上，镜中世界没有森林也没有雾。",
		0,
		"",
		{
			40009006
		},
		"不知从何而起的蒸汽笼罩了镜面，你的眼前一片模糊。隔着水雾你看到了镜中呈现出一个惨白的人影，诡异的场面让你大脑有些刺疼。",
		0,
		""
	},
	{
		100,
		10001052,
		"离开",
		0,
		4,
		1,
		0,
		nil,
		"",
		0,
		"",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10001061,
		"对话",
		0,
		4,
		1,
		0,
		nil,
		"女孩无视你的问题，再次蹬起了双腿，在秋千上哼唱起歌谣。",
		510010102,
		"",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10001062,
		"离开",
		0,
		4,
		1,
		0,
		nil,
		"",
		0,
		"",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10001071,
		"准备战斗！",
		0,
		4,
		1,
		0,
		{
			40009126
		},
		"",
		0,
		"",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10001081,
		"倾听",
		0,
		4,
		1,
		0,
		{
			99000000
		},
		"",
		0,
		"",
		nil,
		"",
		0,
		""
	},
	{
		100,
		10099901,
		"……",
		0,
		4,
		1,
		0,
		{
			99000000
		},
		"",
		0,
		"",
		nil,
		"",
		0,
		""
	}
}
local t_roguelike_reply_100 = {}

t_roguelike_reply_100.dataList = dataList

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
	local parent1 = t_roguelike_reply_100[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_roguelike_reply_100[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_roguelike_reply_100
