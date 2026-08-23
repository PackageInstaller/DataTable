return {
	UPDATE_TIME_SCHEDULER = 1,
	PASS_CARD_REWARD_STATE = {
		NOT_FINISH = 2,
		CAN_REWARD = 1,
		NOT_START = 0,
		GOT = 3,
		TASK_NOT_START = 4
	},
	TASK_REWARD_STATE = {
		NOT_FINISH = 1,
		CAN_REWARD = 2,
		NOT_START = 0,
		GOT = 3,
		TASK_NOT_START = 4
	},
	TASK_TYPE = {
		ACHIEVEMENT_TASK = 1,
		DAILY_TASK = 2
	},
	PASS_CARE_PAY_STATE = {
		UN_ACTIVE = 0,
		ALL_BUY = 2,
		ACTIVE = 1
	},
	ACTIVITY_TYPE = {
		PRECIOUS = 1,
		WITCH = 3,
		UNITETOKEN = 2
	},
	hexToRgb = function(self)
		self = self:gsub("#", "")

		return tonumber("0x" .. self:sub(1, 2)), tonumber("0x" .. self:sub(3, 4)), tonumber("0x" .. self:sub(5, 6))
	end
}
