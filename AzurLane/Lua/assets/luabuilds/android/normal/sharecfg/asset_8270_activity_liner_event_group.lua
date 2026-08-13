pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "activity_liner_event_group") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "activity_liner_event_group"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.activity_liner_event_group = var_0_2
pg = var_0

local var_0_3 = var_0.activity_liner_event_group

var_0_3.all = {
	1,
	2,
	3,
	4
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.activity_liner_event_group = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.activity_liner_event_group

	var_1_0[1] = {
		title = "神秘的字条",
		id = 1,
		ids = {
			1,
			2,
			3
		},
		conclusion = {
			"A.证据不足，还需要进一步调查。",
			"B.字条只是一张意外掉落的便条，其余时间均为偶发意外事件，能够用走近科学解释。",
			"C.留下字条的是一个能够使用钢笔的、可超音速移动的巨型八爪鱼。"
		},
		drop_display = {
			1,
			1,
			2000
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.activity_liner_event_group

	var_1_1[2] = {
		title = "美食消失事件",
		id = 2,
		ids = {
			4,
			5,
			6
		},
		conclusion = {
			"A.证据不足，还需要进一步调查。",
			"B.某些深夜看完美食视频后的同伴将这些食物全部偷吃了。",
			"C.洗劫食物的是一个喜欢吃肉不喜欢蔬菜的、能够干扰监控的巨型八爪鱼。"
		},
		drop_display = {
			2,
			15008,
			200
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.activity_liner_event_group

	var_1_2[3] = {
		title = "居住区的幽灵",
		id = 3,
		ids = {
			7,
			8,
			9
		},
		conclusion = {
			"A.所谓事件纯属捕风捉影，无稽之谈。",
			"B.水汽、海雾与幽灵，同时满足以上条件的飓风船团嫌疑最大。",
			"C.幽灵的真身是一个能够隐身漂浮的、能释放出迷雾的巨型八爪鱼。"
		},
		drop_display = {
			2,
			42050,
			10
		}
	}
	pg = var_1_2
	var_1_2.base.activity_liner_event_group[4] = {
		title = "邮轮狂欢夜",
		id = 4,
		ids = {
			10,
			11,
			12
		},
		conclusion = {
			"A.事件，什么事件？今夜无事发生。",
			"B.有一个人的嫌疑正在急剧增加……难道有人假冒了她的身份。",
			"C.制造这一切的是一个喜欢找乐子、能够自由出入任何房间的巨型八爪鱼。"
		},
		drop_display = {
			15,
			606,
			1
		}
	}

	return
end)()

return
