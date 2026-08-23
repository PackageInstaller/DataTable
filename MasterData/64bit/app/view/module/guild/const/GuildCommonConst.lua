local var_0_0 = {
	LeaveType = {
		MERGE = 4,
		DISSOLVE = 3,
		REMOVE = 2
	},
	commendType = {
		CAN_JOIN = 1,
		ALL = 0
	},
	guildType = {
		SELF_GUILD = 1,
		OTHER_GUILD = 2
	},
	applyState = {
		DIRECT_JOIN = 2,
		CANCEL_APPLY = 1,
		NEED_CONFIRM = 3
	},
	createType = {
		SETTING_GUILD = 2,
		CREATE_GUILD = 1
	},
	joinListType = {
		RECOMMEND_GUILD = 0,
		SEEK_GUILD = 1
	},
	SORT = {
		DOWN = 1,
		UP = 0
	}
}

var_0_0.myApplyMaxNum = 10
var_0_0.isIgnoreVipLimit = true
var_0_0.vipCreateFuncId = 1000001
var_0_0.contributeNum = 3
var_0_0.priceId = 28
var_0_0.openPopParam = {
	REAL_HEIGHT = 150,
	REAL_WIDTH = 350,
	CIRCLE_SIZE = 100,
	DRAW_DES = 10,
	POINT_NUM = 16,
	POINT_NUM_ONE_LINE = 4
}
var_0_0.PACKET_LAYER = {
	GUILD = 1,
	SELF = 3,
	MEMBER = 2
}
var_0_0.polygonPoints = {
	cc.p(16, 113),
	cc.p(38, 117),
	cc.p(58, 127),
	cc.p(52, 110),
	cc.p(55, 95),
	cc.p(52, 82),
	cc.p(74, 94),
	cc.p(88, 95),
	cc.p(101, 101),
	cc.p(95, 89),
	cc.p(107, 78),
	cc.p(104, 68),
	cc.p(120, 65),
	cc.p(112, 47),
	cc.p(119, 49),
	cc.p(113, 31),
	cc.p(119, 28),
	cc.p(121, 19),
	cc.p(153, 58),
	cc.p(145, 41),
	cc.p(155, 43),
	cc.p(154, 38),
	cc.p(216, 101),
	cc.p(297, 205),
	cc.p(321, 267),
	cc.p(297, 266),
	cc.p(293, 282),
	cc.p(274, 275),
	cc.p(269, 297),
	cc.p(252, 295),
	cc.p(236, 281),
	cc.p(249, 314),
	cc.p(232, 305),
	cc.p(230, 318),
	cc.p(172, 267),
	cc.p(187, 287),
	cc.p(193, 321),
	cc.p(154, 288)
}

for iter_0_0, iter_0_1 in ipairs(var_0_0.polygonPoints) do
	iter_0_1.x = iter_0_1.x / 2
	iter_0_1.y = iter_0_1.y / 2
end

return var_0_0
