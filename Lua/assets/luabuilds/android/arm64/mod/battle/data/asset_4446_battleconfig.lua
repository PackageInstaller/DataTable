ys.Battle.BattleConfig = ys.Battle.BattleConfig or {}
ys.Battle.BattleConfig.COMBAT_DELAY_ACTIVE = 0.6
ys.Battle.BattleConfig.calcFPS = 30
ys.Battle.BattleConfig.viewFPS = 30
ys.Battle.BattleConfig.AIFPS = 10
ys.Battle.BattleConfig.calcInterval = 1 / ys.Battle.BattleConfig.calcFPS
ys.Battle.BattleConfig.viewInterval = 1 / ys.Battle.BattleConfig.viewFPS
ys.Battle.BattleConfig.AIInterval = 1 / ys.Battle.BattleConfig.AIFPS
ys.Battle.BattleConfig.FRIENDLY_CODE = 1
ys.Battle.BattleConfig.FOE_CODE = -1
ys.Battle.BattleConfig.SHIELD_CENTER_CONST = 3.14
ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2 = 2.0933333333333333
ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4 = 4.1866666666666665
ys.Battle.BattleConfig.SHIELD_ROTATE_CONST = 30 / math.pi * 18
ys.Battle.BattleConfig.K1 = 6
ys.Battle.BattleConfig.K2 = 100
ys.Battle.BattleConfig.K3 = 3.14
ys.Battle.BattleConfig.AIR_ASSIST_RELOAD_RATIO = 220
ys.Battle.BattleConfig.RANDOM_DAMAGE_MIN = 0
ys.Battle.BattleConfig.RANDOM_DAMAGE_MAX = 2
ys.Battle.BattleConfig.BASIC_TIME_SCALE = 1
ys.Battle.BattleConfig.SPINE_SCALE = 2
ys.Battle.BattleConfig.BULLET_UPPER_BOUND_VISION_OFFSET = 30
ys.Battle.BattleConfig.BULLET_LEFT_BOUND_SPLIT_OFFSET = 8
ys.Battle.BattleConfig.BULLET_LOWER_BOUND_SPLIT_OFFSET = 8
ys.Battle.BattleConfig.BULLET_SPLIT_SHIFT_DELAY = 0.2
ys.Battle.BattleConfig.CAMERA_INIT_POS = Vector3(0, 62, -10)
ys.Battle.BattleConfig.CAMERA_SIZE = 20
ys.Battle.BattleConfig.CAMERA_BASE_HEIGH = 8
ys.Battle.BattleConfig.CAMERA_GOLDEN_RATE = 0.618
ys.Battle.BattleConfig.AntiAirConfig = {}
ys.Battle.BattleConfig.AntiAirConfig.const_n = 10
ys.Battle.BattleConfig.AntiAirConfig.const_K = 1000
ys.Battle.BattleConfig.AntiAirConfig.const_N = 5
ys.Battle.BattleConfig.AntiAirConfig.const_A = 20
ys.Battle.BattleConfig.AntiAirConfig.const_B = 40
ys.Battle.BattleConfig.AntiAirConfig.Restore_Interval = 1
ys.Battle.BattleConfig.AntiAirConfig.Precast_duration = 0.25
ys.Battle.BattleConfig.AntiAirConfig.RangeBulletID = 2001
ys.Battle.BattleConfig.AntiAirConfig.RangeBarrageID = 1
ys.Battle.BattleConfig.AntiAirConfig.RangeAntiAirBone = "rangeantiaircraft"
ys.Battle.BattleConfig.AirSupportUnitPos = Vector3(-105, 0, 58)
ys.Battle.BattleConfig.SubSupportUnitPosList = {
	Vector3(-36, 0, 58),
	Vector3(-30, 0, 78),
	Vector3(-30, 0, 38)
}
ys.Battle.BattleConfig.SubSupportDelay = 5
ys.Battle.BattleConfig.AnitAirRepeaterConfig = {}
ys.Battle.BattleConfig.AnitAirRepeaterConfig.const_A = 32
ys.Battle.BattleConfig.AnitAirRepeaterConfig.const_B = 12
ys.Battle.BattleConfig.AnitAirRepeaterConfig.const_C = 220
ys.Battle.BattleConfig.AnitAirRepeaterConfig.upper_range = 35
ys.Battle.BattleConfig.AnitAirRepeaterConfig.lower_range = 15
ys.Battle.BattleConfig.ChargeWeaponConfig = {}
ys.Battle.BattleConfig.ChargeWeaponConfig.a1 = 0
ys.Battle.BattleConfig.ChargeWeaponConfig.K1 = 0
ys.Battle.BattleConfig.ChargeWeaponConfig.K2 = 1000
ys.Battle.BattleConfig.ChargeWeaponConfig.FIX_CD = 7
ys.Battle.BattleConfig.ChargeWeaponConfig.MEGA_FIX_CD = 3
ys.Battle.BattleConfig.ChargeWeaponConfig.GCD = 1
ys.Battle.BattleConfig.ChargeWeaponConfig.Enhance = 1.2
ys.Battle.BattleConfig.ChargeWeaponConfig.SIGHT_A = 0.35
ys.Battle.BattleConfig.ChargeWeaponConfig.SIGHT_B = -40
ys.Battle.BattleConfig.ChargeWeaponConfig.SIGHT_C = 38
ys.Battle.BattleConfig.TorpedoCFG = {}
ys.Battle.BattleConfig.TorpedoCFG.T = 10
ys.Battle.BattleConfig.TorpedoCFG.N = 1000
ys.Battle.BattleConfig.TorpedoCFG.GCD = 0.5
ys.Battle.BattleConfig.AirAssistCFG = {}
ys.Battle.BattleConfig.AirAssistCFG.GCD = 0.5
ys.Battle.BattleConfig.HammerCFG = {}
ys.Battle.BattleConfig.HammerCFG.PreventUpperBound = 0.8
ys.Battle.BattleConfig.BulletHeight = 1
ys.Battle.BattleConfig.HeightOffsetRate = 1.5
ys.Battle.BattleConfig.CharacterFeetHight = -0.5
ys.Battle.BattleConfig.BombDetonateHeight = 1.2
ys.Battle.BattleConfig.CameraSizeChangeSpeed = 0.04
ys.Battle.BattleConfig.AircraftHeight = 10
ys.Battle.BattleConfig.AirFighterOffsetZ = 3
ys.Battle.BattleConfig.AirFighterHeight = 10
ys.Battle.BattleConfig.CommonBone = {
	rangeantiaircraft = {
		{
			1.5,
			1.1,
			0
		}
	}
}
ys.Battle.BattleConfig.MaxLeft = -10000
ys.Battle.BattleConfig.MaxRight = 10000
ys.Battle.BattleConfig.BornOffset = Vector3(0, 0, 0.1)
ys.Battle.BattleConfig.FORMATION_ID = 10001
ys.Battle.BattleConfig.CelebrateDuration = 3
ys.Battle.BattleConfig.EscapeDuration = 5
ys.Battle.BattleConfig.BulletMotionRate = 0.4
ys.Battle.BattleConfig.BulletSpeedConvertConst = 0.1
ys.Battle.BattleConfig.ShipSpeedConvertConst = 0.01
ys.Battle.BattleConfig.AircraftSpeedConvertConst = 0.01
ys.Battle.BattleConfig.PLAYER_WEAPON_GLOBAL_COOL_DOWN_DURATION = 0.5
ys.Battle.BattleConfig.PLAYER_DEFAULT = 0
ys.Battle.BattleConfig.SPECTRE_UNIT_TYPE = -99
ys.Battle.BattleConfig.VISIBLE_SPECTRE_UNIT_TYPE = -100
ys.Battle.BattleConfig.FUSION_ELEMENT_UNIT_TYPE = -10000
ys.Battle.BattleConfig.COUNT_DOWN_ESCAPE_AI_ID = 6
ys.Battle.BattleConfig.ESCAPE_EXPLO_TAG = {
	"unexit"
}
ys.Battle.BattleConfig.RESOURCE_STEP = 10
ys.Battle.BattleConfig.RESOURCE_STAY_DURATION = 2
ys.Battle.BattleConfig.CAST_CAM_ZOOM_SIZE = 14
ys.Battle.BattleConfig.CAST_CAM_ZOOM_IN_DURATION = 0.1
ys.Battle.BattleConfig.CAST_CAM_ZOOM_IN_DURATION_SKILL = 0.04
ys.Battle.BattleConfig.CAST_CAM_ZOOM_OUT_DURATION_CANNON = 0.1
ys.Battle.BattleConfig.CAST_CAM_ZOOM_OUT_EXTRA_DELAY_CANNON = 0.04
ys.Battle.BattleConfig.CAST_CAM_ZOOM_OUT_DELAY_CANNON = 0
ys.Battle.BattleConfig.CAST_CAM_ZOOM_OUT_DURATION_AIR = 0.1
ys.Battle.BattleConfig.CAST_CAM_ZOOM_OUT_EXTRA_DELAY_AIR = 0.03
ys.Battle.BattleConfig.CAST_CAM_ZOOM_OUT_DELAY_AIR = 0.05
ys.Battle.BattleConfig.AIR_ASSIST_SPEED_RATE = 2.8
ys.Battle.BattleConfig.CAST_CAM_ZOOM_OUT_DURATION_SKILL = 0.04
ys.Battle.BattleConfig.CAST_CAM_ZOOM_OUT_EXTRA_DELAY_SKILL = 0
ys.Battle.BattleConfig.CAST_CAM_ZOOM_OUT_DELAY_SKILL = 0
ys.Battle.BattleConfig.CALIBRATE_ACCELERATION = 1.2
ys.Battle.BattleConfig.CAST_CAM_OVERLOOK_SIZE = 24
ys.Battle.BattleConfig.CAST_CAM_OVERLOOK_REVERT_DURATION = 1.5
ys.Battle.BattleConfig.CAM_RESET_DURATION = 0.7
ys.Battle.BattleConfig.SPEED_FACTOR_FOCUS_CHARACTER = "focusCharacter"
ys.Battle.BattleConfig.FOCUS_MAP_RATE = 0.1
ys.Battle.BattleConfig.MAIN_UNIT_POS = {
	[ys.Battle.BattleConfig.FRIENDLY_CODE] = {
		Vector3(-105, 0, 58),
		Vector3(-105, 0, 78),
		Vector3(-105, 0, 38)
	},
	[ys.Battle.BattleConfig.FOE_CODE] = {
		Vector3(15, 0, 58),
		Vector3(15, 0, 78),
		Vector3(15, 0, 38)
	}
}
ys.Battle.BattleConfig.FIELD_RIGHT_BOUND_BIAS = 0
ys.Battle.BattleConfig.SUB_UNIT_POS_Z = {
	58,
	78,
	38
}
ys.Battle.BattleConfig.SUB_UNIT_OFFSET_X = -5
ys.Battle.BattleConfig.SUB_BENCH_POS = {
	Vector3(-325, 0, 228),
	Vector3(-325, 0, 128)
}
ys.Battle.BattleConfig.SHIP_CLD_INTERVAL = 1
ys.Battle.BattleConfig.SHIP_CLD_BUFF = 8010
ys.Battle.BattleConfig.START_SPEED_CONST_A = 2.5
ys.Battle.BattleConfig.START_SPEED_CONST_B = 0.25
ys.Battle.BattleConfig.START_SPEED_CONST_C = 0.3
ys.Battle.BattleConfig.START_SPEED_CONST_D = 2.5
ys.Battle.BattleConfig.GRAVITY = -0.05
ys.Battle.BattleConfig.DUEL_MAIN_RAGE_BUFF = 6
ys.Battle.BattleConfig.DULE_BALANCE_BUFF = 19
ys.Battle.BattleConfig.SIMULATION_BALANCE_BUFF = 49
ys.Battle.BattleConfig.ARENA_LIST = {
	80000,
	80001,
	80002,
	80003
}
ys.Battle.BattleConfig.SIMULATION_FREE_BUFF = 41
ys.Battle.BattleConfig.SIMULATION_ADVANTAGE_BUFF = 42
ys.Battle.BattleConfig.SIMULATION_ADVANTAGE_CANCEL_LIST = {
	42,
	44,
	45
}
ys.Battle.BattleConfig.SIMULATION_DISADVANTAGE_BUFF = 43
ys.Battle.BattleConfig.SIMULATION_RIVAL_RAGE_TOTAL_COUNT = 30
ys.Battle.BattleConfig.CHALLENGE_INVINCIBLE_BUFF = 50
ys.Battle.BattleConfig.WARNING_HP_RATE = 0.7
ys.Battle.BattleConfig.WARNING_HP_RATE_MAIN = 0.3
ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE = {}
ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE[1] = {
	scale = 1,
	x = 0.924,
	y = 0.135
}
ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE[2] = {
	scale = 1,
	x = 0.81,
	y = 0.135
}
ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE[3] = {
	scale = 1,
	x = 0.696,
	y = 0.135
}
ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE[4] = {
	scale = 1,
	x = 0.58,
	y = 0.135
}
ys.Battle.BattleConfig.JOY_STICK_DEFAULT_PREFERENCE = {
	scale = 1,
	x = 0.12,
	y = 0.183
}
ys.Battle.BattleConfig.AUTO_DEFAULT_PREFERENCE = {
	scale = 1,
	x = 0.0625,
	y = 0.925
}
ys.Battle.BattleConfig.DOT_CONFIG = {}
ys.Battle.BattleConfig.DOT_CONFIG[1] = {
	reduce = "igniteReduce",
	prolong = "igniteProlong",
	shorten = "igniteShorten",
	resist = "igniteResist",
	enhance = "igniteEnhance",
	hit = "ignite_accuracy"
}
ys.Battle.BattleConfig.DOT_CONFIG[2] = {
	reduce = "floodingReduce",
	prolong = "floodingProlong",
	shorten = "floodingShorten",
	resist = "floodingResist",
	enhance = "floodingEnhance",
	hit = "flooding_accuracy"
}
ys.Battle.BattleConfig.DOT_CONFIG[10] = {}
ys.Battle.BattleConfig.DOT_CONFIG[20516] = {}
ys.Battle.BattleConfig.DOT_CONFIG_DEFAULT = {
	reduce = 0,
	prolong = 0,
	shorten = 0,
	resist = 0,
	enhance = 0,
	hit = 0
}
ys.Battle.BattleConfig.AMMO_DAMAGE_ENHANCE = {
	"damageRatioByAmmoType_1",
	"damageRatioByAmmoType_2",
	"damageRatioByAmmoType_3",
	"damageRatioByAmmoType_4",
	nil,
	nil,
	"damageRatioByAmmoType_7"
}
ys.Battle.BattleConfig.AMMO_DAMAGE_REDUCE = {
	"damageReduceFromAmmoType_1",
	"damageReduceFromAmmoType_2",
	"damageReduceFromAmmoType_3",
	"damageReduceFromAmmoType_4",
	nil,
	nil,
	"damageReduceFromAmmoType_7"
}
ys.Battle.BattleConfig.DAMAGE_AMMO_TO_ARMOR_RATE_ENHANCE = {
	"damageAmmoToArmorRateEnhance_1",
	"damageAmmoToArmorRateEnhance_2",
	"damageAmmoToArmorRateEnhance_3"
}
ys.Battle.BattleConfig.DAMAGE_TO_ARMOR_RATE_ENHANCE = {
	"damageToArmorRateEnhance_1",
	"damageToArmorRateEnhance_2",
	"damageToArmorRateEnhance_3"
}
ys.Battle.BattleConfig.SHIP_TYPE_ACCURACY_ENHANCE = {
	[ShipType.QuZhu] = "accuracyToShipType_1",
	[ShipType.QingXun] = "accuracyToShipType_2",
	[ShipType.ZhongXun] = "accuracyToShipType_3",
	[ShipType.ZhanXun] = "accuracyToShipType_4",
	[ShipType.ZhanLie] = "accuracyToShipType_5",
	[ShipType.QingHang] = "accuracyToShipType_6",
	[ShipType.ZhengHang] = "accuracyToShipType_7",
	[ShipType.QianTing] = "accuracyToShipType_8",
	[ShipType.HangXun] = "accuracyToShipType_9",
	[ShipType.HangZhan] = "accuracyToShipType_10",
	[ShipType.LeiXun] = "accuracyToShipType_11",
	[ShipType.WeiXiu] = "accuracyToShipType_12",
	[ShipType.ZhongPao] = "accuracyToShipType_13",
	[ShipType.YuLeiTing] = "accuracyToShipType_14",
	[ShipType.JinBi] = "accuracyToShipType_15",
	[ShipType.ZiBao] = "accuracyToShipType_16",
	[ShipType.QianMu] = "accuracyToShipType_17",
	[ShipType.ChaoXun] = "accuracyToShipType_18",
	[ShipType.Yunshu] = "accuracyToShipType_19",
	[ShipType.DaoQuV] = "accuracyToShipType_20",
	[ShipType.DaoQuM] = "accuracyToShipType_21",
	[ShipType.FengFanS] = "accuracyToShipType_22",
	[ShipType.FengFanV] = "accuracyToShipType_23",
	[ShipType.FengFanM] = "accuracyToShipType_24"
}
ys.Battle.BattleConfig.OXY_RAID_BASE_LINE_PVE = -20
ys.Battle.BattleConfig.OXY_RAID_BASE_LINE_PVP = -20
ys.Battle.BattleConfig.SUB_DEFAULT_STAY_AI = 10006
ys.Battle.BattleConfig.SUB_DEFAULT_ENGAGE_AI = 17
ys.Battle.BattleConfig.SUB_DEFAULT_RETREAT_AI = 18
ys.Battle.BattleConfig.SONAR_DURATION_K = 0.1
ys.Battle.BattleConfig.SONAR_INTERVAL_K = 0.1
ys.Battle.BattleConfig.VAN_SONAR_PROPERTY = {
	[ShipType.QuZhu] = {
		a = 2,
		maxRange = 100,
		minRange = 45,
		b = 32
	},
	[ShipType.QingXun] = {
		a = 2.86,
		maxRange = 80,
		minRange = 30,
		b = 0
	},
	[ShipType.DaoQuV] = {
		a = 2,
		maxRange = 100,
		minRange = 45,
		b = 32
	}
}
ys.Battle.BattleConfig.MAIN_SONAR_PROPERTY = {
	a = 24,
	maxRange = 15,
	minRange = 0
}
ys.Battle.BattleConfig.SUB_EXPOSE_LASTING_DURATION = 0.5
ys.Battle.BattleConfig.SUB_FADE_IN_DURATION = 0.5
ys.Battle.BattleConfig.SUB_FADE_OUT_DURATION = 0.5
ys.Battle.BattleConfig.SUB_DIVE_IMMUNE_IGNITE_BUFF = 314
ys.Battle.BattleConfig.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF = 315
ys.Battle.BattleConfig.PLAYER_SUB_BUBBLE_FX = "bubble"
ys.Battle.BattleConfig.PLAYER_SUB_BUBBLE_INIT = 200
ys.Battle.BattleConfig.PLAYER_SUB_BUBBLE_INTERVAL = 3
ys.Battle.BattleConfig.MONSTER_SUB_KAMIKAZE_DUAL_K = 50
ys.Battle.BattleConfig.MONSTER_SUB_KAMIKAZE_DUAL_P = 0.15
ys.Battle.BattleConfig.BATTLE_SHADER = {}
ys.Battle.BattleConfig.BATTLE_SHADER.SEMI_TRANSPARENT = "M02/Unlit_Colored_Semitransparent"
ys.Battle.BattleConfig.BATTLE_SHADER.GRID_TRANSPARENT = "M02/Skeleton Colored_Additive"
ys.Battle.BattleConfig.BATTLE_SHADER.COLORED_ALPHA = "M02/Unlit Colored_Alpha"
ys.Battle.BattleConfig.BATTLE_DODGEM_STAGES = {
	1140101,
	1140102,
	1140103
}
ys.Battle.BattleConfig.BATTLE_DODGEM_PASS_SCORE = 10
ys.Battle.BattleConfig.SR_CONFIG = {}
ys.Battle.BattleConfig.SR_CONFIG.FLOAT_CD = 2
ys.Battle.BattleConfig.SR_CONFIG.DIVE_CD = 2
ys.Battle.BattleConfig.SR_CONFIG.BOOST_CD = 10
ys.Battle.BattleConfig.SR_CONFIG.SHIFT_CD = 5
ys.Battle.BattleConfig.SR_CONFIG.BOOST_SPEED = 2
ys.Battle.BattleConfig.SR_CONFIG.BOOST_DECAY = 0.2
ys.Battle.BattleConfig.SR_CONFIG.BOOST_DURATION = 12
ys.Battle.BattleConfig.SR_CONFIG.BOOST_DECAY_STAMP = 9
ys.Battle.BattleConfig.SR_CONFIG.BASE_POINT = 100
ys.Battle.BattleConfig.SR_CONFIG.POINT = 10
ys.Battle.BattleConfig.SR_CONFIG.DEAD_POINT = 15
ys.Battle.BattleConfig.SR_CONFIG.M = 2
ys.Battle.BattleConfig.CHALLENGE_ENHANCE = {}
ys.Battle.BattleConfig.CHALLENGE_ENHANCE.K = 1
ys.Battle.BattleConfig.CHALLENGE_ENHANCE.X = 3
ys.Battle.BattleConfig.CHALLENGE_ENHANCE.A = 2
ys.Battle.BattleConfig.CHALLENGE_ENHANCE.X1 = 5
ys.Battle.BattleConfig.CHALLENGE_ENHANCE.X2 = 5
ys.Battle.BattleConfig.CHALLENGE_ENHANCE.Y1 = 10
ys.Battle.BattleConfig.CHALLENGE_ENHANCE.Y2 = 5
ys.Battle.BattleConfig.LOADING_TIPS_LIMITED_SYSTEM = {
	SYSTEM_WORLD
}
ys.Battle.BattleConfig.WORLD_ENEMY_ENHANCEMENT_CONST_B = 80
ys.Battle.BattleConfig.WORLD_ENEMY_ENHANCEMENT_CONST_C = 1.1
ys.Battle.BattleConfig.BULLET_DECREASE_DMG_FONT = {
	4,
	0.9
}
ys.Battle.BattleConfig.CLOAK_EXPOSE_CONST = 50
ys.Battle.BattleConfig.CLOAK_EXPOSE_BASE_MIN = 100
ys.Battle.BattleConfig.CLOAK_EXPOSE_SKILL_MIN = 60
ys.Battle.BattleConfig.CLOAK_BASE_RESTORE_DELTA = -60
ys.Battle.BattleConfig.CLOAK_RECOVERY = 5
ys.Battle.BattleConfig.BASE_ARP = 0.1
ys.Battle.BattleConfig.CLOAK_STRIKE_ADDITIVE = 6
ys.Battle.BattleConfig.CLOAK_STRIKE_ADDITIVE_LIMIT = 60
ys.Battle.BattleConfig.CLOAK_BOMBARD_BASE_EXPOSE = 10
ys.Battle.BattleConfig.AIM_BIAS_FLEET_RANGE_MOD = 0.18
ys.Battle.BattleConfig.AIM_BIAS_SUB_RANGE_MOD = 0.18
ys.Battle.BattleConfig.AIM_BIAS_MONSTER_RANGE_MOD = 0.4
ys.Battle.BattleConfig.AIM_BIAS_DECAY_MOD = 0.01
ys.Battle.BattleConfig.AIM_BIAS_DECAY_MOD_MONSTER = 0.01
ys.Battle.BattleConfig.AIM_BIAS_DECAY_BASE = 0
ys.Battle.BattleConfig.AIM_BIAS_DECAY_SUB_CONST = 50
ys.Battle.BattleConfig.AIM_BIAS_DECAY_SMOKE = 1
ys.Battle.BattleConfig.AIM_BIAS_DECAY_SMOKE_NIGHT = 0.8
ys.Battle.BattleConfig.AIM_BIAS_SMOKE_RESTORE_DURATION = 3
ys.Battle.BattleConfig.AIM_BIAS_SMOKE_RECOVERY_RATE = 0.6
ys.Battle.BattleConfig.AIM_BIAS_DECAY_SPEED_MAX_SCOUT = 3
ys.Battle.BattleConfig.AIM_BIAS_DECAY_SPEED_MAX_MONSTER = 3
ys.Battle.BattleConfig.AIM_BIAS_DECAY_SPEED_MAX_SUB = 100
ys.Battle.BattleConfig.AIM_BIAS_MIN_RANGE_SCOUT = {
	3,
	4,
	5,
	5
}
ys.Battle.BattleConfig.AIM_BIAS_MIN_RANGE_MONSTER = 4
ys.Battle.BattleConfig.AIM_BIAS_MIN_RANGE_SUB = 4
ys.Battle.BattleConfig.AIM_BIAS_MAX_RANGE_SCOUT = 25
ys.Battle.BattleConfig.AIM_BIAS_MAX_RANGE_MONSTER = 60
ys.Battle.BattleConfig.AIM_BIAS_MAX_RANGE_SUB = 25
ys.Battle.BattleConfig.AIM_BIAS_ENEMY_INIT_TIME = 1.5
ys.Battle.BattleConfig.FLEET_ATTR_CAP = {
	kuangsanshuliang = 3,
	huohun = 5,
	YumiaManaFlow = 10,
	Judgement = 12,
	shenpanzhijian = 6,
	kuangsanshijian = 50,
	ReisalinAP = 99,
	KansasSP = 3,
	YumiaMANA = 100,
	yuanchou = 9
}
ys.Battle.BattleConfig.TARGET_SELECT_PRIORITY = {
	QEM_highlight = 99,
	leastHP = 998,
	C14_1 = 10,
	C14_highlight = 11,
	farthest = 999,
	highlight = 99,
	xuzhang_hude = 1
}
ys.Battle.BattleConfig.EQUIPMENT_ACTIVE_LIMITED_BY_TYPE = {
	[31] = {
		21
	},
	[32] = {
		20
	}
}
ys.Battle.BattleConfig.TRIGGER_PRIORITY = {
	[ys.Battle.BattleConst.BuffEffectType.ON_TAKE_DAMAGE] = {
		BattleBuffCastSkillDamageCount = 25,
		BattleBuffRecordShield = 20,
		BattleBuffShield = 20,
		BattleBuffLockHealth = 10,
		BattleBuffOverHealingShield = 20,
		BattleBuffBarrier = 20,
		BattleBuffCount = 30,
		BattleBuffHPLink = 15,
		BattleBuffRecoilShield = 19
	}
}
ys.Battle.BattleConfig.TRIGGER_PRIORITY_LOWEST = 99
ys.Battle.BattleConfig.SWEET_DEATH_NATIONALITY = {
	107
}
ys.Battle.BattleConfig.ALCHEMIST_AP_UI = {
	109
}
ys.Battle.BattleConfig.ALCHEMIST_AP_NAME = "ReisalinAP"
ys.Battle.BattleConfig.YUMIA_MANA_UI = {
	113
}
ys.Battle.BattleConfig.YUMIA_MANA_NAME = "YumiaMANA"
ys.Battle.BattleConfig.MIRROR_QICON_KEY = "_turn"
ys.Battle.BattleConfig.MIRROR_QICON_SHIP_GROUP = {
	1150005
}

return
