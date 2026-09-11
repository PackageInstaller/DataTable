local var_0_0 = {
	Type = {
		WAR = 5,
		FOOD = 1,
		TECH = 3,
		ROCK = 2,
		BUILD = 6,
		BEAST = 4
	},
	VictoryCondition = {
		ROLE_LEVEL = 1,
		TURN = 2,
		BEAST = 4,
		RESOURCE = 3
	},
	TypeConst = {
		TEACH = 1,
		ENDLESS = 3,
		DAILY = 2,
		HERO_TEACH = 4
	},
	FactorType = {
		MAX_LEVEL_EXCHANGE = 10,
		SPEED_CHANGE = 12,
		ROLE_LEVEL_CHANGE = 15,
		POOL_CHANGE = 14,
		STAGE_FOOD_CHANGE = 20,
		NEXT_TECH_CHANGE = 17,
		NEXT_TURN_EFFECT_CHANGE = 7,
		COMBINE_EFFECT_CHANGE = 8,
		UNLOCK_SKILL = 1,
		SKILL_CD_CHANGE = 4,
		COST_CHANGE = 2,
		MIN_LEVEL_EXCHANGE = 11,
		BUILDING_CHANGE = 16,
		INIT_RESOURCE_CHANGE = 19,
		EXP_CHANGE = 13,
		RESOURCE_GET_CHANGE = 3
	},
	NameList = {
		"minigame_activity_2_8_sanxiao_merge",
		"minigame_activity_2_8_sanxiao_button",
		"minigame_activity_2_8_sanxiao_pop",
		"minigame_activity_2_5_Puzzle_rotate",
		"minigame_activity_2_8_sanxiao_skill1",
		"minigame_activity_2_8_sanxiao_skill2"
	},
	SheeList = {
		"minigame_activity_2_8",
		"minigame_activity_2_8",
		"minigame_activity_2_8",
		"minigame_activity_2_5",
		"minigame_activity_2_8",
		"minigame_activity_2_8"
	}
}

var_0_0.TypeText = {
	[var_0_0.Type.FOOD] = "ACTIVITY_COMBINE_GAME_CELL_1",
	[var_0_0.Type.ROCK] = "ACTIVITY_COMBINE_GAME_CELL_2",
	[var_0_0.Type.TECH] = "ACTIVITY_COMBINE_GAME_CELL_3",
	[var_0_0.Type.BEAST] = "ACTIVITY_COMBINE_GAME_CELL_4",
	[var_0_0.Type.WAR] = "ACTIVITY_COMBINE_GAME_CELL_5",
	[var_0_0.Type.BUILD] = "ACTIVITY_COMBINE_GAME_CELL_6"
}
var_0_0.BaseInfoConst = {
	[var_0_0.Type.FOOD] = "ACTIVITY_COMBINE_GAME_RESOURCE_DESC_1",
	[var_0_0.Type.ROCK] = "ACTIVITY_COMBINE_GAME_RESOURCE_DESC_2",
	[var_0_0.Type.TECH] = "ACTIVITY_COMBINE_GAME_RESOURCE_DESC_3"
}
var_0_0.RefreshType = {
	[var_0_0.FactorType.UNLOCK_SKILL] = 1,
	[var_0_0.FactorType.COST_CHANGE] = 1,
	[var_0_0.FactorType.SKILL_CD_CHANGE] = 1,
	[var_0_0.FactorType.MAX_LEVEL_EXCHANGE] = 2,
	[var_0_0.FactorType.MIN_LEVEL_EXCHANGE] = 2,
	[var_0_0.FactorType.SPEED_CHANGE] = 2
}

return var_0_0
