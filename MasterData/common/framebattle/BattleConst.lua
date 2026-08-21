-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleConst.lua

local BattleConst = {}

BattleConst.NORMAL_POS_CONFIG = {
	[0] = {
		2.5,
		1
	},
	{
		2,
		0
	},
	{
		1.5,
		1
	},
	{
		2,
		2
	},
	{
		1,
		0
	},
	{
		0.5,
		1
	},
	{
		1,
		2
	},
	{
		0,
		0
	},
	{
		-0.5,
		1
	},
	{
		0,
		2
	}
}
BattleConst.LR_LEN = 6
BattleConst.UD_LEN = 3
BattleConst.GRID_SIZE = 2.35
BattleConst.ACTOR_SPEED = 4
BattleConst.BEHAVIOR_NOTICE_EVENT = 1
BattleConst.BEHAVIOR_IGNORE = 3
BattleConst.COMBAT_STATE_NONE = -1
BattleConst.COMBAT_STATE_IDLE = 0
BattleConst.COMBAT_STATE_ATK = 1
BattleConst.COMBAT_STATE_HITED = 2
BattleConst.COMBAT_STATE_DEATH = 3
BattleConst.COMBAT_STATE_WAIT = 4
BattleConst.DEFAULT_BH_STATE = {
	[BattleConst.COMBAT_STATE_IDLE] = "idle",
	[BattleConst.COMBAT_STATE_DEATH] = "Die",
	[BattleConst.COMBAT_STATE_WAIT] = "wait"
}
BattleConst.INPUT_EVENT_USE_SKILL = 1
BattleConst.INPUT_EVENT_SET_AUTO = 2
BattleConst.INPUT_EVENT_SET_SHORT = 3
BattleConst.MATRIX_ENTITY_PREPARE_FRAME = 5
BattleConst.MATRIX_DEFAULT_MAX_TIME = 90
BattleConst.MATRIX_EVENT_BATTLE_START = 100
BattleConst.MATRIX_EVENT_BATTLE_OVER = 101
BattleConst.MATRIX_EVENT_BATTLE_TIME = 102
BattleConst.MATRIX_EVENT_MONSTER_WAVE = 103
BattleConst.MATRIX_EVENT_MONSTER_WAVE_DEAD = 104
BattleConst.MATRIX_EVENT_ADD_TRAP = 105
BattleConst.MATRIX_EVENT_DEL_TRAP = 106
BattleConst.MATRIX_EVENT_ADD_WEATHER = 107
BattleConst.MATRIX_EVENT_DEL_WEATHER = 108
BattleConst.MATRIX_EVENT_ACTION_END = 109
BattleConst.MATRIX_EVENT_ENTITY_DAMAGE = 200
BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE = 201
BattleConst.MATRIX_EVENT_ENTITY_ADDSTATE = 202
BattleConst.MATRIX_EVENT_ENTITY_DELSTATE = 203
BattleConst.MATRIX_EVENT_ENTITY_PAUSEBH = 204
BattleConst.MATRIX_EVENT_ENTITY_CANCELPAUSEBH = 205
BattleConst.MATRIX_EVENT_ENTITY_PLAYATKCUE = 206
BattleConst.MATRIX_EVENT_ENTITY_SETMANA = 207
BattleConst.MATRIX_EVENT_ENTITY_LOCK_TARGET = 208
BattleConst.MATRIX_EVENT_ENTITY_PLAY_EFFECT = 209
BattleConst.MATRIX_EVENT_ENTITY_PLAY_CAMERA = 210
BattleConst.MATRIX_EVENT_ENTITY_SHIELD_CHANGE = 211
BattleConst.MATRIX_EVENT_ENTITY_DEAD = 212
BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN = 214
BattleConst.MATRIX_EVENT_ENTITY_SKILL_END = 215
BattleConst.MATRIX_EVENT_ENTITY_SKILL_JUMP = 216
BattleConst.MATRIX_EVENT_ENTITY_SKILL_BACK = 217
BattleConst.MATRIX_EVENT_ENTITY_HITED_AIM = 218
BattleConst.MATRIX_EVENT_ENTITY_MOVE = 219
BattleConst.MATRIX_EVENT_ENTITY_BEHAVIOR_ANIM = 220
BattleConst.MATRIX_EVENT_ENTITY_CACHE_SKILL = 221
BattleConst.MATRIX_EVENT_ENTITY_HITED_OFFSET = 222
BattleConst.MATRIX_EVENT_ENTITY_MOVE_TO = 223
BattleConst.MATRIX_EVENT_ENTITY_STATE_ENTER = 224
BattleConst.MATRIX_EVENT_ENTITY_STATE_EXIT = 225
BattleConst.MATRIX_EVENT_ENTITY_STATESHOW = 226
BattleConst.MATRIX_EVENT_ENTITY_SOMETHING = 227
BattleConst.MATRIX_EVENT_ENTITY_MANA_CHANGED = 228
BattleConst.MATRIX_EVENT_ENTITY_PLAYHITCUE = 229
BattleConst.MATRIX_EVENT_SUMMON_MONSTER = 230
BattleConst.MATRIX_EVENT_ENTITY_IDLE_ANIM = 231
BattleConst.MATRIX_EVENT_ENTITY_PLAY_ANIM = 232
BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE = 233
BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE_CANCEL = 234
BattleConst.MATRIX_EVENT_ADD_ENTITY = 235
BattleConst.MATRIX_EVENT_DEL_ENTITY = 236
BattleConst.MATRIX_EVENT_MONSTER_ENTER = 237
BattleConst.MATRIX_EVENT_ENTITY_SKILL_MOVIE = 238
BattleConst.MATRIX_EVENT_ENTITY_MOVE_OUT_POS = 239
BattleConst.MATRIX_EVENT_REBORN_ENTITY = 240
BattleConst.MATRIX_EVENT_REBORN_ENTITY_START = 241
BattleConst.MATRIX_EVENT_SPECIAL_DAMAGE_RECORD = 242
BattleConst.MATRIX_EVENT_CHANGE_CAMP = 243
BattleConst.ENTITY_STATE_HITED = 1
BattleConst.MATRIX_EVENT_OUTPUT_DICT = {
	[BattleConst.MATRIX_EVENT_ENTITY_DAMAGE] = Lang.get(29868),
	[BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE] = Lang.get(29869),
	[BattleConst.MATRIX_EVENT_ENTITY_ADDSTATE] = Lang.get(29870),
	[BattleConst.MATRIX_EVENT_ENTITY_DELSTATE] = Lang.get(29871)
}
BattleConst.BEHAVIOR_EVENT_ATTACK = "atk"
BattleConst.BEHAVIOR_EVENT_OFFSET = "offset"
BattleConst.BEHAVIOR_EVENT_CUE = "cue"
BattleConst.BEHAVIOR_EVENT_CAMERA = "camera"
BattleConst.BEHAVIOR_EVENT_VIDEO = "VideoPause"
BattleConst.BEHAVIOR_EVENT_SUPERCANCEL = "supercancel"
BattleConst.BEHAVIOR_EVENT_COMEBACK = "comeback"
BattleConst.BEHAVIOR_EVENT_CHASE = "chase"
BattleConst.BEHAVIOR_EVENT_AUTOCONTINUE = "AutoContinue"
BattleConst.BEHAVIOR_EVENT_SKILLEND = "SkillEnd"
BattleConst.BEHAVIOR_EVENT_TOIDLE = "ToIdle"
BattleConst.BEHAVIOR_EVENT_LOGICSKILLEND = "LogicSkillEnd"
BattleConst.BEHAVIOR_EVENT_FLOATTAG = "floattag"
BattleConst.BEHAVIOR_EVENT_OVERKILL = "overkill"
BattleConst.BEHAVIOR_END = "BehaviorEnd"
BattleConst.BEHAVIOR_EVENT_TO_IDLE_ANIM = "toIdleAnim"
BattleConst.BEHAVIOR_EVENT_CLIENT_ANIM = "PlayAnim"
BattleConst.UI_EVENT_SELECT_CARD = "UISelectCard"
BattleConst.EVENT_MAP = {
	PlayAnim = BattleConst.BEHAVIOR_NOTICE_EVENT,
	toIdleAnim = BattleConst.BEHAVIOR_NOTICE_EVENT,
	atk = BattleConst.BEHAVIOR_NOTICE_EVENT,
	supercancel = BattleConst.BEHAVIOR_NOTICE_EVENT,
	offset = BattleConst.BEHAVIOR_NOTICE_EVENT,
	cue = BattleConst.BEHAVIOR_NOTICE_EVENT,
	camera = BattleConst.BEHAVIOR_NOTICE_EVENT,
	comeback = BattleConst.BEHAVIOR_NOTICE_EVENT,
	chase = BattleConst.BEHAVIOR_NOTICE_EVENT,
	SkillEnd = BattleConst.BEHAVIOR_NOTICE_EVENT,
	ToIdle = BattleConst.BEHAVIOR_NOTICE_EVENT,
	LogicSkillEnd = BattleConst.BEHAVIOR_NOTICE_EVENT,
	floattag = BattleConst.BEHAVIOR_NOTICE_EVENT,
	overkill = BattleConst.BEHAVIOR_NOTICE_EVENT,
	BehaviorEnd = BattleConst.BEHAVIOR_NOTICE_EVENT,
	[BattleConst.BEHAVIOR_EVENT_VIDEO] = BattleConst.BEHAVIOR_NOTICE_EVENT,
	effect = BattleConst.BEHAVIOR_IGNORE,
	audio = BattleConst.BEHAVIOR_IGNORE
}
BattleConst.BATTLE_OVER_WIN = 1
BattleConst.BATTLE_OVER_LOSE = 2
BattleConst.BATTLE_OVER_TIME_OUT = 3
BattleConst.BOX_TYPE_STATIC = 0
BattleConst.BOX_TYPE_THROW = 1
BattleConst.DAMAGE_TYPE_HURT = 0
BattleConst.DAMAGE_TYPE_HEAL = 1
BattleConst.DAMAGE_TYPE_SHIELD = 2
BattleConst.DAMAGE_TYPE_VAMPIRE = 3
BattleConst.DAMAGE_TYPE_LINK = 4
BattleConst.DAMAGE_TYPE_MISS = 5
BattleConst.DAMAGE_TYPE_REBOUND = 6
BattleConst.DAMAGE_TYPE_DISPEL_SHIELD = 7
BattleConst.DAMAGE_TYPE_HP_REMOVE = 8
BattleConst.DAMAGE_TYPE_HP_SHIELD_REMOVE = 9
BattleConst.DAMAGE_TYPE_SELF_HEAL = 10
BattleConst.DAMAGE_TYPE_HURT_ICE = 11
BattleConst.DAMAGE_TYPE_HURT_FIRE = 12
BattleConst.DAMAGE_TYPE_HURT_IMMUE = 13
BattleConst.HURT_DICT = {
	[BattleConst.DAMAGE_TYPE_HURT] = true,
	[BattleConst.DAMAGE_TYPE_HURT_ICE] = true,
	[BattleConst.DAMAGE_TYPE_HURT_FIRE] = true
}
BattleConst.CAMP_BLUE = "kBattleFormationCampTypeBlue"
BattleConst.CAMP_RED = "kBattleFormationCampTypeRed"
BattleConst.CAMP_MONSTER = BattleConst.CAMP_RED
BattleConst.CAMP_PLAYER = BattleConst.CAMP_BLUE
BattleConst.MAX_COMMON_MONSTER_NUMBER = 100
BattleConst.ROLE_ATTRNAME_CONFIG = {
	life_reply = Lang.get(12031),
	atk = Lang.get(12006),
	atk_percent = Lang.get(29872),
	p_def = Lang.get(1084),
	m_def = Lang.get(29873),
	p_def_percent = Lang.get(29874),
	m_def_percent = Lang.get(29875),
	arp_percent = Lang.get(29876),
	spp_percent = Lang.get(29877),
	mhp = Lang.get(29878),
	mhp_percent = Lang.get(29879),
	hit_rate = Lang.get(29880),
	cri_rate = Lang.get(29881),
	cri_reduce = Lang.get(29882),
	cri_dmg = Lang.get(939),
	cri_dmg_reduce = Lang.get(29883),
	miss = Lang.get(29884),
	effect_hit = Lang.get(12024),
	effect_miss = Lang.get(12025),
	damage_percent = Lang.get(29885),
	damage_reduce_percent = Lang.get(29886),
	heal_effect = Lang.get(12026),
	heal_enhance_percent = Lang.get(12028),
	attack_speed_up = Lang.get(29887),
	mana_gen = Lang.get(29888),
	e_atk = Lang.get(29889),
	e_atk_percent = Lang.get(29890),
	star_atk_percent = Lang.get(29891),
	e_p_def = Lang.get(29892),
	e_m_def = Lang.get(29893),
	e_def = Lang.get(29894),
	e_p_def_percent = Lang.get(29895),
	e_m_def_percent = Lang.get(29896),
	e_def_percent = Lang.get(29897),
	e_mhp = Lang.get(29898),
	e_mhp_percent = Lang.get(29899),
	star_mhp_percent = Lang.get(29900),
	assist_enhance = Lang.get(12004),
	ice_damage = Lang.get(29901),
	ice_damage_reduce = Lang.get(13434),
	fire_damage = Lang.get(29902),
	fire_damage_reduce = Lang.get(29903)
}
BattleConst.STATE_PROP_SHOW = {
	life_reply = {
		14,
		114
	},
	atk = {
		9,
		109
	},
	atk_percent = {
		9,
		109
	},
	p_def = {
		16,
		116
	},
	m_def = {
		13,
		113
	},
	p_def_percent = {
		16,
		116
	},
	m_def_percent = {
		13,
		113
	},
	mhp = {
		17,
		117
	},
	mhp_percent = {
		17,
		117
	},
	hit_rate = {
		nil,
		2
	},
	cri_rate = {
		10,
		110
	},
	cri_dmg = {
		25,
		125
	},
	damage_percent = {
		12,
		112
	},
	attack_speed_up = {
		11,
		111
	},
	silence = {
		nil,
		4
	},
	vampirePercent = {
		18,
		118
	},
	soulLink = {
		6
	},
	heal_enhance_percent = {
		22,
		122
	},
	mana_gen = {
		15,
		115
	},
	fire_damage_reduce = {
		24,
		124
	},
	ice_damage_reduce = {
		23,
		123
	}
}
BattleConst.STATE_SHOW_STUN = 3
BattleConst.STATE_SHOW_IMMUNE = 8
BattleConst.STATE_SHOW_KILL = 201
BattleConst.STATE_SHOW_SHIELD = 300
BattleConst.STATE_SHOW_MISS = 203
BattleConst.STATE_SHOW_IMMUE_PHYSICS = 204
BattleConst.STATE_SHOW_IMMUE_MAGIC = 205
BattleConst.STATE_SHOW_FREEZE = 211
BattleConst.STATE_SHOW_IMMUNE_DISARM = 206
BattleConst.STATE_SHOW_IMMUNE_SILENCE = 207
BattleConst.STATE_SHOW_IMMUNE_CONTROL = 208
BattleConst.STATE_SHOW_IMMUNE_REDUCE_MANA = 209
BattleConst.STATE_SHOW_FLOAT = 213
BattleConst.STATE_SHOW_BLOCK = 214
BattleConst.STATE_SHOW_SLEEP = 218
BattleConst.STATE_SHOW_TIME_LOCK = 217
BattleConst.PROP_TYPE_CONFIG = {
	"atk",
	"atk_percent",
	"cri_rate",
	"cri_dmg",
	"mhp",
	"mhp_percent",
	"p_def",
	"p_def_percent",
	"m_def",
	"m_def_percent",
	"e_atk",
	"e_atk_percent",
	"e_mhp",
	"e_mhp_percent",
	"e_p_def",
	"e_p_def_percent",
	"e_m_def",
	"e_m_def_percent",
	"star_atk_percent",
	"star_mhp_percent",
	nil,
	nil,
	"assist_enhance",
	"e_def",
	"e_def_percent",
	"effect_hit",
	"damage_percent",
	"damage_reduce_percent"
}
BattleConst.ENTITY_SOMETHING_DEL_STATE = "delState"
BattleConst.ENTITY_SOMETHING_IMMUE_PHYSICS = "immuPhysics"
BattleConst.ENTITY_SOMETHING_IMMUE_MAGIC = "immuMagic"
BattleConst.ENTITY_SOMETHING_KILL_SOMEONE = "killOne"
BattleConst.STATE_DAMAGE_REBOUND = "reboundInjury"
BattleConst.STATE_DAMAGE_IMMUNE = "damageImmune"
BattleConst.STATE_PHYSICS_IMMUNE = "physicsImmune"
BattleConst.STATE_MAGIC_IMMUNE = "magicImmune"
BattleConst.STATE_SILENCE = "silence"
BattleConst.STATE_VAMPIRE_PERCENT = "vampirePercent"
BattleConst.STATE_IMMUNE_SILENCE = "immuneSilence"
BattleConst.STATE_IMMUNE_TAUNT = "immuneTaunt"
BattleConst.STATE_IMMUNE_REDUCE_MANA = "immuneReduceMana"
BattleConst.STATE_IMMUNE_DEBUFF = "immuneDebuff"
BattleConst.STATE_UNDEAD = "unDead"
BattleConst.STATE_RANGE_CHANGE = "rangeChange"
BattleConst.STATE_LINK = "soulLink"
BattleConst.STATE_DISARM = "disarm"
BattleConst.STATE_IMMUNE_DISARM = "immuneDisarm"
BattleConst.STATE_IMMUNE_CONTROLLED = "immuneControlled"
BattleConst.STATE_SHIELD_ENHANCE = "shieldEnhance"
BattleConst.STATE_BE_SHIELD_ENHANCE = "beShieldEnhance"
BattleConst.STATE_BLOCK_RATE = "blockRate"
BattleConst.STATE_OVERCOME_ADD = "campOvercomeAdd"
BattleConst.STATE_BE_OVERCOME_ADD = "beCampOvercomeAdd"
BattleConst.STATE_ONCE_HURT_PERCENT = "onceMaxHurtPercent"
BattleConst.STATE_CONTROLLED_RESIST = "controlledResist"
BattleConst.STATE_CHANGE_CAMP = "changeCamp"
BattleConst.STATE_IMMUNE_CHANGE_CAMP = "immuneChangeCamp"
BattleConst.STATE_CALC_ATTR = {
	reboundInjury = Lang.get(29904),
	damageImmune = Lang.get(29905),
	physicsImmune = Lang.get(29906),
	magicImmune = Lang.get(29907),
	silence = Lang.get(13442),
	vampirePercent = Lang.get(29908),
	immuneSilence = Lang.get(29909),
	immuneTaunt = Lang.get(29910),
	immuneReduceMana = Lang.get(29911),
	immuneDebuff = Lang.get(29912),
	unDead = Lang.get(6022),
	rangeChange = Lang.get(29913),
	soulLink = Lang.get(29914),
	disarm = Lang.get(13444),
	immuneDisarm = Lang.get(29915),
	immuneControlled = Lang.get(29916),
	shieldEnhance = Lang.get(29917),
	beShieldEnhance = Lang.get(29918),
	blockRate = Lang.get(29919),
	campOvercomeAdd = Lang.get(29920),
	beCampOvercomeAdd = Lang.get(29921),
	onceMaxHurtPercent = Lang.get(29922),
	controlledResist = Lang.get(29923),
	changeCamp = Lang.get(52400),
	immuneChangeCamp = Lang.get(52401)
}
BattleConst.SKILL_TARGET_CA = 0
BattleConst.SKILL_TARGET_SELF = 1
BattleConst.SKILL_TARGET_CA_LINE_FAREST = 2
BattleConst.SKILL_TARGET_MIN_HP_FRIEND = 3
BattleConst.SKILL_TARGET_MIN_HP_ENEMY = 4
BattleConst.SKILL_TARGET_CA_IGNORE_BIG = 5
BattleConst.TARGET_TARGET_AND_ENEMY = 0
BattleConst.TARGET_TARGET_AND_FRIEND = 1
BattleConst.TARGET_SELF_AND_ENEMY = 2
BattleConst.TARGET_SELF_AND_FRIEND = 3
BattleConst.TARGET_FRIEND = 4
BattleConst.TARGET_ENEMY = 5
BattleConst.TARGET_CHOOSE_ONE = 0
BattleConst.TARGET_CHOOSE_ONE_AND_BACK = 1
BattleConst.TARGET_CHOOSE_ONE_AND_LR = 2
BattleConst.TARGET_CHOOSE_ONE_AND_NEAR = 3
BattleConst.TARGET_CHOOSE_ONE_LINE = 4
BattleConst.TARGET_CHOOSE_ONE_LINE_AND_NEAR = 5
BattleConst.TARGET_CHOOSE_ONE_ROW = 6
BattleConst.TARGET_CHOOSE_ALL = 7
BattleConst.TARGET_CHOOSE_MIN_HP = 8
BattleConst.TARGET_CHOOSE_LINE_FAREST = 9
BattleConst.TARGET_CHOOSE_ALL_HERO = 10
BattleConst.TARGET_CHOOSE_MIN_HP_HERO = 11
BattleConst.TARGET_CHOOSE_USE_SKILL_RECORDER = 12
BattleConst.TARGET_CHOOSE_MIN_HP_PERCENT = 13
BattleConst.TARGET_CHOOSE_MIN_HP_PERCENT_HERO = 14
BattleConst.TARGET_CHOOSE_BASE_MASTER = 15
BattleConst.TARGET_CHOOSE_ALL_SERVANT = 16
BattleConst.TARGET_CHOOSE_MY_SERVANT = 17
BattleConst.TARGET_CHOOSE_LINE_FRONT = 18
BattleConst.TARGET_CHOOSE_ALL_FRONT = 19
BattleConst.TARGET_CHOOSE_ALL_BACK = 20
BattleConst.TARGET_CHOOSE_ONE_AND_NEAR_TWO = 21
BattleConst.TARGET_CHOOSE_ONE_AND_LINE_BACK = 22
BattleConst.TARGET_CHOOSE_NEW_TARGET = 23
BattleConst.TARGET_CHOOSE_DEAD_HERO = 24
BattleConst.TARGET_CHOOSE_ALL_LINE_FAREST = 25
BattleConst.EFFECT_MODE = {
	Screen = 3,
	Parabola = 1,
	Link = 2,
	Normal = 0
}
BattleConst.CUE_PLAY_MODE = {
	LoopTimes = 1,
	Always = 3,
	PlayLength = 0,
	LogicControl = 2
}
BattleConst.PASSIVE_TRIGGER_TYPE_HP_CHANGE = 1
BattleConst.PASSIVE_TRIGGER_TYPE_USE_CARD = 2
BattleConst.PASSIVE_TRIGGER_TYPE_ATTACK_RESULT = 3
BattleConst.PASSIVE_TRIGGER_TYPE_IMMEDIATELY = 4
BattleConst.PASSIVE_TRIGGER_TYPE_BEING_ATTACKED_RESULT = 5
BattleConst.PASSIVE_TRIGGER_TYPE_SHIELD = 6
BattleConst.PASSIVE_TRIGGER_TYPE_DEAD = 7
BattleConst.PASSIVE_TRIGGER_TYPE_GAME_WIN = 8
BattleConst.PASSIVE_TRIGGER_TYPE_SIMPLE_EVENT = 9
BattleConst.PASSIVE_TRIGGER_TYPE_USE_CARD_END = 10
BattleConst.PASSIVE_TRIGGER_ATTACK_HIT_RESULT = 1
BattleConst.PASSIVE_TRIGGER_ATTACK_DISPEL = 2
BattleConst.PASSIVE_TRIGGER_ATTACK_STATE = 3
BattleConst.PASSIVE_TRIGGER_ATTACK_KILL = 4
BattleConst.PASSIVE_TRIGGER_ATTACK_MANA = 5
BattleConst.PASSIVE_TRIGGER_ATTACK_CONTROLLED = 6
BattleConst.PASSIVE_TRIGGER_SPECIAL_DAMAGE = 7
BattleConst.PASSIVE_TRIGGER_SIMPLE_EVENT_SKILL = 1
BattleConst.PASSIVE_TRIGGER_SIMPLE_EVENT_SUMMON = 2
BattleConst.PASSIVE_TRIGGER_SIMPLE_MANA_ZERO = 3
BattleConst.PASSIVE_TRIGGER_SIMPLE_PLAYER_NUM = 4
BattleConst.PASSIVE_TRIGGER_SIMPLE_EVENT_REBORN = 5
BattleConst.MAX_MANA = 100
BattleConst.STATE_INVALID_TYPE_CARD_NO_CA = 1
BattleConst.STATE_INVALID_TYPE_CARD = 2
BattleConst.STATE_INVALID_TYPE_CARD_CA = 3
BattleConst.STATE_INVALID_TYPE_BE_HURT = 4
BattleConst.DEFAULT_ATTACK_CD = 2
BattleConst.STATE_PROP_PREFIX = "sProp_"
BattleConst.STATE_TYPE_BUFF = 1
BattleConst.STATE_TYPE_DEBUFF = 2
BattleConst.STATE_TYPE_ALL = 0
BattleConst.STATE_DURATION_UNLIMIT = -999
BattleConst.STATE_DURATION_UNLIMIT_FRAME = 9999
BattleConst.ATTACK_CA = "pugong"
BattleConst.ATTACK_SKILL = "jineng"
BattleConst.ATTACK_TRIGGER = "chufa"
BattleConst.SPECIAL_ID_COMMON_ATTACK = 1
BattleConst.SPECIAL_ID_ANY_SKILL = 0
BattleConst.SPECIAL_ID_EXCEPT_COMMON_ATTACK = -1
BattleConst.SKILL_CONFIG_CA = 0
BattleConst.SKILL_CONFIG_SKILL = 1
BattleConst.SKILL_CONFIG_TRIGGER = 2
BattleConst.BATTLE_TYPE_NONE = "kBattleTypeNone"
BattleConst.BATTLE_TYPE_STAGE = "kBattleTypeStage"
BattleConst.BATTLE_TYPE_STEPTOWER = "kBattleTypeTower"
BattleConst.BATTLE_TYPE_EQUIPTOWER = "kBattleTypeEquipTower"
BattleConst.BATTLE_TYPE_BOSSTOWER = "kBattleTypeBossTower"
BattleConst.BATTLE_TYPE_ONCETOWER = "kBattleTypeOnceTower"
BattleConst.BATTLE_TYPE_ASYNC_PVP = "kBattleTypeAsyncPVP"
BattleConst.BATTLE_TYPE_BEGINNER = "kBattleTypeNewbie"
BattleConst.BATTLE_TYPE_MAZE = "kBattleTypeMaze"
BattleConst.BATTLE_TYPE_NEW_MAZE = "kBattleTypeNewMaze"
BattleConst.BATTLE_TYPE_THREE_TEAM_PVP = "kBattleTypeMultiPVP"
BattleConst.BATTLE_TYPE_ACTIVITY = "kBattleTypeOpActPlot"
BattleConst.BATTLE_TYPE_WORLD_BOSS = "kBattleTypeWorldBoss"
BattleConst.BATTLE_TYPE_OPACT_PVP = "kBattleTypeOpActArena"
BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH = "kBattleTypeBPPvpGroup"
BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT = "kBattleTypeBPPvpKnockout"
BattleConst.BATTLE_TYPE_SEASON_TOWER = "kBattleTypeOpActTower"
BattleConst.BATTLE_TYPE_RENT = "kBattleTypeRent"
BattleConst.BATTLE_TYPE_CIRCLE = "kBattleTypeClan"
BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND = "kBattleTypeCampTower"
BattleConst.BATTLE_TYPE_MAZE_PET = "kBattleTypePetMaze"
BattleConst.BATTLE_TYPE_SNEAK_BATTLE = "kBattleTypeNewPve"
BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM = "kBattleTypeDefendThreeTeam"
BattleConst.FORMATION_TYPE_ASYNC_PVP = "async_pvp"
BattleConst.FORMATION_TYPE_OPACT_PVP = "opact_pvp"
BattleConst.FORMATION_TYPE_RENT_DEFEND = "rent"
BattleConst.FORMATION_TYPE_TOP_PVP = "kCSFormationsTypeBPPvpDefend"
BattleConst.FORMATION_TYPE_TOP_PVP_KNOCKOUT = "topPvpKnockoutFormation"
BattleConst.HIDE_WEAR_TYPE = {
	BattleConst.BATTLE_TYPE_STEPTOWER,
	BattleConst.BATTLE_TYPE_CIRCLE,
	BattleConst.BATTLE_TYPE_ACTIVITY,
	BattleConst.BATTLE_TYPE_NEW_MAZE
}
BattleConst.PVP_BATTLE_DICT = {
	[BattleConst.BATTLE_TYPE_ASYNC_PVP] = true,
	[BattleConst.BATTLE_TYPE_THREE_TEAM_PVP] = true,
	[BattleConst.BATTLE_TYPE_OPACT_PVP] = true,
	[BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH] = true,
	[BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT] = true
}
BattleConst.THREE_ROUND_BATTLE_TYPE = {
	[BattleConst.BATTLE_TYPE_THREE_TEAM_PVP] = true,
	[BattleConst.BATTLE_TYPE_OPACT_PVP] = true,
	[BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH] = true,
	[BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT] = true
}
BattleConst.AUTO_SYNC_BATTLE = {
	[BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT] = true
}
BattleConst.HOUSE_BUFF_MODE_MAP = {
	{
		type = BattleConst.BATTLE_TYPE_STAGE,
		name = Lang.get(29924)
	},
	{
		type = BattleConst.BATTLE_TYPE_STEPTOWER,
		name = Lang.get(1460)
	},
	{
		type = BattleConst.BATTLE_TYPE_EQUIPTOWER,
		name = Lang.get(1001)
	},
	{
		type = BattleConst.BATTLE_TYPE_BOSSTOWER,
		name = Lang.get(727)
	},
	{
		type = BattleConst.BATTLE_TYPE_ASYNC_PVP,
		name = Lang.get(29925)
	},
	{
		type = BattleConst.BATTLE_TYPE_ONCETOWER,
		name = Lang.get(1462)
	},
	[8] = {
		type = BattleConst.BATTLE_TYPE_MAZE,
		name = Lang.get(1461)
	},
	[9] = {
		type = BattleConst.BATTLE_TYPE_THREE_TEAM_PVP,
		name = Lang.get(29926)
	},
	[10] = {
		type = BattleConst.BATTLE_TYPE_WORLD_BOSS,
		name = Lang.get(1447)
	},
	[12] = {
		type = BattleConst.BATTLE_TYPE_OPACT_PVP,
		name = Lang.get(29927)
	},
	[13] = {
		type = BattleConst.BATTLE_TYPE_SEASON_TOWER,
		name = Lang.get(1445)
	}
}
BattleConst.CHECK_REPLAY_RECORD = {
	[BattleConst.BATTLE_TYPE_STAGE] = {
		campRecord = true,
		specialDlg = false
	},
	[BattleConst.BATTLE_TYPE_ONCETOWER] = {
		campRecord = true,
		specialDlg = false
	},
	[BattleConst.BATTLE_TYPE_WORLD_BOSS] = {
		campRecord = true,
		specialDlg = true
	},
	[BattleConst.BATTLE_TYPE_ASYNC_PVP] = {
		campRecord = true,
		specialDlg = false
	},
	[BattleConst.BATTLE_TYPE_THREE_TEAM_PVP] = {
		campRecord = false,
		specialDlg = true
	},
	[BattleConst.BATTLE_TYPE_OPACT_PVP] = {
		campRecord = false,
		specialDlg = true
	},
	[BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND] = {
		campRecord = true,
		specialDlg = false
	}
}
BattleConst.BATTLE_RESULT_WIN = "kPVEResultResultTypeWin"
BattleConst.BATTLE_RESULT_LOSE = "kPVEResultResultTypeLose"
BattleConst.BATTLE_RESULT_SURRENDER = "kPVEResultResultTypeSurrender"
BattleConst.BATTLE_RESULT_TIME_OUT = "kPVEResultResultTypeTimeOut"
BattleConst.BATTLE_RESULT_LEAVE = "kPVEResultResultTypeLeave"
BattleConst.BATTLE_SHOW_TIME_SCALE = 0.3
BattleConst.BATTLE_SHOW_TIME = 0.5
BattleConst.ZOMBIE_DIE_TIME = 4
BattleConst.INFO_LEVEL_KEY = "InfoLevel"
BattleConst.INFO_LEVEL_MIN = "min"
BattleConst.INFO_LEVEL_MIDDLE = "middle"
BattleConst.INFO_LEVEL_DEFAULT = BattleConst.INFO_LEVEL_MIN
BattleConst.INFO_SHOW_TIPS = "tips"
BattleConst.INFO_SHOW_MENU_BG = "menuBg"
BattleConst.INFO_SHOW_QUICK_BTN = "quickBtn"
BattleConst.MANUAL_KEY = "Manual"
BattleConst.SPEED_KEY = "Speed"
BattleConst.EXTRA_SPEED_KEY = "ExtraSpeed"
BattleConst.SPEED_NORMAL = "SpeedNormal"
BattleConst.SPEED_UP1 = "SpeedUp1"
BattleConst.SPEED_UP2 = "SpeedUp2"
BattleConst.SPEED_UP3 = "SpeedUp3"
BattleConst.SHORT_SKILL_KEY = "ShortSkill"
BattleConst.BATTLE_CAMERA_MODE_KEY = "BattleCameraMode"
BattleConst.BATTLE_CAMERA_MODE_RECORD = "BattleCameraRecord"
BattleConst.BATTLETYPE_DATA_MAP = {
	[BattleConst.BATTLE_TYPE_STAGE] = "stageData",
	[BattleConst.BATTLE_TYPE_STEPTOWER] = "stepTowerData"
}
BattleConst.ASSIST_TYPE_LINE = 0
BattleConst.ASSIST_TYPE_NEB_ALL = 1
BattleConst.ASSIST_TYPE_NEB_THREE = 2
BattleConst.ASSIST_TYPE_NEB_TWO = 3
BattleConst.ASSIST_TYPE_ALL = 4
BattleConst.MAX_COMMON_MONSTER_NUMBER = 1000
BattleConst.BATTLE_OVER_HEROS_ENTITY_ID = 500000
BattleConst.ANIM_ACTOR_START_ID = 501000
BattleConst.SHOW_ACTOR_ID_START = 600000
BattleConst.PERFORM_ACTOR_START = 700000
BattleConst.DRAG_OBJECT_START = 900000
BattleConst.PET_ENTITY_START = 510000

local ResClientMacro = require("ClientData/ResClientMacro")

BattleConst.BATTLE_ARMOR_ARG1 = ResClientMacro[1].args[1].value
BattleConst.BATTLE_ARMOR_ARG2 = ResClientMacro[1].args[2].value
BattleConst.KILL_MANA = ResClientMacro[1].args[3].value
BattleConst.BLOCK_REDUCE = 1 - ResClientMacro[1].args[4].value * 0.0001
BattleConst.NEAR_CLIP_PLANE = 1
BattleConst.FAR_CLIP_PLANE = 2000
BattleConst.FORMATION_DEFAULT_NUM = 5
BattleConst.BATTLE_MAX_POS = 12
BattleConst.BATTLE_MAX_TRAP_INIT_NUM = 9
BattleConst.SPECIAL_BATTLE_HOOK = 1
BattleConst.SPECIAL_BATTLE_SUN_FLOWER = 2
BattleConst.HERO_CAMP_OVERCOME = {
	2,
	3,
	1,
	5,
	4
}
BattleConst.OVERCOME_VALUE = 0.25
BattleConst.DEFAULT_MONSTER_DYNAMIC_INDEX = 101
BattleConst.QUICK_MODE_MAX_FRAME = 72000
BattleConst.CAMERA_DEFAULT_FADE_DURATION = 0.5
BattleConst.CAMERA_MAZZ_FADE_DURATION = 0.8
BattleConst.HIDE_FORMATION_MONSTER_ID = 4100100
BattleConst.EMPTY_BATTLE_NO = 10001
BattleConst.SKILL_PAUSE_EFF_GROUP = -2

return BattleConst
