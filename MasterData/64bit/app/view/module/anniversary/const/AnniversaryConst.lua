return {
	SCORE_TYPE = 1,
	FLOOR_AWARD_NUM = 3,
	JIGSAW_TOP_ORDER = 100,
	JIGSAW_EFF_LIMIT_TIME = 100,
	JIGSAW_MOVE_SPEED = 0.5,
	JIGSAW_LINE_DISTANCE = 950,
	JIGSAW_LEN_NUM = 8,
	JIGSAW_GROUP_NUM = 6,
	FIRE_AWARD_STILL_TIME = 1.5,
	PRESS_INTERVAL = 0.2,
	FIRE_UP_OFFX = 550,
	FIRE_DOWN_OFFX = 650,
	FIRE_NUM = 10,
	FIRE_SPINE_ANIM_NUM = 10,
	SCORE_VALUE = 120,
	STAGE = {
		NOT_OPEN = 3,
		SHOW = 2,
		GAME = 1
	},
	TASK_TYPE = {
		DAILY = 2,
		SEASON = 1
	},
	TASK_STATE = {
		NOT_FINISH = 0,
		REWARD = 2,
		FINISH = 1
	},
	FLOOR_AWARD = {
		NOT_GET = 0,
		DONE = 2,
		CAN_GET = 1
	},
	CUMULATIVE_AWARD = {
		NOT_GET = 0,
		DONE = 2,
		CAN_GET = 1
	},
	JIGSAW_DRAW_TP = {
		ONCE = 1,
		KEEP = 2
	},
	JIGSAW_RANDOM = {
		MIN = 5,
		MAX = 10
	},
	SHARE_INVITE = {
		FRIEND = 58,
		GUILD = 57,
		CROSS = 56
	},
	hexToRgb = function(self)
		self = self:gsub("#", "")

		return cc.c3b(tonumber("0x" .. self:sub(1, 2)), tonumber("0x" .. self:sub(3, 4)), (tonumber("0x" .. self:sub(5, 6))))
	end
}
