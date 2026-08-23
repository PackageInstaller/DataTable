local var_0_0 = {
	SHOW_LOG_QUALITY = 3,
	GET_USER_TIME = 200,
	GRADE = {
		LEADER = 1,
		MEMBER = 9,
		VICE_LEADER = 2
	},
	PARAMETER = {
		SHOW_KNIGHT_MIN = 14,
		CHANGE_NAME_COST = 13,
		DECLARE_CD = 12,
		ANNOUNCE_CD = 11,
		DECLARE_MAX_WORDS = 10,
		ANNOUNCE_MAX_WORDS = 9,
		NAME_LEN_LOWER = 8,
		LOG_NUM = 7,
		CHANGE_ALLIANCE_GET_BOX_TIME = 6,
		CHANGE_ALLIANCE_SEND_BOX_TIME = 5,
		IMPEACH_TIME = 3,
		NAME_LEN = 2,
		CREATE_MIN_LEVEL = 1,
		TRIAL_SHAM_USER_ATTACK_CD = 1010,
		TRIAL_SHAM_USER_MAX = 1009,
		TRIAL_SHAM_USER_MIN = 1008,
		TRIAL_MAP_ID = 1007,
		TRIAL_RANK_LEVEL = 1006,
		TRIAL_WEEKLY_BOX_MAX = 1005,
		TRIAL_DAILY_GIVE_REWARD = 1004,
		TRIAL_DAILY_RECEIVE = 1003,
		TRIAL_DAILY_GIVE = 1002,
		TRIAL_DAILY_CHALLENGE = 1001,
		HONOUR_END = 27,
		HONOUR_START = 26,
		MERGE_AREA_QUIT_ALLIANCE_CD = 25,
		BOX_TIME_MAX = 22,
		QUIT_ALLIANCE_CD = 21,
		BOX_GET_MAX = 20,
		SHOW_BOX_MAX = 19,
		BOX_SEND_END_TIME = 18,
		BOX_SENDS_START_TIME = 17,
		INVITE_GUILD_SHOW_MAX = 16,
		SHOW_KNIGHT_MAX = 15
	},
	NOTICE_TYPE = {
		DECLARE = 0,
		ANNOUNCE = 1
	},
	MODIFY_CONTENT_TYPE = {
		ANNOUNCE = 3,
		DECLARE = 2,
		NAME = 1
	},
	PULL_DOWN_TYPE = {
		POWER = 2,
		MEMBER_NUM = 1,
		TOTAL = 4,
		TODAY = 3
	},
	SORT_TYPE_INDEX = {
		H_TO_L = 0,
		L_TO_H = 1
	},
	GUILD_ORDER = {
		UP = 1,
		DOWN = 0
	},
	TASK_STATE = {
		REWARD = 2,
		FINISH = 1,
		NOT_FINISH = 0
	},
	TASK_TYPE = {
		ACHIEVEMENT = 1,
		DAILY = 2
	},
	INPUT_TEXT_STATE = {
		LONG = 3,
		EMPTY = 2,
		VALID = 1
	}
}

var_0_0.ENTER_BTN = {
	rankBtn = {
		buildId = g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE_RANK,
		moduleEnter = g.view.entrance.ALLIANCE_RANK
	},
	battleBtn = {
		buildId = g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE_TRIAL,
		moduleEnter = g.view.entrance.ALLIANCE_TRIAL
	},
	honorBtn = {
		buildId = g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE_HONOR,
		moduleEnter = g.view.entrance.ALLIANCE_HONOR,
		enterCheck = function()
			local var_1_0 = g.core.common.ServerTime:secondsFromToday()

			if var_1_0 < g.core.model.User.allianceData:getParams(var_0_0.PARAMETER.HONOUR_START) * 3600 then
				g.core.module.ModuleManager:tip(g.core.lang:get(428613))

				return false
			end

			if var_1_0 >= g.core.model.User.allianceData:getParams(var_0_0.PARAMETER.HONOUR_END) * 3600 then
				g.core.module.ModuleManager:tip(g.core.lang:get(428613))

				return false
			end

			return true
		end
	},
	hallBtn = {
		buildId = g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE_HALL,
		moduleEnter = g.view.entrance.ALLIANCE_HALL
	},
	taskBtn = {
		buildId = g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE_TASK,
		moduleEnter = g.view.entrance.ALLIANCE_TASK
	},
	shopBtn = {
		buildId = g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE_SHOP,
		moduleEnter = g.view.entrance.SHOP,
		moduleParams = {
			tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
			shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.ALLIANCE
		}
	}
}
var_0_0.NOTICE_STATE = {
	ENTER = 1,
	QUIT = 0
}
var_0_0.HONOUR = {
	COLOR_NUM = 5
}
var_0_0.TRIAL = {
	JSON_NAME = "alliance_trial.json",
	BOX_TYPE1 = 1,
	BOX_TYPE0 = 0,
	BOX_TYPE2 = 2,
	SHAM_USER_B = "sham_user_b",
	SHAM_USER_A = "sham_user_a"
}

return var_0_0
