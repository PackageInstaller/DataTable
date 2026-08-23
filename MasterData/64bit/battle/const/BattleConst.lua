return {
	START_QUALITY = 4,
	ELEMENT_CHECK_QUALITY = 5,
	BL_MERGE_SAME_BUFF = true,
	BL_SHOW_BUFF_DESC = true,
	BL_SHOW_SHOW_RESULT = false,
	BATTLE_LOG_BL = 0,
	BATTLE_LOG_TYPE = 0,
	DEBUG = true,
	ServerPlayId = {
		PEAK_ARENA = 2,
		TOWER = 1,
		TEAM_BATTLE_MONSTER = 10,
		TEAM_BATTLE_BOSS = 9,
		EXPLORATION_GUARD = 8,
		EXPLORATION_MONSTER = 7,
		SPIRE_BOSS = 6,
		DEMON_BOSS = 5,
		EXPLORATION_BOSS = 4,
		PEAK_ARENA_MULTI = 3
	},
	ERROR_ID = {
		DEAD_LOOP = 1,
		DAMAGE_ERROR = 2
	},
	Q_SUPPRESS_TYPE = {
		BUFF = 2,
		FORMULA = 1,
		EFFECT = 4,
		PASSIVE = 3
	},
	Q_SUPPRESS_MODULE = {
		SUCCUBA = 5,
		PET = 4,
		TOKEN = 3,
		ARTIFACT = 2,
		KNIGHT = 1
	},
	STAR_ENUM = {
		SUCCUBA = 7,
		PET = 7,
		TOKEN = 5,
		ARTIFACT = 5,
		KNIGHT = 7
	},
	AUTO_TYPE = {
		SUCCUBA = 2,
		UNITE = 1
	},
	SUCCUBA_PARAM = {
		ROUND_RECOVER_ENERGY_MAX = 104,
		KILL_SKILL_ADD_ENERGY = 103,
		SKILL_ADD_ENERGY = 102,
		NORMAL_SKILL_ADD_ENERGY = 101,
		THRESH_VALUE = 107,
		MAX_ENERGY_VALUE = 106,
		INIT_ENERGY_VALUE = 105
	},
	BL_SHOW_BUFF = {
		[0] = false
	},
	BL_SHOW_SHOW_SKILL_EFFECT = {
		[0] = true,
		true,
		true,
		true,
		true,
		true,
		true,
		nil,
		nil,
		nil,
		nil,
		nil,
		true,
		true,
		nil,
		true,
		true,
		true,
		true,
		[100] = true
	},
	BL_SHOW_SHOW_TAG = {
		effect = true,
		onSkillEffect = true,
		extraEffect = true
	},
	getSuccubaParamCfg = function()
		return loadCfg("core.config.cfg.succuba_parameter_info")
	end,
	getSuccubaInfoCfg = function()
		return loadCfg("core.config.cfg.succuba_info")
	end,
	getSuccubaBattleInfoCfg = function()
		return loadCfg("core.config.cfg.succuba_battle_info")
	end
}
