pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "island_dialogue") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_dialogue"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.island_dialogue = var_0_2
pg = var_0

local var_0_3 = var_0.island_dialogue

var_0_3.all = {
	101,
	102,
	103,
	104,
	105,
	201,
	202,
	301,
	302,
	303,
	401,
	501,
	502
}
pg = var_0_3

local var_0_4 = var_0_3.island_dialogue

var_0_4.get_id_list_by_groupId = {
	{
		101,
		102,
		103,
		104,
		105
	},
	{
		201,
		202
	},
	{
		301,
		302,
		303
	},
	{
		401
	},
	{
		501,
		502
	}
}
pg = var_0_4
pg = var_1

local var_0_5

if not var_1.base then
	var_0_5 = {}
end

var_0_4.base = var_0_5
pg = var_0_4
var_0_4.base.island_dialogue = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_dialogue

	var_1_0[101] = {
		text = "测试测试",
		groupId = 1,
		action = "hello__s2",
		id = 101,
		duration = 2
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_dialogue

	var_1_1[102] = {
		text = "能看见我的气泡吗",
		groupId = 1,
		action = "",
		id = 102,
		duration = 2
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.island_dialogue

	var_1_2[103] = {
		text = "诶",
		groupId = 1,
		action = "",
		id = 103,
		duration = 2
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.island_dialogue

	var_1_3[104] = {
		text = "能看见吗！",
		groupId = 1,
		action = "",
		id = 104,
		duration = 2
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.island_dialogue

	var_1_4[105] = {
		text = "太好了",
		groupId = 1,
		action = "",
		id = 105,
		duration = 2
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.island_dialogue

	var_1_5[201] = {
		text = "种子用完了怎么办呢",
		groupId = 2,
		action = "",
		id = 201,
		duration = 3
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.island_dialogue

	var_1_6[202] = {
		text = "希望指挥官能早点到达",
		groupId = 2,
		action = "",
		id = 202,
		duration = 3
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.island_dialogue

	var_1_7[301] = {
		text = "还有事情要做...",
		groupId = 3,
		action = "",
		id = 301,
		duration = 3
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.island_dialogue

	var_1_8[302] = {
		text = "今天也是辛勤劳动的一天",
		groupId = 3,
		action = "",
		id = 302,
		duration = 3
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.island_dialogue

	var_1_9[303] = {
		text = "晚上吃什么好呢~",
		groupId = 3,
		action = "",
		id = 303,
		duration = 3
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.island_dialogue

	var_1_10[401] = {
		text = "指挥官好~",
		groupId = 4,
		action = "",
		id = 401,
		duration = 2
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.island_dialogue

	var_1_11[501] = {
		text = "在岛屿上，指挥官可以尽情的干自己想干的事情",
		groupId = 5,
		action = "",
		id = 501,
		duration = 2
	}
	pg = var_1_11
	var_1_11.base.island_dialogue[502] = {
		text = "未来还会有很多伙伴们登上岛屿哦",
		groupId = 5,
		action = "",
		id = 502,
		duration = 2
	}

	return
end)()

return
