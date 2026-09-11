return {
	PRELOAD_HERO_NUM = 3,
	HERO_HEARTLINK_STORY_MAX_COUNT = 5,
	MAX_STAR = 6,
	SUB_MUL_INJURY_ID = 450,
	HERO_ATTRIBUTE_PATH = "Assets/ArtResources/UI/Atlas/Hero/HeroAttribute",
	LEVEL_UPGRADE_VOICE_CD = 20,
	EQUIP_SLOT_NUM = 6,
	SKILL_UPGRADE_VOICE_CD = 20,
	SUB_MUL_SELF_INJURY_ID = 460,
	HERO_STAR_SKILL_UP_SKILL_LV = 5,
	MAX_RORATE_ANGLE = 30,
	TALK_DELAY_TIME = 0.85,
	HERO_CAMP_PATH = "Assets/ArtResources/UI/Atlas/CampItem",
	SET_ASSISTANT_VOICE_CD = 10,
	ROTATE_RATIO = 0.5,
	SUB_MUL_ATTRIBUTE_ID = 500,
	MAX_STAR_UP_ID = 600,
	HERO_TRUST_LV_MAX = 5,
	HERO_OATH_STORY_MAX_COUNT = 2,
	PER_STAR_PHASE = 4,
	RARE_ICON_PREFIX = "comm_board_jsxz_grade_",
	ATTRIBUTE_PRECISION = 1000,
	SET_LEADER_VOICE_CD = 10,
	HERO_ATTRIBUTE = {
		ARM = 2,
		CRITICAL = 81,
		ATK = 1,
		STA = 3,
		CRITICAL_RATE = 81
	},
	HERO_LV_MAX = GameSetting.hero_level_max.value[1],
	WEAPON_LV_MAX = GameSetting.weapon_exp_limit.value[#GameSetting.weapon_exp_limit.value],
	HERO_LOVE_LV_MAX = GameDisplayCfg.hero_love_level_max.value[1],
	HERO_ATTRIBUTE_MAP = {
		{
			grow_fixed = "atk_ratio",
			base = "base_atk"
		},
		[3] = {
			grow_fixed = "sta_ratio",
			base = "base_sta"
		},
		{
			grow_fixed = "arm_ratio",
			base = "base_arm"
		},
		[81] = {
			grow_fixed = "crit_ratio",
			base = "base_crit"
		}
	},
	STAR_TO_TEXT = {
		"B",
		"A",
		"S",
		"SS",
		"SSS"
	},
	RARE_TO_COLOR = {
		Color.blue,
		Color.magenta,
		Color(1, 0.847, 0, 1),
		[99] = Color.white
	},
	MODEL_SCALE = Vector3(1, 1, 1),
	SKILL_TYPE = {
		ATTACK = 1,
		SKILL = 2
	},
	STAR_TO_NUMBER = {
		"I",
		"II",
		"III",
		"IV",
		"V",
		"VI"
	},
	RARE_TO_TEXT = {
		"R",
		"SR",
		"SSR"
	},
	MAX_SKILL_LEVEL = GameSetting.hero_skill_level_max.value[1],
	MAX_SKILL_ATTR_LEVEL = GameSetting.hero_skill_attr_level_max.value[1],
	RARE_COLOR = {
		Color.New(0.298, 0.7254, 0.6078, 1),
		Color.New(0.298, 0.7254, 0.6078, 1),
		Color.New(0.2784, 0.5803, 0.7607, 1),
		Color.New(0.8313, 0.3843, 0.7176, 1),
		Color.New(0.9725, 0.5333, 0.2235, 1),
		(Color.New(0.6583, 0.0466, 0.0009, 1))
	},
	HERO_RARE_COLOR = {
		Color.New(0.2745, 0.5803, 0.7647, 1),
		Color.New(0.6588, 0.2588, 0.7254, 1),
		(Color.New(0.9686, 0.6509, 0.2431, 1))
	},
	HERO_RARE_LEVEL = {
		SR = 4,
		SSR = 5,
		R = 3
	},
	SKILL_SHOW_ICON = {
		[1093231] = {
			1093201,
			1093201
		},
		[1093232] = {
			1093201,
			1093202
		},
		[1093233] = {
			1093202,
			1093201
		},
		[1093236] = {
			1093202,
			1093202
		}
	},
	HERO_STAR_SKILL_TYPE = {
		ATTRIBUTE_UP = 1,
		WEAPON_UP = 3,
		SKILL_UP = 2,
		EQUIP_SKILL_UP = 6,
		EQUIP_UP = 4,
		EQUIP_SUIT = 5,
		EQUIP_TRANSITION_UP = 7
	},
	Hero_Star = {
		"B",
		"A",
		"S",
		"SS",
		"SSS",
		"Ω"
	},
	HERO_ATTACK_TYPE_STR = {
		[0] = "PYISICS",
		nil,
		"WIND",
		nil,
		"FLAME",
		nil,
		"FREEZE",
		nil,
		"WATER",
		nil,
		"DARK",
		nil,
		"LIGHT",
		nil,
		"THUNDER",
		[254] = "RANDOM"
	},
	HERO_ATTACK_TYPE = {
		ALL = -999,
		FLAME = 4,
		DARK = 10,
		THUNDER = 14,
		WIND = 2,
		MIX = -1,
		PYISICS = 0,
		FREEZE = 6,
		WATER = 8,
		RANDOM = 254,
		LIGHT = 12
	},
	HERO_CHARGE_TYPE = {
		ENERGY = 2,
		RAGE = 1,
		XIELV = 5,
		DIVINE_GRACE = 4,
		TRACES = 3,
		NONE = 0
	},
	HERO_DATA_TYPE = {
		CUSTOM = 4,
		PREVIEW = 5,
		DRAW = 7,
		COOPERATION = 9,
		FOREIGN = 2,
		SWIMSUITBATTLE = 11,
		UNDEFINED = 0,
		HODURGAME = 14,
		OSIRISPLAYGAME = 13,
		DEFAULT = 1,
		CHALLENGEROUGETEAM = 12,
		STRATEGYMATRIX = 10,
		ADVANCETEST = 8,
		TRIAL = 3,
		POLYHEDRON = 6
	},
	HERO_SKILL_ADD_TYPE = {
		WEAPONSERVANT = 1,
		ASTROLABE = 3,
		WEAPONMODULE = 2,
		ATTRIBUTE = 4
	}
}
