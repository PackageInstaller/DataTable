BilliardGameConst = {
	WuluoVehicleSkillMaxLevel = 2,
	StageCount = 4,
	FirstLevelId = 4030104,
	ActiveSkillCount = 3,
	UltimateSkillUnlockStage = 50103,
	PassiveSkillCount = 2,
	RandomUpgradeSkillMaxCount = 4,
	FixedBuffIdList = {
		5004
	},
	MergeBallBuffType = {
		PASSIVE = 1,
		ADVANCE = 3,
		BASIC = 2,
		EFFECT = 5,
		ULTIMATE = 4
	},
	GameType = {
		BALL = 1,
		VEHICLE = 2
	},
	VehicleType = {
		SKILL = 2,
		VEHICLE = 1
	},
	KvType = {
		MERGE_SKILL = 2,
		KILL_MONSTER = 1
	},
	VehicleBallBuffRewardState = {
		CAN_RECEIVE_REWARD = 0,
		RECEIVED = 1
	},
	ChangeSkillType = {
		LEVEL_UP = 2,
		COMBINE = 4,
		ADD = 1,
		MERGE = 5,
		RANDOM_LEVEL_UP = 3
	},
	ChangeSkillOpt = {
		RESET = 2,
		SELECT = 1
	},
	PassStageSkill = {
		FIRSTSELECTLEVELUP = 50103,
		ADDACTIVESKILLCOUNT = 50102,
		ADDREFRESHCOUNT = 50101
	},
	PassStageParams = {
		FIRSTSELECTLEVELUP = 1,
		ADDACTIVESKILLCOUNT = 1,
		ADDREFRESHCOUNT = 3
	},
	ShowPopView = {
		[50101] = {
			1,
			50112
		},
		[50102] = {
			1,
			50113
		},
		[50103] = {
			2,
			{
				4001,
				4002
			}
		}
	},
	HideSelectPopView = {
		[50101] = {
			1
		}
	}
}
BilliardGameEvent = {
	MERGE_PROCESS_FEEDBACK = 14,
	BILLIARD_POP_VIEW_SELECT_HERO = 4,
	BILLIARD_HERO_INFO = 5,
	SINGLE_SKILL_UPGRADE = 17,
	BILLIARD_PLAYER_ROUND_BEGIN = 10,
	BILLIARD_MONSTER_DEAD = 9,
	BILLIARD_CONDITION_FINISH = 7,
	SET_BOTTOM_INFO_GO_ACTIVE = 18,
	UPDATE_VEHICLE_SKILL = 12,
	SET_MERGE_AND_BALL_ACTIVE = 19,
	SET_CLICK_SKILL_ITEM = 20,
	BILLIARD_GAME_ROUND_OVER = 11,
	DRAG_STATE = 21,
	BILLIARD_UPDATE_VIEW = 1,
	MAIN_POP_END = 13,
	BILLIARD_POP_VIEW_REMOVE_HERO = 3,
	BILLIARD_POP_VIEW_EXCHANGE_HERO = 6,
	BILLIARD_POP_VIEW_ADD_HERO = 2,
	BILLIARD_VEHICLE_INJURED = 8,
	MAGNIFY_EFFECT = 16,
	TEST_MERGE_PROCESS = 15
}
