return {
	UPDATE_TIME_SCHEDULER = 1,
	PASS_CARD_REWARD_STATE = {
		CAN_REWARD = 1,
		NOT_FINISH = 2,
		GOT = 3,
		TASK_NOT_START = 4,
		NOT_START = 0
	},
	TASK_REWARD_STATE = {
		CAN_REWARD = 2,
		NOT_FINISH = 1,
		GOT = 3,
		TASK_NOT_START = 4,
		NOT_START = 0
	},
	TASK_TYPE = {
		DAILY_TASK = 2,
		ACHIEVEMENT_TASK = 1
	},
	PASS_CARE_PAY_STATE = {
		ACTIVE = 1,
		UN_ACTIVE = 0,
		ALL_BUY = 2
	},
	ACTIVITY_TYPE = {
		UNITETOKEN = 2,
		PRECIOUS = 1,
		WITCH = 3
	},
	hexToRgb = function(self)
		self = self:gsub("#", "")

		return tonumber("0x" .. self:sub(1, 2)), tonumber("0x" .. self:sub(3, 4)), tonumber("0x" .. self:sub(5, 6))
	end
}
