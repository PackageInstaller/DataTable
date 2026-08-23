local var_0_0 = {
	SEASON_RESULT = 3,
	FIGHT = 2,
	DRILL = 1,
	NONE = 0
}
local var_0_1 = {
	WAR_RESULT = 22,
	FIGHTING = 21,
	DEPLOY = 20
}

return {
	PARAM_MAX_SCORE_ID = 6001,
	GROUP_ID = 5002,
	HELP_ID = 131,
	ALL_POSITION_NUM = 16,
	BATTLE_BG_ID = 140,
	CityPos = {
		RIGHT = 2,
		LEFT = 1,
		DOWN = 0
	},
	GROUP_INDEX = {
		ELITE = 3,
		MASTER = 2,
		KING = 1
	},
	GROUP_NUM = {
		KING = 12,
		MASTER = 24
	},
	StageType = var_0_0,
	FightStageType = var_0_1,
	MainCompName = {
		[var_0_0.DRILL] = "GuildWarDrillStageMainComp",
		[var_0_1.DEPLOY] = "GuildWarFightStageMainComp",
		[var_0_1.FIGHTING] = "GuildWarFightStageMainComp",
		[var_0_1.WAR_RESULT] = "GuildWarResultStageMainComp",
		[var_0_0.SEASON_RESULT] = "GuildWarSeasonResultStageMainComp"
	},
	BUILD_TYPE = {
		FRONT = 1,
		COMMAND = 3,
		STRATEGIC = 2
	},
	CityState = {
		COMMAND_DESTROYED = 3,
		GATE_DESTROYED = 2,
		TOWER_DESTROYED = 1,
		ALIVE = 0,
		ALL_DESTROYED = 4
	},
	GROUP_TYPE = {
		AFTER = 1,
		FIRED = 0
	},
	PLAYER_STATE = {
		DEAD = 2,
		EMPTY = 0,
		ALIVE = 1
	},
	StrategyType = {
		STOP_ATTACK = 2,
		ATTACK = 1,
		NONE = 0
	}
}
