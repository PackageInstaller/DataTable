local var_0_0 = {
	DRILL = 1,
	FIGHT = 2,
	SEASON_RESULT = 3,
	NONE = 0
}
local var_0_1 = {
	DEPLOY = 20,
	WAR_RESULT = 22,
	FIGHTING = 21
}

return {
	GROUP_ID = 5002,
	HELP_ID = 131,
	PARAM_MAX_SCORE_ID = 6001,
	ALL_POSITION_NUM = 16,
	BATTLE_BG_ID = 140,
	CityPos = {
		RIGHT = 2,
		DOWN = 0,
		LEFT = 1
	},
	GROUP_INDEX = {
		ELITE = 3,
		MASTER = 2,
		KING = 1
	},
	GROUP_NUM = {
		MASTER = 24,
		KING = 12
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
		COMMAND = 3,
		FRONT = 1,
		STRATEGIC = 2
	},
	CityState = {
		GATE_DESTROYED = 2,
		TOWER_DESTROYED = 1,
		COMMAND_DESTROYED = 3,
		ALL_DESTROYED = 4,
		ALIVE = 0
	},
	GROUP_TYPE = {
		AFTER = 1,
		FIRED = 0
	},
	PLAYER_STATE = {
		EMPTY = 0,
		DEAD = 2,
		ALIVE = 1
	},
	StrategyType = {
		ATTACK = 1,
		STOP_ATTACK = 2,
		NONE = 0
	}
}
