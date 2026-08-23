return {
	BL_MERGE_SAME_BUFF = true,
	BL_SHOW_SHOW_RESULT = false,
	START_QUALITY = 4,
	BATTLE_LOG_BL = 0,
	BL_SHOW_BUFF_DESC = true,
	BATTLE_LOG_TYPE = 0,
	ELEMENT_CHECK_QUALITY = 5,
	DEBUG = true,
	ServerPlayId = {
		TEAM_BATTLE_BOSS = 9,
		EXPLORATION_MONSTER = 7,
		TEAM_BATTLE_MONSTER = 10,
		DEMON_BOSS = 5,
		EXPLORATION_BOSS = 4,
		PEAK_ARENA = 2,
		PEAK_ARENA_MULTI = 3,
		EXPLORATION_GUARD = 8,
		TOWER = 1,
		SPIRE_BOSS = 6
	},
	ERROR_ID = {
		DEAD_LOOP = 1,
		DAMAGE_ERROR = 2
	},
	Q_SUPPRESS_TYPE = {
		EFFECT = 4,
		PASSIVE = 3,
		FORMULA = 1,
		BUFF = 2
	},
	Q_SUPPRESS_MODULE = {
		TOKEN = 3,
		KNIGHT = 1,
		SUCCUBA = 5,
		PET = 4,
		ARTIFACT = 2
	},
	STAR_ENUM = {
		TOKEN = 5,
		KNIGHT = 7,
		SUCCUBA = 7,
		PET = 7,
		ARTIFACT = 5
	},
	AUTO_TYPE = {
		SUCCUBA = 2,
		UNITE = 1
	},
	SUCCUBA_PARAM = {
		SKILL_ADD_ENERGY = 102,
		THRESH_VALUE = 107,
		ROUND_RECOVER_ENERGY_MAX = 104,
		INIT_ENERGY_VALUE = 105,
		NORMAL_SKILL_ADD_ENERGY = 101,
		MAX_ENERGY_VALUE = 106,
		KILL_SKILL_ADD_ENERGY = 103
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
		onSkillEffect = true,
		effect = true,
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
