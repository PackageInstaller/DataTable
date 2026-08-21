local var_0_0 = {
	DATA_TYPE = {
		TASK = 3,
		MOMENTS = 2,
		CHAT = 1
	},
	MSG_TYPE = {
		TEXT = 1,
		NARRATE = 4,
		AUDIO = 3,
		RECALL = 6,
		STICKER = 5,
		IMAGE = 2
	},
	MSG_STATE = {
		UNREAD = "unRead",
		READED = "readed"
	},
	TAB = {
		TASK = "task",
		MOMENTS = "moments",
		CHAT = "chat"
	},
	CONTACT_SORT = {
		NO_REMIND = 2,
		FINISHED = 1,
		UNFINISHED = 3
	},
	TRIGGER_TYPE = {
		FAVOR = 2,
		FESTIVAL = 3,
		DAILY = 1
	}
}

var_0_0.NO_REMIND_LIMIT = {
	[var_0_0.TRIGGER_TYPE.FAVOR] = 3,
	[var_0_0.TRIGGER_TYPE.FESTIVAL] = 1
}

return var_0_0
