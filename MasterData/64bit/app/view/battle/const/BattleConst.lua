local var_0_0 = {
	SPINE_ACTION_TYPE = {
		FALL2 = "fall2",
		HIT2 = "hit2",
		FALL = "fall",
		JUMP = "jump",
		FLY = "fly",
		PLAY_ENTER_L = "play_enter_l",
		OUT = "out",
		IN = "in",
		PLAY = "play",
		BACK = "back",
		RUN = "run",
		PLAY_OUT_R = "play_out_r",
		LOSE = "failure",
		PLAY_OUT_L = "play_out_l",
		WIN = "show",
		PLAY_NUMBER_R = "play_number_r",
		ATTACK = "attack",
		PLAY_NUMBER_L = "play_number_l",
		SKILL = "skill",
		PLAY_NUMBER = "play_number",
		HIT = "hit",
		PLAY_ENTER_R = "play_enter_r",
		DEAD = "dead",
		MOVE = "move",
		IDLE = "idle",
		READY = "ready"
	},
	SPINE_EVENT = {
		COMPLETE = "complete"
	},
	SPINE_TYPE = {
		BASE = 1,
		GAME = 5,
		TWEEN = 4,
		EFFECT = 3,
		KNIGHT = 2
	},
	SPINE_TWEEN_SLOT = {
		WORD = "word_slot",
		NORMAL = "txt_slot",
		ADD = "txt_slot2"
	}
}

var_0_0.SHOW_WORD_REPORT = false
var_0_0.DEBUG = true
var_0_0.SHOWPAUSE = true
var_0_0.FUNCTION_DEBUG = false

if device.isWindowsDebug() then
	var_0_0.DEBUG = true
	var_0_0.SKIP_ENABLE = true
	var_0_0.FUNCTION_DEBUG = false
else
	var_0_0.DEBUG = false
	var_0_0.SKIP_ENABLE = false
	var_0_0.FUNCTION_DEBUG = false
end

var_0_0.FONT = FONT_PATH
var_0_0.FONT_TITLE_PATH = FONT_TITLE_PATH
var_0_0.BATTLE_TYPE = {
	PVE = 1,
	VIDEO = 3,
	PVP = 2
}
var_0_0.SKIP_TYPE = {
	HIDE = 0,
	WAIT = 3,
	ACTIVE = 2,
	CANT_SKIP = 1
}
var_0_0.HIDE_TYPE = {
	SHOW_FRIENDALL_DEF = 6,
	SHOW_ATK_ENEMYALL = 5,
	SHOW_FRIENDALL = 4,
	SHOW_ENEMYALL = 3,
	SHOW_ATK_DEF = 2,
	SHOW_ATK = 1
}
var_0_0.IDENTITY = {
	MYSELF = 1,
	ENEMY = 2
}
var_0_0.SHOW_TYPE = {
	UP_ENEMYALL = 5,
	UP_FRIENDALL = 4,
	UP_ATK_DEF = 3,
	UP_DEF = 2,
	UP_ATK = 1
}
var_0_0.TYPE_DUNGEON = 1
var_0_0.TYPE_ARENA = 2
var_0_0.TYPE_WUSH = 3
var_0_0.TYPE_TREASURE = 4
var_0_0.TYPE_REBEL = 5
var_0_0.TYPE_BIO = 6
var_0_0.TYPE_BIOTEAM = 7
var_0_0.TYPE_DAILY = 8
var_0_0.TYPE_GUILD = 9
var_0_0.TYPE_BIOBOSS = 10
var_0_0.TYPE_STORM = 11
var_0_0.TYPE_STORM_CITY = 12
var_0_0.TYPE_GUILD_BOSS = 13
var_0_0.TYPE_GUILD_BOSS_ROB = 14
var_0_0.TYPE_PEAK_ARENA_PVP = 17
var_0_0.TYPE_NIGHTMARE_PVE = 18
var_0_0.TYPE_GUILDFIGHT_PVP = 19
var_0_0.TYPE_GUILDFIGHT_BOSS_PVP = 20
var_0_0.TYPE_FRIEND_PVP = 21
var_0_0.TYPE_GAME_START = 22
var_0_0.TYPE_DEMON_BOSS = 23
var_0_0.TYPE_THEME_DUNGEON = 24
var_0_0.TYPE_TOWER = 25
var_0_0.TYPE_MINE = 26
var_0_0.TYPE_THEME_EXPLORE = 27
var_0_0.TYPE_GUILDWAR = 28
var_0_0.TYPE_FOG_NIGHTMARE = 30
var_0_0.TYPE_GVE_BASE = 31
var_0_0.TYPE_GVE_BOSS = 32
var_0_0.TYPE_THEME_BIO = 33
var_0_0.TYPE_WUSH_TOWER = 34
var_0_0.TYPE_CROSS_SERVER_ARENA = 35
var_0_0.TYPE_EXPLORATION = 36
var_0_0.TYPE_RED_CLIFF = 37
var_0_0.TYPE_BOUNTY = 38
var_0_0.TYPE_MYSTERY = 39
var_0_0.TYPE_MYSTERY_BOSS = 40
var_0_0.TYPE_RICHMAN_MONSTER = 41
var_0_0.TYPE_RICHMAN_ROB = 42
var_0_0.TYPE_TEAM_BATTLE = 43
var_0_0.TYPE_ALLIANCE_TRIAL = 44
var_0_0.TYPE_BLAZING_ARENA = 45
var_0_0.TYPE_SPIRE_NORMAL = 46
var_0_0.TYPE_SPIRE_BOSS = 47
var_0_0.TYPE_ELDER_BOSS = 48
var_0_0.TYPE_DOMAIN_STAGE = 49
var_0_0.UNITE_SKILL_NUM = 4
var_0_0.SUCCUBA_SKILL_NUM = 3
var_0_0.AUTO_TIPS_NUM = 8
var_0_0.SPEED_CONTROL = {
	LV3 = 3,
	LV2 = 2,
	LV1 = 1
}
var_0_0.AUTO_CONTROL = {
	AUTO = 4
}
var_0_0.TIPS_CONTROL = {
	AUTO = 0,
	PAUSE = 1
}
var_0_0.FIRST_CONTROL = {
	RIGHT = 2,
	LEFT = 1,
	NONE = 0
}
var_0_0.SPINE_ACTION_FRAME = {
	IN = 20,
	JUMP = 12,
	FALL = 17,
	FLY = 10,
	OUT = 20,
	HIT = 13,
	DEAD = 30,
	BACK = 6,
	IDLE = 60,
	RUN = 24
}
var_0_0.SUCCUBA_PARAM = {
	SKILL_ADD_ENERGY = 102,
	NORMAL_SKILL_ADD_ENERGY = 101,
	MAX_ENERGY_VALUE = 106,
	INIT_ENERGY_VALUE = 105,
	ROUND_RECOVER_ENERGY_MAX = 104,
	KILL_SKILL_ADD_ENERGY = 103
}
var_0_0.TWEEN_TYPE = {
	PURE_WORD = 2,
	PURE_NUMBER = 1,
	DEFAULT = 0,
	MARK_TWEEN = 6,
	BUFF_TWEEN = 5,
	ICON_NUMBER_NOT_INLINE = 4,
	ICON_NUMBER_INLINE = 3
}
var_0_0.ServerPlayId = {
	PEAK_ARENA_MULTI = 3,
	PEAK_ARENA = 2,
	TOWER = 1,
	DEMON_BOSS = 5,
	EXPLORATION_BOSS = 4
}
var_0_0.MAX_BUFF_ICON_NUM = 4
var_0_0.BELONG_GROUP = {
	LIN_DONG = 4,
	LI_JIN = 3,
	JIAO_GUO = 2,
	DONG_XI = 1
}

return var_0_0
