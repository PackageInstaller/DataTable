return {
	SCORE_VALUE = 120,
	FLOOR_AWARD_NUM = 3,
	FIRE_UP_OFFX = 550,
	JIGSAW_MOVE_SPEED = 0.5,
	JIGSAW_TOP_ORDER = 100,
	FIRE_SPINE_ANIM_NUM = 10,
	SCORE_TYPE = 1,
	JIGSAW_EFF_LIMIT_TIME = 100,
	PRESS_INTERVAL = 0.2,
	JIGSAW_LEN_NUM = 8,
	JIGSAW_LINE_DISTANCE = 950,
	FIRE_NUM = 10,
	FIRE_DOWN_OFFX = 650,
	FIRE_AWARD_STILL_TIME = 1.5,
	JIGSAW_GROUP_NUM = 6,
	STAGE = {
		NOT_OPEN = 3,
		GAME = 1,
		SHOW = 2
	},
	TASK_TYPE = {
		DAILY = 2,
		SEASON = 1
	},
	TASK_STATE = {
		REWARD = 2,
		FINISH = 1,
		NOT_FINISH = 0
	},
	FLOOR_AWARD = {
		DONE = 2,
		NOT_GET = 0,
		CAN_GET = 1
	},
	CUMULATIVE_AWARD = {
		DONE = 2,
		NOT_GET = 0,
		CAN_GET = 1
	},
	JIGSAW_DRAW_TP = {
		KEEP = 2,
		ONCE = 1
	},
	JIGSAW_RANDOM = {
		MAX = 10,
		MIN = 5
	},
	SHARE_INVITE = {
		CROSS = 56,
		GUILD = 57,
		FRIEND = 58
	},
	hexToRgb = function(self)
		self = self:gsub("#", "")

		return cc.c3b(tonumber("0x" .. self:sub(1, 2)), tonumber("0x" .. self:sub(3, 4)), (tonumber("0x" .. self:sub(5, 6))))
	end
}
