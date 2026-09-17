require("config")
require("data.server_diff_constants")

SCREEN_WIDTH = 640
SCREEN_HEIGHT = 1136
MODEL_PLAYER_MODEL = "Lead_00.model.json"
LIVE2D_MODEL = MODEL_PLAYER_MODEL
MAINBG = "mainScenebg/mainbg.jpg"
UIBG = "mainScenebg/levelBg.jpg"
SETTINGBG = "mainScenebg/new_bugbg.jpg"
LOGINBG = "mainScenebg/loginBG1.jpg"
HORCRUXBG = "mainScenebg/hocruxbg.jpg"
CHAPTERBG = "mainScenebg/chapterbg.jpg"
ROLE_COVER_BG = "mainScenebg/role_cover.png"
FIGHT_BG_PATH = "mainScenebg/"
LABEL_BG = "mainScenebg/labelbg.jpg"
ROLEBG = "mainScenebg/roleBg.jpg"
TWISTBG = "mainScenebg/twistbg.jpg"
PHOTODETAILBG = "mainScenebg/albumbg.jpg"
SCHOOL_BG = "mainScenebg/school_bg.jpg"
DORM_BG = "mainScenebg/dormbg.jpg"
SCHOOL_NIGHT_BG = "mainScenebg/school_night_bg.jpg"
TASK_BG = "mainScenebg/task_bg.jpg"
DATABASEBG = "mainScenebg/equip_bg.jpg"
CHANGELAYER = "mainScenebg/help_girls_bg.jpg"
AREANBG = "mainScenebg/roledatabg.jpg"
VALENTINEBG = "mainScenebg/bg_valentine.jpg"
MARRYBG = "mainScenebg/marry_bg.jpg"
SUBSITUTIONBG = "mainScenebg/substitution_bg.jpg"
ACTIVITYBPBG = "mainScenebg/routine_bp_bg.jpg"
SWIM_BG = "mainScenebg/pool_bg.jpg"
ORDER_BG = "mainScenebg/order_bg.jpg"
CINEMA_BG = "mainScenebg/cinema_bg.png"
FILE_BG = "mainScenebg/school_file_bg.png"
BIRTHDAYPARTYBG = "mainScenebg/bg_birthday_party.png"
COMMON_CURRENCY_PATH = "public/currency/"
IMAGE_BLACK_CARD = COMMON_CURRENCY_PATH .. "1500001_1.png"
IMAGE_DIAMOND = COMMON_CURRENCY_PATH .. "UI_battleEnd_diamond.png"
IMAGE_CLOTHESTICKET = COMMON_CURRENCY_PATH .. "6800201.png"
IMAGE_HONOR = COMMON_CURRENCY_PATH .. "arenascene_dot.png"
IMAGE_GOLD = COMMON_CURRENCY_PATH .. "UI_battleEnd_gold.png"
IMAGE_MOONCAKE = COMMON_CURRENCY_PATH .. "9000001.png"
IMAGE_EXPLORECOIN = COMMON_CURRENCY_PATH .. "explorecoin.png"
IMAGE_QUICK_TICK = COMMON_CURRENCY_PATH .. "6800301.png"
IMAGE_STRENGTHPOINT = COMMON_CURRENCY_PATH .. "UI_strength_point.png"
IMAGE_SIGN_TICK = COMMON_CURRENCY_PATH .. "6800420.png"
STRING_COST_ENERGY = "消耗能量值:"
SINGLE_BUTTON = "public/button/public_button_big.png"
SINGLE_BUTTON_ON = "public/button/public_button_big_on.png"
SINGLE_YELLOW_BUTTON = "public/button/public_button_big_y.png"
SINGLE_YELLOW_BUTTON_ON = "public/button/public_button_big_y_on.png"
DOUBLE_BUTTON = "public/button/public_button_normal.png"
DOUBLE_BUTTON_ON = "public/button/public_button_normal_on.png"
DOUBLE_YELLOW_BUTTON = "public/button/public_button_normal_y.png"
DOUBLE_YELLOW_BUTTON_ON = "public/button/public_button_normal_y_on.png"
TRIPLE_BUTTON = "public/button/public_button_small.png"
TRIPLE_BUTTON_ON = "public/button/public_button_small_on.png"
TRIPLE_YELLOW_BUTTON = "public/button/public_button_small_y.png"
TRIPLE_YELLOW_BUTTON_ON = "public/button/public_button_small_y_on.png"
LARGE_PANEL_BG = "public/new/large_bg.png"
NORMAL_PANEL_BG = "public/new/normal_bg.png"
SMALL_PANEL_BG = "public/new/small_bg.png"
ATTR_IMAGE = {
	"public/part_bg/icon_wind.png",
	"public/part_bg/icon_fire.png",
	"public/part_bg/icon_water.png",
	"public/part_bg/icon_light.png",
	"public/part_bg/icon_dark.png"
}
N_SKILL_IMAGE = "public/n_bg.png"
R_SKILL_IMAGE = "public/r_bg.png"
SR_SKILL_IMAGE = "public/sr_bg.png"
SSR_SKILL_IMAGE = "public/ssr_bg.png"
UR_SKILL_IMAGE = "public/ur_bg.png"
RARITY_ICON = {
	"public/rarity/r_big.png",
	"public/rarity/sr_big.png",
	"public/rarity/ur_big.png",
	"public/rarity/mr_big.png",
	"public/rarity/sp_big.png",
	sr = "public/rarity/sr_big.png",
	mr = "public/rarity/mr_big.png",
	ur = "public/rarity/ur_big.png",
	r = "public/rarity/r_big.png",
	sp = "public/rarity/sp_big.png"
}
SMALL_RARITY_ICON = {
	"public/rarity/r_small.png",
	"public/rarity/sr_small.png",
	"public/rarity/ur_small.png",
	"public/rarity/mr_small.png",
	"public/rarity/sp_small.png",
	sr = "public/rarity/sr_small.png",
	mr = "public/rarity/mr_small.png",
	ur = "public/rarity/ur_small.png",
	r = "public/rarity/r_small.png",
	sp = "public/rarity/sp_small.png"
}
SHOT_RARITY_CION = {
	"public/rarity/r_short.png",
	"public/rarity/sr_short.png",
	"public/rarity/ur_short.png",
	"public/rarity/mr_short.png",
	"public/rarity/sp_short.png",
	sr = "public/rarity/sr_short.png",
	mr = "public/rarity/mr_short.png",
	ur = "public/rarity/ur_short.png",
	r = "public/rarity/r_short.png",
	sp = "public/rarity/sp_short.png"
}
RARITY_LONG_ICON = {
	"public/rarity/r_long.png",
	"public/rarity/sr_long.png",
	"public/rarity/ur_long.png",
	"public/rarity/mr_long.png",
	"public/rarity/sp_long.png",
	sr = "public/rarity/sr_long.png",
	mr = "public/rarity/mr_long.png",
	ur = "public/rarity/ur_long.png",
	r = "public/rarity/r_long.png",
	sp = "public/rarity/sp_long.png"
}
RARITY_LONG_LONG_ICON = {
	"public/rarity/r_long_long.png",
	"public/rarity/sr_long_long.png",
	"public/rarity/ur_long_long.png",
	"public/rarity/mr_long_long.png",
	"public/rarity/sp_long_long.png",
	sr = "public/rarity/sr_long_long.png",
	mr = "public/rarity/mr_long_long.png",
	ur = "public/rarity/ur_long_long.png",
	r = "public/rarity/r_long_long.png",
	sp = "public/rarity/sp_long_long.png"
}
FONT_RARITY_ICON = {
	"public/rarity/r_font.png",
	"public/rarity/sr_font.png",
	"public/rarity/ur_font.png",
	"public/rarity/mr_font.png",
	"public/rarity/sp_font.png",
	sr = "public/rarity/sr_font.png",
	mr = "public/rarity/mr_font.png",
	ur = "public/rarity/ur_font.png",
	r = "public/rarity/r_font.png",
	sp = "public/rarity/sp_font.png"
}
WEAPON_BG_QUALITY_PATH = {
	"public/box/weapon_bg_white.png",
	"public/box/weapon_bg_green.png",
	"public/box/weapon_bg_blue.png",
	"public/box/weapon_bg_purple.png",
	"public/box/weapon_bg_orange.png",
	"public/box/weapon_bg_red.png"
}
RARITY_RECRUIT = {
	"DropItemDisplay/horcrux_ur_top.png",
	"DropItemDisplay/horcrux_sr_top.png",
	"DropItemDisplay/horcrux_ur_top.png",
	"DropItemDisplay/horcrux_mr_top.png",
	"DropItemDisplay/horcrux_sp_top.png",
	"DropItemDisplay/horcrux_sp_top.png",
	[999] = "DropItemDisplay/up_top.png",
	[102] = "DropItemDisplay/sr_top.png",
	[106] = "DropItemDisplay/sp_top.png",
	[104] = "DropItemDisplay/mr_top.png",
	[103] = "DropItemDisplay/ur_top.png",
	[101] = "DropItemDisplay/ur_top.png",
	[105] = "DropItemDisplay/sp_top.png"
}
BUFF_IMAGE_PATH = "skill_new/skill/"
ROLE_SPINE_PATH = "spine/test/"
EFFECT_SPINE_PATH = "spine/test/"
CLOTHES_SPINE_PATH = "spine/test/"
UI_SPINE_PATH = "spine/ui/"
BACKGROUND_SPINE_PATH = "spine/background/"
SYSTEM_FIGURE_SHOP = "systemrole/shop.png"
SYSTEM_FIGURE_BAG = SYSTEM_FIGURE_SHOP
SYSTEM_FIGURE_FRIEND = SYSTEM_FIGURE_SHOP
SYSTEM_FIGURE_LIBERARY = SYSTEM_FIGURE_SHOP
SYSTEM_FIGURE_MAIL = SYSTEM_FIGURE_SHOP
SYSTEM_FIGURE_SMELT = SYSTEM_FIGURE_SHOP
SYSTEM_FIGURE_TASK = SYSTEM_FIGURE_SHOP
SYSTEM_FIGURE_TWIST = SYSTEM_FIGURE_SHOP
ATTRICONPATH = {
	[0] = "public/career_icon/null.png",
	"public/career_icon/wind.png",
	"public/career_icon/fire.png",
	"public/career_icon/water.png",
	"public/career_icon/light.png",
	"public/career_icon/dark.png",
	"public/career_icon/imaginary.png",
	"public/career_icon/devil.png",
	"public/career_icon/shiling.png",
	"public/career_icon/umaru.png",
	"public/career_icon/zerosupperession.png",
	water = "public/career_icon/water.png",
	fire = "public/career_icon/fire.png",
	shiling = "public/career_icon/shiling.png",
	umaru = "public/career_icon/umaru.png",
	zerosupperession = "public/career_icon/zerosupperession.png",
	light = "public/career_icon/light.png",
	dark = "public/career_icon/dark.png",
	imaginary = "public/career_icon/imaginary.png",
	wind = "public/career_icon/wind.png",
	null = "public/career_icon/null.png",
	devil = "public/career_icon/devil.png"
}

setmetatable(ATTRICONPATH, {
	__index = function(arg_1_0, arg_1_1)
		if type(arg_1_1) == "number" then
			return "public/career_icon/" .. ATTR_ID[arg_1_1] .. ".png"
		elseif type(arg_1_1) == "string" then
			return "public/career_icon/" .. arg_1_1 .. ".png"
		end
	end
})

CAREER_ICON = {}

setmetatable(CAREER_ICON, {
	__index = function(arg_2_0, arg_2_1)
		arg_2_1 = split(arg_2_1, "_")

		local var_2_0 = arg_2_1[2]

		for iter_2_0 = 3, #arg_2_1 do
			var_2_0 = var_2_0 .. "_" .. arg_2_1[iter_2_0]
		end

		return "public/career_icon/" .. var_2_0 .. ".png"
	end
})

ROLE_CONVERSATION_TYPE = {
	fight = 9,
	favorUpgrade = 19,
	dormTouch = 14,
	changeDress = 18,
	passlevel = 10,
	act_got = 22,
	home = 12,
	gift = 17,
	dormDaily = 13,
	xp = 20,
	lose = 11,
	dormFirst = 15,
	angry = 2,
	act_false = 24,
	act_get = 25,
	win = 3,
	act_enough = 26,
	marry = 21,
	component = 4,
	act_gift = 23,
	changeShowgilr = 1,
	mainTouch = 0
}
ROLE_CONVERSATION_TYPE_TO_STR = {
	[0] = "mainTouch",
	"changeShowgilr",
	"angry",
	"win",
	"component",
	nil,
	nil,
	nil,
	nil,
	"fight",
	"passlevel",
	"lose",
	"home",
	"dormDaily",
	"dormTouch",
	"dormFirst",
	nil,
	"gift",
	"changeDress",
	"favorUpgrade",
	"xp",
	"marry"
}
ROLE_SOUND_TYPE = {
	random = ROLE_CONVERSATION_TYPE.mainTouch,
	angry = ROLE_CONVERSATION_TYPE.angry,
	home = ROLE_CONVERSATION_TYPE.home,
	fight = ROLE_CONVERSATION_TYPE.fight,
	win = ROLE_CONVERSATION_TYPE.passlevel,
	lose = ROLE_CONVERSATION_TYPE.lose
}
NPC_ID_CATGIRL = 1000
NPC_ID_DEAN = 1001
NPC_ID_STUDENTS_PRESIDENT = 1002
NPC_ID_TEACHER = 1003
NPC_ID_B_MONITOR = 1004
ROLE_IMAGE_PATH = "role/"
CUTE_ROLE_IMAGE_PATH = "role1/"
PANEL_ROLE_IMAGE_PATH = "role/shop_image/"
ROLE_HEAD_IMAGE_PATH = "role/wuji/"
ROLE_RECT_HEAD_IMAGE_PATH = "role1/rectangle/"
ROLE_PORTRAIT_PATH = "role/portrait/"
ROLE_RADAR_PATH = "role/radar/"
ROLE_RETRUN_PATH = "role/return/"
ITEM_BUTTON_DEFAULT_IMAGE = "public/box/new_item_bg_touming.png"
ITEM_SMALL_BUTTON_DEFAULT_IMAGE = "public/box/UI_touming.png"
ITEM_BOX_UI = "public/box/"
ITEM_BOX_HIGHLIGHT_IMAGE = "public/box/UI_smeltScene_equipOn.png"
HEAD_SCULPTURE_0 = "role/wuji/10000.png"
ADVENTURE_BG_PATH = {
	TR_2 = "adventure/baoluan_2.png",
	AD_1 = "adventure/adven_1.png",
	AD_6 = "adventure/adven_6.png",
	TR_4 = "adventure/baoluan_4.png",
	TR_5 = "adventure/baoluan_5.png",
	TR_3 = "adventure/baoluan_3.png",
	AD_3 = "adventure/adven_3.png",
	AD_5 = "adventure/adven_5.png",
	TR_1 = "adventure/baoluan_1.png",
	AC_2 = "adventure/activity_2.png",
	AD_2 = "adventure/adven_2.png",
	AD_4 = "adventure/adven_4.png",
	AC_1 = "adventure/activity_1.png",
	AC_3 = "adventure/activity_3.png"
}
kITEM_STRENGTHEN_STONE = 10
kITEM_GEM = 11
kITEM_GIFT_BAG = 12
kITEM_HERO = 13
kITEM_LAB = 14
kITEM_BOSS_TICKET = 15
kITEM_BASIC_MATRIAL = 16
kITEM_MATRIAL = 17
kITEM_DRAWING = 18
kITEM_HORCRUX_DRAWING = 19
kITEM_EQUIPMENT = 20
kITEM_WEAPON_EXP = 21
kITEM_BREAK_IN = 22
kITEM_WEAPON_UPGRADE = 23
kITEM_SPECIAL_BREAK_IN = 24
kITEM_SERVANT = 25
kITEM_SERVANT_CHIP = 26
KITEM_SKILL_BOOK = 27
kITEM_HORCRUX = 30
kITEM_HORCRUX_CHIP = 31
kITEM_HORCRUX_EXE = 32
kITEM_CHOOSE_GIFT = 33
kITEM_EXPLORE_ITEM = 40
KITEM_EXPLORE_CONSUME = 41
KITEM_PLOT = 43
kITEM_COMPONENT = 50
kITEM_COMPONENT_CHIP = 60
kITEM_SKIN = 64
kITEM_FURNITURE = 65
kITEM_CLOTHES = 66
kITEM_GIFT_FOR_FRIEND = 67
kITEM_AWARD_TICKET = 68
KITEM_EXP_TICKET = 69
kITEM_SUPPLY = 87
kITEM_GIFT = 88
kITEM_ACTIVITY = 90
kITEM_MEDAL = 91
kITEM_SCULTURE = 92
kITEM_FURNITURE_GIFT = 93
kITEM_SKIN_GIFT = 94
KITEM_MARK_GIFT = 95
KITEM_SERVANT_RESET_TICKET = 96
KITEM_MARK_GIFT_SLIDER = 97
KITEM_DREAM_BOX = 98
KITEM_SHOP_PACKAGE = 99
KITEM_BARRAGE_GIFT = 100
KITEM_ELECTRIC = 101
KITEM_NO_ITEM = 102
kITEM_RING_MARRY = 103
KITEM_ROLE_GIFT = 104
KITEM_COURSE_CARD = 105
KITEM_ACTIVITY_RETURN_BUFF = 106
kITEM_RANDOM_GIFT = 107
KITEM_AI_MONSTER = 110
KITEM_LAB_SPEEDUP_TICKTE = 161
kITEM_COMPONENT_BOX = 187
Kitem_component_BOX_B = 188
KITEM_ARE_TFT_AWARD = 189
KITEM_RING = 190
kITEM_POSTCARD = 191
kITEM_TOWERDEFENCE = 199
COMMUNITY_ACTIVITY_VALUE = 120
CHAT_EMOTION_VALUE = 123
KITEM_EMOTION_CHAT_GIFT = 124
KITEM_ACTIVITY_GIFT = 201
KITEM_ACTIVITY_GIFT_FREE = 202
kITEM_ACTIVITY_BACHELOR_ROD = 203
KITEM_ACT_TWO_TWELVE_ITEM = 205
KITEM_SWIN_TICKET = 206
KITEM_SPRING_FESTIVAL_WORD = 207
KITEM_COUPONS = 208
KITEM_STUPID_GIFT = 209
KITEM_WORD_COLLECT_NB = 210
KITEM_WORD_COLLECT_ITEM = 211
kITEM_STABLE_TASK_ITEM = 212
KITEM_HORCRUX_ITEM = 213
kITEM_WEAPON = kITEM_EQUIPMENT
kITEM_FOOD = 999991
kITEM_EATABLES = 999992
kITEM_BOX = 999993
kITEM_GOLD_BAG = 999994
kITEM_GEM_BAG = 999995
kITEM_HELPGIRL_BAG = 999996
kITEM_COMPONENT_GIFT = 999997
ITEM_STR = {
	[kITEM_EQUIPMENT] = "装备",
	[kITEM_HORCRUX] = "魂器",
	[kITEM_HORCRUX_CHIP] = "魂器碎片",
	[kITEM_HORCRUX_EXE] = "这是瞎米",
	[kITEM_STRENGTHEN_STONE] = "强化石头",
	[kITEM_GEM] = "晶体",
	[kITEM_GIFT_BAG] = "芯片",
	[kITEM_HERO] = "魂器娘",
	[kITEM_LAB] = "实验室材料",
	[kITEM_BOSS_TICKET] = "boss挑战券",
	[kITEM_BASIC_MATRIAL] = "基础材料",
	[kITEM_MATRIAL] = "材料",
	[kITEM_DRAWING] = "图纸",
	[kITEM_SUPPLY] = "补给箱",
	[kITEM_GIFT] = "礼物",
	[kITEM_COMPONENT_GIFT] = "零件礼包",
	[kITEM_BOX] = "宝箱",
	[kITEM_GOLD_BAG] = "金币袋",
	[kITEM_GEM_BAG] = "宝石袋",
	[kITEM_HELPGIRL_BAG] = "零件箱",
	[kITEM_CLOTHES] = "服装",
	[kITEM_GIFT_FOR_FRIEND] = "礼物",
	[kITEM_COMPONENT] = "零件",
	[kITEM_AWARD_TICKET] = "券",
	[kITEM_ACTIVITY] = "活动币",
	[kITEM_FOOD] = "食材",
	[kITEM_EATABLES] = "食物",
	[KITEM_EXP_TICKET] = "经验券",
	[kITEM_WEAPON] = "魂武",
	[kITEM_WEAPON_EXP] = "强化经验",
	[kITEM_MEDAL] = "勋章",
	[kITEM_SCULTURE] = "玩家头像"
}
TOTAL_QUALITY = 11
TOTAL_WEAPON_MAXSTARS = 10
TOTAL_SOUL_COUNT = 17
TOTAL_HORCRUX_COUNT = 50
FONT_TITLE = "fonts/newkj.ttf"
FONT_NAME = "fonts/name.ttf"
FONT_DES = "fonts/number.ttf"
FONT_BUTTON = "fonts/newkj.ttf"
FONT_W5 = "fonts/W5.ttf"
FONT_BUBBLE = "fonts/name.ttf"
FONT_NEW = "fonts/new.ttf"
FONT_ARCHIVES = "fonts/archives.ttf"
EQUIP_COLOR_TBL = {
	cc.c3b(255, 255, 255),
	cc.c3b(132, 239, 55),
	cc.c3b(61, 168, 245),
	cc.c3b(200, 83, 255),
	cc.c3b(243, 177, 62),
	cc.c3b(236, 190, 91)
}
RISE_WORDS_SUCCESS = cc.c3b(255, 255, 255)
RISE_WORDS_WARNING = cc.c3b(255, 160, 0)
RISE_WORDS_FAIL = cc.c3b(255, 85, 85)
RISE_WORDS_OUTLINE = cc.c4b(70, 60, 50, 255)
ITEM_LIST_NAME_OUTLINE = cc.c4b(70, 60, 50, 255)
ATTR_COLOR = {
	wind = cc.c3b(0, 175, 64),
	water = cc.c3b(61, 168, 245),
	fire = cc.c3b(255, 76, 66),
	light = cc.c3b(236, 190, 91),
	dark = cc.c3b(10, 10, 10)
}
ATTR_ID = {
	[0] = "null",
	"wind",
	"fire",
	"water",
	"light",
	"dark",
	"imaginary",
	"devil",
	"shiling",
	"umaru",
	"zerosupperession",
	"positive",
	"mimicry",
	"outlander"
}
ATTR_STR = {
	wind = "风",
	water = "水",
	fire = "火",
	light = "光",
	dark = "暗"
}
ATTR_INDEX = {
	mimicry = 12,
	water = 3,
	positive = 11,
	umaru = 9,
	zerosupperession = 10,
	light = 4,
	dark = 5,
	imaginary = 6,
	shiling = 8,
	wind = 1,
	fire = 2,
	outlander = 13,
	null = 0,
	devil = 7
}
ATTR_SERVANT_WEIGHT = {}
ATTR_LINKAGE_LIST = {}
ATTR_OTHER_LIST = {
	outlander = true,
	shiling = 1,
	positive = true,
	zerosupperession = true,
	umaru = 1,
	imaginary = true
}
ATTR_FILTER_ORDER = {
	mimicry = 9,
	fire = 2,
	water = 3,
	light = 4,
	dark = 5,
	imaginary = 6,
	linkage = 8,
	wind = 1,
	other = 10,
	devil = 7
}
ATTR_HORCRUX_LIST = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	11,
	"other"
}
MAJOR_RES_TBL = {
	wind = "water",
	fire = "wind",
	positive = "devil",
	devil = "light",
	water = "fire",
	light = "dark",
	dark = "positive",
	imaginary = "imaginary"
}
UI_COLOR_ORGANGE = cc.c3b(255, 150, 0)
UI_COLOR_YELLOW = cc.c3b(255, 181, 4)
UI_COLOR_BLACK = cc.c3b(15, 15, 15)
UI_COLOR_WHITE = cc.c3b(242, 242, 242)
CLASS_COUNT = 5
TOTAL_RANK = 16
EQUIP_UPDATE_TBL = {
	[0] = 100,
	100,
	100,
	100,
	100,
	100,
	100,
	100,
	100,
	100,
	0
}

if config.limit_open_system then
	UNLOCK_BAG = 0
	UNLOCK_PHOTO = 0
	UNLOCK_QUICK_FIGHT = 2001
	UNLOCK_AUTO_FIGHT = 2001
	UNLOCK_FAVOR = 3001
	UNLOCK_SCHOOL = 3010
	UNLOCK_RECRUIT_ROLE = 2010
	UNLOCK_ACTIVITY_LIULI = 3005
	UNLOCK_SMELT = 0
	UNLOCK_HELP = 0
	UNLOCK_TWIST = 1005
	UNLOCK_DELAY_TASK = 0
	UNLOCK_SUIT_ATTRIBUTE = 0
	UNLOCK_LAB = 5010
	UNLOCK_LAB_FACTORY = 5010
	UNLOCK_ARENA = 5007
	UNLOCK_COLLECTION_SHOP = 0
	UNLOCK_AD = 3002
	UNLOCK_MIDAS = 0
	UNLOCK_EXPLORE = 0
	UNLOCK_EXPLORE_SHOW = 9002
	UNLOCK_SCHOOL_TRAIN = 4005
	UNLOCK_SCHOOL_SWIM = 2010
	UNLOCK_SCHOOL_OFFICE = 2010
	UNLOCK_TRAIN_SKILL1_LEVLE1 = 0
	UNLOCK_TRAIN_SKILL1_LEVLE2 = 1
	UNLOCK_TRAIN_SKILL1_LEVLE3 = 2
	UNLOCK_PATRO = 0
	UNLOCK_SCOREARENA = 3010
	UNLOCK_SHILIANTA = 3006
	UNLOCK_LEVELTALK = 5010
	UNLOCK_CHANGE = 3002
	UNLOCK_ELEMENTTA = 5001
	UNLOCK_COMPEATION = math.min(UNLOCK_SCOREARENA, UNLOCK_ARENA)
	UNLOCK_THREE_VS_THREE = 12010
	UNLOCK_FIGHT_SURRENDER = "2-4"
	UNLOCK_HORCRUX = 3010
	UNLOCK_ARENA_TEAM = 999
	UNLOCK_RANK = 0
	UNLOCK_RANK_TEAM = 999
	UNLOCK_SUMMONER_SPELL = 30
	UNLOCK_PARTS = 85
	UNLOCK_PARTS_COPY = 119
	UNLOCK_LAB_HELP = 649
	UNLOCK_LAB_ROB = 200
	UNLOCK_LAB_INSTRUMENT_2 = 249
	UNLOCK_LAB_INSTRUMENT_3 = 349
	UNLOCK_LAB_INSTRUMENT_4 = 449
	UNLOCK_SHOP = 0
	BATTLEARRAY_SOUL_UNLOCK = {
		1000,
		1002,
		1003,
		1004,
		1005
	}
	BATTLEARRAY_HORCRUX_UNLOCK = {
		2010,
		2010,
		2010,
		2010,
		2010
	}
	UNLOCK_FIRST = "1-5"
	UNLOCK_OTHER = 0
	UNLOCK_COMMAINMAINLAYE = 6010
	UNLOCK_COMMAINJOINLAYE = 6010
	UNLOCK_RADOMADVERTURE = 0
	UNLOCK_SCHOOL_ORDER = 5010
	UNLOCK_SKINMARKET = "3-10"
	UNLOCK_QUICKFIGHT = 1005
	UNLOCK_TOWERDEFENCE = 8010
	UNLOCK_STORYMODES = 4007
	UNLOCK_ADVENTURENEWITEMLAYER_2 = 3002
	UNLOCK_ADVENTURENEWITEMLAYER_3 = 3002
	UNLOCK_EQUIPLAYER_COMPONENT = 1005
	UNLOCK_TIPS = 3001
	UNLOCK_SUBSTITUTION = 7010
	UNLOCK_EXPLOREOFFERLAYER = 4010
	UNLOCK_SUBSTITUTIONBOSSLAYER = 3010
	UNLOCK_LIMITTOWERDEFENCELEVEL = 11010
	UNLOCK_SCHOOL_STUDY = 3010
	UNLOCK_PASSLEVEL_AWARD = 2007
	UNLOCK_WEEKLYTOWERD = 4005
	UNLOCK_BIANHUA = 5010
	UNLOCK_AVALON = 6010
	UNLOCK_LAMIA = 7010
	UNLOCK_SHEXIEYING = 8010
	UNLOCK_FIGHT_AUTO = 5010
	UNLOCK_FIGHT_NEXT = 5010
	UNLOCK_SPECIAL_TOWER = 3010
	UNLOCK_AUTO_FORMATION = 2010
	UNLOCK_LIST_SWITCH = "1-5"
	UNLOCK_ACTIVITY_ENTTRANCE = 3010
	UNLOCK_EXPEDITION = 5010
	UNLOCK_SUBSTITUTION2 = 6010
	UNLOCK_MAIL = 2010
	UNLOCK_FIGHT_GIFT = 4005
	UNLOCK_RAINBOW_COMPONENT = 8010
else
	UNLOCK_ACTIVITY_LIULI = 0
	UNLOCK_PASSLEVEL_AWARD = 0
	UNLOCK_AUTO_FIGHT = 0
	UNLOCK_DELAY_TASK = 0
	UNLOCK_ARENA = 0
	UNLOCK_ARENA_TEAM = 0
	UNLOCK_RANK = 0
	UNLOCK_RANK_TEAM = 0
	UNLOCK_LAB = 0
	UNLOCK_LAB_FACTORY = 0
	UNLOCK_LAB_ROB = 0
	UNLOCK_LAB_HELP = 0
	UNLOCK_RECRUIT_ROLE = 0
	UNLOCK_LAB_INSTRUMENT_2 = 0
	UNLOCK_LAB_INSTRUMENT_3 = 0
	UNLOCK_BAG = 0
	UNLOCK_QUICK_FIGHT = 0
	UNLOCK_SUMMONER_SPELL = 0
	UNLOCK_MIDAS = 0
	UNLOCK_AD = 0
	UNLOCK_ADVANCE = 0
	UNLOCK_TWIST = 0
	UNLOCK_HELP = 0
	UNLOCK_SHOP = 0
	UNLOCK_FAVOR = 0
	UNLOCK_PHOTO = 0
	UNLOCK_SMELT = 0
	UNLOCK_PARTS = 0
	UNLOCK_PARTS_COPY = 0
	UNLOCK_AD_ELE = 1
	UNLOCK_EXPLORE = 0
	UNLOCK_EXPLORE_SHOW = 0
	UNLOCK_SHOOL = 0
	UNLOCK_COLLECTION_SHOP = 0
	UNLOCK_SCHOOL_TRAIN = 0
	UNLOCK_SCHOOL_SWIM = 0
	UNLOCK_SCHOOL_OFFICE = 0
	UNLOCK_TRAIN_SKILL1_LEVLE1 = 0
	UNLOCK_TRAIN_SKILL1_LEVLE2 = 0
	UNLOCK_TRAIN_SKILL1_LEVLE3 = 0
	UNLOCK_PATRO = 0
	UNLOCK_SCOREARENA = 0
	UNLOCK_SHILIANTA = 0
	BATTLEARRAY_SOUL_UNLOCK = {
		1000,
		1000,
		1000,
		1000,
		1000
	}
	BATTLEARRAY_HORCRUX_UNLOCK = {
		1000,
		1000,
		1000,
		1000,
		1000
	}
	UNLOCK_LEVELTALK = 0
	UNLOCK_CHANGE = 0
	UNLOCK_ELEMENTTA = 0
	UNLOCK_COMPEATION = 0
	UNLOCK_OTHER = "1-0"
	UNLOCK_THREE_VS_THREE = 0
	UNLOCK_COMMAINMAINLAYE = 0
	UNLOCK_COMMAINJOINLAYE = 0
	UNLOCK_RADOMADVERTURE = 0
	UNLOCK_SCHOOL_ORDER = 0
	UNLOCK_SKINMARKET = 0
	UNLOCK_TOWERDEFENCE = 0
	UNLOCK_STORYMODES = 0
	UNLOCK_ADVENTURENEWITEMLAYER_2 = 0
	UNLOCK_ADVENTURENEWITEMLAYER_3 = 0
	UNLOCK_EQUIPLAYER_COMPONENT = 0
	UNLOCK_QUICKFIGHT = 0
	UNLOCK_TIPS = 0
	UNLOCK_SUBSTITUTION = 0
	UNLOCK_EXPLOREOFFERLAYER = 0
	UNLOCK_SUBSTITUTIONBOSSLAYER = 0
	UNLOCK_LIMITTOWERDEFENCELEVEL = 0
	UNLOCK_SCHOOL_STUDY = 0
	UNLOCK_FIGHT_SURRENDER = 0
	UNLOCK_WEEKLYTOWERD = 0
	UNLOCK_BIANHUA = 0
	UNLOCK_AVALON = 0
	UNLOCK_LAMIA = 0
	UNLOCK_SHEXIEYING = 0
	UNLOCK_FIGHT_AUTO = 0
	UNLOCK_FIGHT_NEXT = 0
	UNLOCK_SPECIAL_TOWER = 0
	UNLOCK_AUTO_FORMATION = 0
	UNLOCK_LIST_SWITCH = 0
	UNLOCK_HORCRUX = 0
	UNLOCK_ACTIVITY_ENTTRANCE = 0
	UNLOCK_EXPEDITION = 0
	UNLOCK_MAIL = 0
	UNLOCK_FIGHT_GIFT = 0
	UNLOCK_SUBSTITUTION2 = 0
	UNLOCK_RAINBOW_COMPONENT = 0
end

FIGHTTYPE_GUIDE = -1
FIGHTTYPE_NORMAL = 0
FIGHTTYPE_ADVENTURE = 1
FIGHTTYPE_ADVENTURE_TOWER = 3
FIGHTTYPE_ARENA = 2
FIGHTTYPE_LAB = 4
FIGHTTYPE_EXPLORE = 5
FIGHTTYPE_SCOREARENA = 6
FIGHTTYPE_SUBSTITUTION = 7
FIGHTTYPE_AIATTACK = 8
FIGHTTYPE_SUBSTITUTION_OLD = 9
FIGHTTYPE_ARENATFT = 10
FIGHTTYPE_INFINITE = 11
FIGHTTYPE_TOWER = 12
FIGHTTYPE_FRIENDFIGHT = 13
FIGHTTYPE_STAKE_PVP = 14
FIGHTTYPE_EXPEDITION = 15
FIGHTTYPE_EXPEDITION_TOWER = 16
FIGHTTYPE_EXPEDITION_MONOPOLY = 17
FIGHTTYPE_STAKE_PVE = 18
FIGHTTYPE_MONOPOLY = 19
FIGHTTYPE_AUTO_CHESS = 20
FIGHTTYPE_ROGUEEXPLORE = 21
FIGHTTYPE_GROUPFIGHT = 22
FIGHTTYPE_FLYCHESS = 23
FIGHTTYPE_WORLDBOSS = 24
LAB_QUICK_HARVEST_COST_PER_SIXMIN = 1
SHOP_TYPE_TOOL = 1
SHOP_TYPE_SUPPLY = 2
SHOP_TYPE_DRESS = 3
SHOP_TYPE_HOT = SHOP_TYPE_TOOL
SHOP_TYPE_TIME_LIMIT = SHOP_TYPE_SUPPLY
SHOP_TYPE_VIP = SHOP_TYPE_DRESS
MARKET_TYPE_MIAOJIANG = 1
MARKET_TYPE_JINGJI = 2
MARKET_TYPE_EXPLORE = 3
MARKET_TYPE_GONGHUI = MARKET_TYPE_EXPLORE
MARKET_TAG_TYPE = {
	"推荐",
	"新品",
	"热销"
}
MARKET_TYPE_COMPONENT = 4
MALL_TYPE_SHOP = 1
MALL_TYPE_MARKET = 2
MALL_TYPE_RECHARGE = 3
PRODUCE_TYPE_COMMAND = 1
PRODUCE_TYPE_REFINE = 2
PRODUCE_TYPE_SMELT = 3
PRODUCE_TYPE_CHIP = 4
ARENA_CLEAR_TIME_COST = 2
ARENA_BUY_TIMES_COST = 20
GIFT_LIMIT = 6
MORE_GIFT_LIMIT = 3
DORMFAVOR_LIMIT = 50
TWIST_TICKET_ID = 6800101
TWIST_DIAMOND_TICKET_ID = 6800102
TICKET_COST_FOR_ONCE = 1
TICKET_COST_FOR_TEN = 10
DIAMOND_COST_FOR_ONCE = 60
DIAMOND_COST_FOR_TEN = 600
ELECTRIC = 10100001
CLOTHES_TICKET = 6800201
BLACK_CARD = 1500001
BLACK_SP_CARD = 1500002
SOUL_CARD = 1600001
TIPS_TOTALNUM = 53
ROLENUMBER = 12
SYSTEMNUMBER = 0
HELPGIRLNUMBER = 100
ENEMYNUMBER = 155
FILESNUMBER = 112
STORY_NUMBER = 50
BRANCH_NUMBER = 0
EVENT_NUMBER = 21
ITEM_SCALE = 0.671875
MARKET_REFRESH_DIAMOND_ID = {
	3000,
	3000,
	3000,
	7000,
	6000
}
MARKET_MAX_REFRESH_TIME = {
	20,
	20,
	20,
	20,
	20
}
MAX_REFRESH_TIME = 5
MAX_REFRESH_TIME_COMPONENT = 10
LISTBUTTON = cc.p(20, 60)
LISTBUTTON1 = cc.p(135, 60)
LISTBUTTON_THIRD = cc.p(20, 60)
MAINBUTTON = cc.p(20, 0)
FAVOR_HOUSE = cc.p(560, 185)
FAVOR_BUTTON = cc.p(12, 45)
FAVOR_EVENT = cc.p(350, 70)
FAVOR_FLAT = cc.p(65, 60)
TASKBUTTON = cc.p(40, 45)
ACTIVITYPANEL = cc.p(20, 40)
INFINITE_MODE = 101
CONQUER_MODE = 102
SPILING_MODE = 103
MIRROR_MODE = 104
MACHINE_MODE = 107
ENERGY_MODE = 108
CLASS_BEGINNER = 1
CLASS_PRIMARY = 2
CLASS_MIDDLE = 3
CLASS_ADVANCED = 4
CLASS_SUPER = 5
CLASS_EXPERT = 6
CLASS_UPDATE_GRADE = {
	[CLASS_BEGINNER] = 20,
	[CLASS_PRIMARY] = 40,
	[CLASS_MIDDLE] = 60,
	[CLASS_ADVANCED] = 80,
	[CLASS_SUPER] = 100,
	[CLASS_EXPERT] = 120
}
CLASS_TYPE_ID = {
	1,
	2,
	3,
	4
}
E_EXPLORE_ACTIONS = {
	100,
	100,
	100,
	150,
	150,
	150,
	200,
	200,
	200,
	200
}
RES_FACTOR = 0.5
HELP_FACTOR = 0.2
ROLE_TANK = 1
ROLE_AD = 2
ROLE_AP = 3
TALK_TYPE_NORMAL = 0
TALK_TYPE_FAVOR = 1
TALK_TYPE_EXPLORE = 2
TALK_TYPE_BRANCH = 3
TALK_TYPE_BEFORE_BOSS = 4
TALK_TYPE_EVENT = 5
TALK_TYPE_TRAVEL = 6
SYSTEMID = {
	[3055] = "CommunityWishMianLayer",
	[1600] = "BianhuaStoryLayer",
	[3025] = "ActivityAvalonBPLayer",
	[1000] = "MallLayer",
	[3019] = "ActivityRoutineBPLayer",
	[3015] = "AdventureNewItemLayer",
	[3005] = "DoubleHoliday_WoldCityLayer_2",
	[150] = "MarketLayerCat",
	[10000] = "ExploreMapLayer",
	[302] = "EquipLayer_22120",
	[1210] = "ActivityTaskLayer",
	[1700] = "ThreeVsThreeLayer",
	[601] = "AdventureNewItemLayer",
	[603] = "AdventureNewItemLayer_3",
	[3002] = "DoubleHoliday_CityNodeLayer",
	[2115] = "PopSkinAccessLayer",
	[220] = "FightResultLayerNew",
	[3026] = "ActivityXinxiYaBPLayer",
	[3034] = "PopShowGirlPageLayer",
	[3010] = "ActivityLayer_Valentine_Day",
	[152] = "MarketLayerRace",
	[1304] = "SchoolDeanOfficeLayer",
	[2051] = "BigAvtivity_5_1",
	[1306] = "ActivityWarOrderLayer",
	[3050] = "DEPRECATED",
	[102] = "ActivityNoviceTaskLayer",
	[153] = "MarketLayerSupply",
	[605] = "AdventureNewItemLayer_Component",
	[154] = "MarketLayerCollection",
	[1314] = "WeeklyTowerEntranceLayer",
	[900] = "ArenaLayer",
	[1313] = "PatrolFightLayer",
	[156] = "MarketLayerComponent",
	[301] = "GirlSelectLayer",
	[157] = "MarketLayerSoulCard",
	[604] = "AdventureNewItemLayer_4",
	[158] = "MarketLayerTowerDefence",
	[2500480] = "NoviceSummaryLayer_ActivityNoviceThirtyTaskLayer",
	[1312] = "AdventureLayer_guide",
	[101] = "PopNoviceAwardLayer",
	[3051] = "CommunityTaskShowLayer",
	[2091] = "ActivityLayer_bianhua_Main",
	[2092] = "ActivityLayer_bianhua_Chapter",
	[2093] = "ActivityLayer_bianhua_Achieve",
	[2094] = "ActivityLayer_bianhua_Collection",
	[4005] = "AirPlaneLayer",
	[3001] = "DoubleHoliday_WoldCityLayer",
	[2114] = "SchoolStudyLayer",
	[300] = "GirlSelectLayer",
	[1300] = "SchoolAreaLayer",
	[3033] = "ActivitySummerMainLayer",
	[2113] = "PopDailyRechargeLayer",
	[3017] = "FriendListLayer",
	[1311] = "PatrolFightLayer",
	[151] = "MarketLayerTool",
	[3041] = "PopBirthdayPartyLayer",
	[2120] = "AfkLevelLayer",
	[2121] = "PopActivitySurveyLayer_1",
	[2122] = "PopActivitySurveyLayer_2",
	[2123] = "PopActivityReturnDetailLayer",
	[1400] = "ActivityEntranceLayer",
	[2124] = "PopPhoneNumberLayer",
	[2125] = "PopRechargeDailyPrizeLayer",
	[20001] = "LevelMapCity1",
	[700] = "DormitoryLayer",
	[20002] = "LevelMapCity2",
	[710] = "DormitoryLayer_group2",
	[130] = "SignLayerNew",
	[20003] = "LevelMapCity3",
	[20004] = "LevelMapCity4",
	[21000] = "LevelTalkMapLayer",
	[3000132] = "ActivityAnniversaryExploreLayer",
	[1201] = "ActivitySignFmlLayer",
	[2300000] = "ActivityLevelLayer",
	[2900132] = "ActivityAnniversaryMainLayer",
	[3000148] = "ActivityExploreLayer_148",
	[3000186] = "ActivityExploreLayer_186",
	[4004] = "UrbanDefenseLayer_430",
	[3000] = "ActivityExploreLayer_Liuli_Explore",
	[140] = "MailLayer",
	[2300180] = "ActivityLevel_182",
	[3024] = "AdventurerVisualLayer",
	[3032] = "SwimMainLayer",
	[3008] = "BattlePassSpringLayer",
	[3016] = "ActivityWideWakeLayer",
	[2300182] = "ActivityLevel_182",
	[2300186] = "ActivityLevel_186",
	[2300199] = "ActivityLevel_199",
	[2300202] = "ActivityLevel_202",
	[2300205] = "ActivityLevel_205",
	[2500136] = "NoviceSummaryLayer_ActivityXinxiYaBPLayer",
	[520] = "HorcruxLayer",
	[504] = "BagMaterialLayer",
	[4002] = "RecollectionsSweepstakeLayer",
	[2300173] = "ActivityLevel_173",
	[1310] = "BirthdayPartyLayer",
	[20009] = "LevelMapCity9",
	[1500] = "ActivityLayer",
	[191] = "PopActivityReturnSignLayer",
	[190] = "ReturnActivityGeneralBPLayer",
	[20007] = "LevelMapCity7",
	[4003] = "ActivityDailyLayer_230",
	[3007] = "Activity_SpringFestival_Collection",
	[2112] = "PopAnswerQuestionLayer",
	[20005] = "LevelMapCity5",
	[1303] = "SchoolSwimLayer",
	[3039] = "AdventurerUmaruInfiniteLayer",
	[180] = "TwisteggLayer",
	[1307] = "SubstitutionBossLayer",
	[1100] = "LabMenuLayer",
	[170] = "PhotoMemoryLayer",
	[171] = "PhotoFileLayer",
	[172] = "PhotoGoodsLayer",
	[1200] = "ActivityMenuLayer",
	[160] = "SupermarketLayer",
	[1702] = "PopTapVoteLayer",
	[600] = "AdventureLayer",
	[602] = "AdventureNewItemLayer_2",
	[3006] = "ActivityLayer_SpringFestival",
	[2119] = "LevelMapBoxLayer",
	[2111] = "ActivityNinifaLayer",
	[610] = "SpecialJumpTowerLayer",
	[3014] = "ActivityQuestionPtLayer",
	[3022] = "ActivityFlopSummerLayer",
	[3070] = "PopTurnOverItemsLayer",
	[2041] = "ActivitySignLayer_4_1",
	[3054] = "PopCommunityDonationLayer",
	[106] = "ExploreOfferLayer",
	[105] = "PopNovicePasslevelAwardLayer",
	[2000043] = "ActivityJpCbSignLayer",
	[910] = "ScoreArenaLayer",
	[111] = "HandOfMidasLayer",
	[210] = "FightLayer",
	[4001] = "RecollectionsLayer",
	[30129] = "AdventurerVisualLayerSummer",
	[2118] = "SchoolOrderLayer",
	[1302] = "SchoolTrainLayer",
	[3037] = "ActivityGameBackGuideLayer_task",
	[3013] = "ActivityMarryMainLayer",
	[3021] = "ActivitySaveBPLayer",
	[1800] = "GroupFightLayer",
	[201] = "FightLayer",
	[200] = "FightLayer",
	[403] = "TopPlotListWeeklyLayer",
	[402] = "TopPlotListDailyLayer",
	[401] = "TopPlotListLayer",
	[400] = "TaskLayer",
	[1701] = "CompetitionLayer",
	[4000] = "LimitTowerDefenceLevelLayer",
	[3004] = "AITwistLayer",
	[2117] = "PopTGVRechargeInfoLayer",
	[100] = "MainLayer",
	[3036] = "ActivityGameBackGuideLayer",
	[3012] = "PopActivityLayerGirlsDay",
	[3020] = "ActivityFlopDuanWuLayer",
	[3060] = "PopInviteResidentLayer",
	[3052] = "DEPRECATED",
	[250] = "LevelMapLayer",
	[2000] = "SkinTwisteggLayer",
	[2900143] = "ActivityBachelor_2020",
	[20008] = "LevelMapCity8",
	[120] = "ClassupdateLayer",
	[505] = "BagFurnitureLayer",
	[502] = "BagLabLayer",
	[503] = "BagPartLayer",
	[500] = "WareHouseLayer",
	[501] = "BagWeaponLayer",
	[20006] = "LevelMapCity6",
	[3003] = "DoubleHoliday_AchievementLayer",
	[1301] = "SchoolCinemaLayer",
	[3035] = "CostumeRoomLayer",
	[1309] = "BondLayer",
	[1305] = "SchoolFileLayer",
	[124] = "PopRechargeIconLayer",
	[1110] = "LabMenuLayer",
	[810] = "LabMenuLayer",
	[820] = "LabMakeNewLayer",
	[1401] = "LinkActivityEntranceLayer",
	[830] = "PopElectricSupplyLayer"
}

setmetatable(SYSTEMID, {
	__index = function(arg_3_0, arg_3_1)
		local var_3_0

		if type(arg_3_1) == "string" then
			if string.find(arg_3_1, "@") then
				var_3_0 = string.sub(arg_3_1, string.find(arg_3_1, "@"), #arg_3_1)
				arg_3_1 = string.sub(arg_3_1, 1, string.find(arg_3_1, "@") - 1)
				arg_3_1 = tonumber(arg_3_1)
			else
				arg_3_1 = tonumber(arg_3_1)
			end
		end

		local var_3_1

		if not var_3_1 and arg_3_1 == 400001 then
			var_3_1 = require("controller.community_system_manager"):getInintJumpLayerName()
		end

		if not var_3_1 and arg_3_1 >= 1500 and arg_3_1 <= 1599 then
			var_3_1 = "MarketLayerActive_" .. arg_3_1 % 1500
		end

		if not var_3_1 and arg_3_1 >= 1500000 and arg_3_1 <= 1599999 then
			var_3_1 = "MarketLayerActive_" .. arg_3_1 % 1500000
		end

		if not var_3_1 and arg_3_1 >= 1801 and arg_3_1 <= 1899 then
			var_3_1 = "TwisteggLayerActive_" .. arg_3_1 % 180
		end

		if not var_3_1 and arg_3_1 >= 1800001 and arg_3_1 <= 1899999 then
			var_3_1 = "TwisteggLayerActive_" .. arg_3_1 % 1800000
		end

		if not var_3_1 and arg_3_1 >= 1900001 and arg_3_1 <= 1999999 then
			var_3_1 = "ActivityRechargeTemplate_" .. arg_3_1 % 1900000
		end

		if not var_3_1 and arg_3_1 >= 2000001 and arg_3_1 <= 2099999 then
			var_3_1 = "ActivitySignTemplateLayer_" .. arg_3_1 % 2000000
		end

		if not var_3_1 and arg_3_1 >= 10000 and arg_3_1 < 20000 then
			var_3_1 = "ExploreMapLayer" .. arg_3_1 % 10000
		end

		if not var_3_1 and arg_3_1 > 1600 and arg_3_1 < 1700 then
			var_3_1 = "SupermarketLayer_" .. arg_3_1 % 100
		end

		if not var_3_1 and arg_3_1 >= 2000001 and arg_3_1 <= 2099999 then
			var_3_1 = "ActivitySignTemplateLayer_" .. arg_3_1 % 2000000
		end

		if not var_3_1 and arg_3_1 >= 1700000 and arg_3_1 <= 1799999 then
			var_3_1 = "shopTimeLimitLayer_" .. arg_3_1 % 1700000
		end

		if not var_3_1 and arg_3_1 >= 2100000 and arg_3_1 <= 2199999 then
			var_3_1 = "ActivityWordCollection_" .. arg_3_1 % 2100000
		end

		if not var_3_1 and arg_3_1 >= 2200000 and arg_3_1 <= 2299999 then
			var_3_1 = "activityFlop_" .. arg_3_1 % 2200000
		end

		if not var_3_1 and arg_3_1 >= 2300000 and arg_3_1 < 2400000 then
			var_3_1 = "ActivityLevelBaseLayer" .. arg_3_1 % 2300000
		end

		if not var_3_1 and arg_3_1 >= 2500000 and arg_3_1 < 2600000 then
			var_3_1 = "ActivityBattlePassLayer" .. arg_3_1 % 2500000
		end

		if not var_3_1 and arg_3_1 >= 2400000 and arg_3_1 <= 2499999 then
			var_3_1 = "ActivityPTLayer_" .. arg_3_1 % 2400000
		end

		if not var_3_1 and arg_3_1 >= 2600000 and arg_3_1 <= 2699999 then
			var_3_1 = "ActivityWakefundBaseLayer_" .. arg_3_1 % 2600000
		end

		if not var_3_1 and arg_3_1 >= 2700000 and arg_3_1 <= 2799999 then
			var_3_1 = "ActivityRouletteLayer_" .. arg_3_1 % 2700000
		end

		if not var_3_1 and arg_3_1 >= 2800000 and arg_3_1 <= 2899999 then
			var_3_1 = "ActivityArtLayer_" .. arg_3_1 % 2800000
		end

		if not var_3_1 and arg_3_1 >= 2900000 and arg_3_1 <= 2999999 then
			var_3_1 = "ActivityMainLayer_" .. arg_3_1 % 2900000
		end

		if not var_3_1 and arg_3_1 >= 303801 and arg_3_1 < 303813 then
			var_3_1 = "ActivityUmaruLevelLayer" .. arg_3_1 % 303800
		end

		if not var_3_1 and arg_3_1 >= 3100000 and arg_3_1 < 3199999 then
			var_3_1 = "PopRechargeIconLayer" .. arg_3_1
		end

		if not var_3_1 and arg_3_1 >= 3300000 and arg_3_1 < 3399999 then
			var_3_1 = "PopShowGirlPageLayer_" .. arg_3_1 % 3300000
		end

		if not var_3_1 and arg_3_1 >= 3400000 and arg_3_1 < 3499999 then
			var_3_1 = "TowerDefenceLevelLayer" .. arg_3_1 % 3400000
		end

		if not var_3_1 and arg_3_1 >= 3500000 and arg_3_1 <= 3599999 then
			var_3_1 = ("shopTimeLimitLayer_" .. arg_3_1 % 3500000) .. "_35"
		end

		if not var_3_1 and arg_3_1 >= 3600000 and arg_3_1 <= 3699999 then
			-- block empty
		end

		if not var_3_1 and arg_3_1 >= 3700000 and arg_3_1 <= 3799999 then
			var_3_1 = "AdventurerRandomLayer_" .. arg_3_1 % 3700000
		end

		if not var_3_1 and arg_3_1 >= 3800000 and arg_3_1 <= 3899999 then
			var_3_1 = "SupermarketLayer" .. arg_3_1 % 380000
		end

		if not var_3_1 and arg_3_1 >= 3900000 and arg_3_1 <= 3999999 then
			var_3_1 = "ActivityMultiPtLayer" .. arg_3_1 % 3900000
		end

		if not var_3_1 and arg_3_1 >= 4001001 and arg_3_1 <= 4001999 then
			var_3_1 = "MonopolyLayer" .. arg_3_1 % 4001000
		end

		if not var_3_1 and arg_3_1 >= 4002001 and arg_3_1 <= 4002999 then
			var_3_1 = "ExpeditionLayer" .. arg_3_1 % 4002000
		end

		if not var_3_1 and arg_3_1 >= 4003001 and arg_3_1 <= 4003999 then
			var_3_1 = "PopActivityShareBaseLayer" .. arg_3_1 % 4003000
		end

		if not var_3_1 and arg_3_1 >= 4004001 and arg_3_1 <= 4004999 then
			var_3_1 = "ActivityFightCollectionLayer_" .. arg_3_1 % 4004000
		end

		if not var_3_1 and arg_3_1 >= 4005001 and arg_3_1 <= 4005999 then
			var_3_1 = "PopDailyRechargeLayer" .. arg_3_1 % 4005000
		end

		if not var_3_1 and arg_3_1 >= 4006001 and arg_3_1 <= 4006999 then
			var_3_1 = "PopSkinAccessLayer_" .. arg_3_1 % 4006000
		end

		if not var_3_1 and arg_3_1 >= 4007001 and arg_3_1 <= 4007999 then
			var_3_1 = "PopActivityBpSignLayer_" .. arg_3_1 % 4007000
		end

		if not var_3_1 and arg_3_1 >= 4008001 and arg_3_1 <= 4008999 then
			var_3_1 = "AutoChessBaseLayer_" .. arg_3_1 % 4008000
		end

		if not var_3_1 and arg_3_1 >= 4010001 and arg_3_1 <= 4019999 then
			var_3_1 = "ActivityJumptowerBaseLayer_" .. arg_3_1 % 4010000
		end

		if not var_3_1 and arg_3_1 >= 4020001 and arg_3_1 <= 4029999 then
			var_3_1 = "ActivityBachelorBaseLayer" .. arg_3_1 % 4020000
		end

		if not var_3_1 and arg_3_1 >= 4030001 and arg_3_1 <= 4039999 then
			var_3_1 = "PopActivityFeedBackLayer" .. arg_3_1 % 4030000
		end

		if not var_3_1 and arg_3_1 > 1400 and arg_3_1 <= 1499 then
			var_3_1 = "ActivitySpecialEntranceLayer" .. arg_3_1 % 1400
		end

		if not var_3_1 and arg_3_1 > 20000 and arg_3_1 < 21000 then
			var_3_1 = "LevelMapCity" .. arg_3_1 % 1000
		end

		if not var_3_1 and arg_3_1 > 100000000 and arg_3_1 < 109999999 then
			var_3_1 = "Equiplayer" .. arg_3_1 % 10000000
		end

		if not var_3_1 and arg_3_1 > 200000000 and arg_3_1 < 299999999 then
			var_3_1 = "ActivityPopBaseLayer" .. arg_3_1 % 200000000
		end

		if var_3_1 and var_3_0 then
			var_3_1 = var_3_1 .. var_3_0
		end

		return var_3_1
	end
})

if config.packagechannel == "palmpi" then
	LAYERSYSTEMID = {}

	for iter_0_0, iter_0_1 in pairs(SYSTEMID) do
		LAYERSYSTEMID[iter_0_1] = iter_0_0
	end
end

BAG_ADD_WEIGHT = 20
BAG_MAX_ADD_TIME = {
	65,
	65,
	40,
	65,
	65,
	65
}
OPEN_DATE = "2019-01-21 00:00:00"
TASK_TYPE_NORMAL = 1
TASK_TYPE_DAILY = 2
TASK_TYPE_ACHIEVE = 3
TASK_TYPE_CAREER = 4
TASK_TYPE_BATTLEPASS = 5
TASK_TYPE_NOVICE = 6
TASK_TYPE_WEEKLY = 7
TASK_TYPE_MEDAL = 8
TASK_TYPE_INVITE = 11
TASK_TYPE_BEINVITED = 10
TASK_TYPE_FAMILY_DAILY = 12
TASK_TYPE_FAMILY_WEEKLY = 13
ELEMENT_ADD_NUM = 40
QUICK_FIGHT_DAILY_TIME = 10
ITEMPANEL_TYPE_NORMAL = 1
ITEMPANEL_TYPE_ROLE_COMPONENT = 2
ITEMPANEL_TYPE_SMELT_COMPONENT = 3
ITEMPANEL_TYPE_ROLE_WEAPON = 4
ITEMPANEL_TYPE_WEAPON_STRENGTHEN = 5
ITEMPANEL_TYPE_UPGRADE_WEAPON = 6
ITEMPANEL_TYPE_COOK_ADD_FOOD = 7
ITEMPANEL_TYPE_MEDAL = 8
ITEMPANEL_TYPE_SCULTURE = 9
ITEMPANEL_TYPE_DORM_FURNITURE = 10
ITEMPANEL_TYPE_LAB_RD = 11
ITEMS_TARGETTYPE = {
	[kITEM_GIFT_BAG] = SHOP_TYPE_TOOL,
	[kITEM_BOSS_TICKET] = SHOP_TYPE_TOOL,
	[kITEM_ACTIVITY] = 3
}
THRESHOLD_TAST = 6
ONEMENU = {
	"breakfast",
	"lunch",
	"afternoon_tea",
	"dinner",
	"supper"
}
EATABLETYPE = {
	0,
	102,
	200
}
TIMEOUT_FEED_COST = 10
ALERT_GOLDLAB = 1
ALERT_HORCRUXWORK = 2
ALERT_COMPOUND = 3
ALERT_FAVOREVENT = 4
ALERT_COOK = 5
ALERT_MARKET = 6
ALERT_MAIL = 7
ALERT_SIGN = 8
ALERT_BAG = 9
ALERT_TWISTEGG = 10
ALERT_SHOPTOOL = 11
ALERT_SHOPSUPPLY = 12
ALERT_SHOPDRESS = 13
ALERT_ADVENTURE = 14
ALERT_NEWSOUL = 15
ALERT_NEWEQUIP = 16
ALERT_TASK = 17
ALERT_LAB = 18
ALERT_FAVOR = 19
ALERT_MAIN = 20
ALERT_SOUL = 21
ALERT_MALL = 22
ALERT_SHOP = 23
ALERT_TRAVEL = 24
ALERT_DORM_DR = 25
ALERT_GO_TRAVEL = 26
ALERT_SERVANT_UPDATE = 27
ALERT_TOP_PLOT = 28
ALERT_TRAIN = 29
ALERT_SWIMMING = 30
ALERT_MIDAS = 31
ALERT_FIRST_RECHARGE = 32
ALERT_STRENGTHEN = 33
ALERT_TWIST_TEN = 34
ALERT_ACTIVTIY_NEW_LOG = 35
ALERT_ACTIVTIYNEWLOG_TWISTEGG = 36
ALERT_NEW_HORCRUX = 37
ALERT_NEW_SERVANT = 38
ALERT_NEW_MARKET = 39
ALERT_PATROL = 40
ALERT_NEW_MODE = 41
ALERT_NEW_CHAPTER = 42
ALERT_NEW_TWIST = 43
ALERT_STRENGTHEN_HORCRUX = 44
ALERT_SCHOOL = 45
ALERT_NEW_NOTICE = 46
ALERT_NEW_CHANGEENTER_SCROCE = 47
ALERT_NEW_CHANGEENTER_AREAN = 48
ALERT_NEW_CHANGEENTER_ADE1 = 49
ALERT_NEW_CHANGEENTER_ADE2 = 50
ALERT_NEW_CHANGEENTER_ADE3 = 51
ALERT_NEW_CHANGING = 52
ALERT_RED_CHANGING = 53
ALERT_NEW_CITY = 54
ALERT_NEW_EVENT = 55
ALERT_PATROL_FIGHT = 56
ALERT_STAR_REWARD = 57
ALERT_BATTLE_PASS = 58
ALERT_BATTLE_PASS_TASK = 59
ALERT_ACHIEVE = 60
E_ALERT_ARENATFT_DAILYAWARDS = 61
ALERT_ORDER_NEW = 72
ALERT_ORDER = 73
ALERT_RED_CHANGEENTER_ADE1 = 61
ALERT_RED_CHANGEENTER_ADE2 = 62
ALERT_RED_CHANGEENTER_ADE3 = 63
ALERT_FIRST_INTO_DORM = 64
ALERT_REFRESH_RECHARGE = 66
ALERT_NEW_SHOP_WITH_TWIST = 67
ALERT_BOND = 68
ALERT_SUPERMARKET_NEW = 69
ALERT_SUPERMARKET_FREE = 70
ALERT_DORMITORY_FAVOUR = 74
ALERT_CLOTHES_REWRAD = 75
E_ALERT_OLD_DAILY_TASK = 76
E_ALERT_NEW_DAILY_TASK = 77
E_ALERT_ONLINE_REWARD = 78
E_ALTER_LEVEL_ADVENTURE = 79
ALERT_RED_COMMITY = 100
ALERT_AFK_LEVEL = 101
ALERT_RED_ACTIVITY = 102
E_TIPS_TAG = 200
E_TIPS_LAB_COMPLETE = 201
E_TIPS_PATROL_COMPLETE = 202
E_TIPS_UNLOCK_SERVANT_SLOT = 203
E_TIPS_UNLOCK_HORCRUX_SLOT = 204
E_TIPS_UNLCOK_NEW_RECIPE = 205
E_TIPS_UNLCOK_NEW_CHAPTER = 206
E_TIPS_GET_MONEY = 212
E_TIPS_TRIGGER_TILE = 214
E_TIPS_UNLOCK_PATROL = 220
E_TIPS_TASK_COMPONENT = 230
E_TIPS_GET_BARRAGE_GIFT_RESULT = 231
E_TIPS_NIANSHOU = 233
E_TIPS_GET_MEDAL = 240
E_TIPS_ACHIEVEMENT = 241
E_TIPS_GET_BOND = 251
E_TIPS_HANGUP_UP = 207
E_TIPS_CAN_BOSSFIGHT = 208
PRIMARY_CORE_UNLOCK = 1
ADVANCED_CORE_UNLOCK = 3
COLLEGE_CORE_UNLOCK = 5
COMPONENT_SERVANT_LIMIT = {
	0,
	0,
	0,
	3,
	6,
	6
}
WEAPON_SERVANT_LIMIT = {
	[0] = {
		rank = 0,
		limit = 15
	},
	{
		rank = 1,
		limit = 20
	},
	{
		rank = 2,
		limit = 20
	},
	{
		rank = 3,
		limit = 20
	},
	{
		rank = 4,
		limit = 25
	},
	{
		rank = 5,
		limit = 25
	},
	{
		rank = 6,
		limit = 25
	},
	{
		rank = 7,
		limit = 40
	},
	{
		rank = 8,
		limit = 40
	},
	{
		rank = 9,
		limit = 40
	},
	{
		rank = 10,
		limit = 40
	},
	{
		rank = 11,
		limit = 40
	},
	{
		rank = 12,
		limit = 50
	},
	{
		rank = 13,
		limit = 60
	},
	{
		rank = 14,
		limit = 80
	}
}

setmetatable(WEAPON_SERVANT_LIMIT, {
	__index = function(arg_4_0, arg_4_1)
		return {
			rank = 14,
			limit = 80
		}
	end
})

PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT = 3
PlAYER_CLASS = {
	"初中",
	"高中",
	"大学",
	"研究生",
	"博士"
}
CLASS_TYPE_STR = PlAYER_CLASS
CLASS_TABLE = PlAYER_CLASS
TWISTEGGS_TYPE = {
	wind = 2,
	water = 4,
	fire = 3,
	recommend = 7,
	light = 5,
	dark = 6,
	normal = 1
}
FURNITURE_POS = {
	{
		x = 303,
		y = 129
	},
	{
		x = 96,
		y = 57
	},
	{
		x = 423,
		y = 59
	},
	{
		x = 214,
		y = 57
	},
	{
		x = 490,
		y = 129
	}
}
FURNITURE_ZORDER = {
	1,
	4,
	4,
	3,
	2
}
INITIAL_ACTIVITY = 200
WEAPON_STRENGTHEN_C = 0.5
DORM_DR_ID = 1
DORM_PHOTO_ID = 2
BASIC_GOLD_DROP = 10
BASIC_SP_DROP = 30
BASIC_EXP_DROP = 50
DEFENCE_CONSTANT = 900
MAX_ATTACKSPEED_CONSTANT = 1.4
FIGHT_ATTR_INFO = {
	extra_weak = "予伤降低",
	extra_attackspeed = "攻速",
	extra_energy_defenceconst = "固定额外能量伤害抵抗",
	extra_defence = "额外减伤",
	extra_injure = "受伤提升",
	extra_mechanical_attackconst = "额外固定值机械伤害",
	hp = "血量",
	hematophagy = "吸血",
	critical = "暴击率",
	strike_damage_add = "强击伤害",
	extra_mechanical_injure = "机械受伤提升",
	attackspeed = "攻速",
	extra_mechanical_defenceconst = "额外固定值机械伤害抵抗",
	extra_energy_attack = "额外能量伤害",
	extra_energy_attackconst = "固定额外能量伤害",
	science_point = "科技值",
	defence = "防御值",
	range = "射程",
	healpoint = "每秒百分比恢复血量",
	strike_rate = "额外强击倍率",
	cri_rate = "额外暴击倍率",
	energydefence = "能量防御",
	strike = "强击率",
	extra_energy_defence = "能抗百分比",
	cd_minus = "减冷却",
	exe_critical = "暴击率",
	movingspeed = "移速",
	spellpower = "能级",
	force = "击退距离",
	cd_minus_const = "减冷却",
	hp_percent = "血量",
	spellpower_percent = "奥义",
	extra_attack = "额外伤害",
	extra_energy_weak = "造成能量伤害降低",
	reforce = "击退抵抗",
	extra_rage = "额外充能速率",
	exe_dodge = "闪避率",
	damage = "攻击",
	rage_recover_speed = "自增能量",
	dodge = "闪避率",
	cri_damage_add = "暴击伤害",
	healconst = "每秒固定值恢复血量",
	exe_strike = "强击",
	extra_mechanical_defence = "额外机械伤害抵抗",
	defence_rate = "额外防御倍率",
	extra_defence_const = "额外固定值伤害减免",
	extra_rage_const = "额外充能值",
	tenacity = "控制时长缩短",
	extra_heal = "额外治疗",
	energydefence_rate = "额外能量防御倍率",
	extra_attack_const = "额外固定值伤害",
	healrate = "每秒百分比恢复血量",
	extra_heal_const = "额外恢复固定生命值",
	extra_heal_extern = "额外治疗",
	blind = "致盲",
	extra_mechanical_weak = "机械予伤降低",
	extra_energy_injure = "承受能量伤害加深",
	dodge_damage_add = "闪避减伤",
	exe_strike_resistance = "强击抗性",
	damage_percent = "攻击",
	extra_mechanical_attack = "额外机械伤害",
	energy_attack_resistance = "能量伤害抗性",
	critical_resistance = "暴击抗性",
	mechanical_attack_resistance = "机械伤害抗性"
}
FIGHT_ATTR_DES = {
	extra_weak = "使目标造成的伤害降低",
	extra_attackspeed = "百分比增加攻速",
	extra_energy_defenceconst = "减少固定额外能量伤害",
	extra_defence = "减少所有受到的机械和能量伤害",
	extra_injure = "使目标受到伤害增加",
	extra_mechanical_attackconst = "造成固定额外机械伤害",
	hp = "科技值*血量资质",
	hematophagy = "造成伤害时恢复自身血量",
	critical = "暴击时默认造成200%的伤害",
	strike_damage_add = "额外增加强击伤害",
	extra_mechanical_injure = "承受机械伤害加深",
	attackspeed = "每秒钟普攻次数",
	extra_mechanical_defenceconst = "减少固定机械伤害",
	extra_energy_attack = "造成的能量伤害额外提升",
	extra_energy_attackconst = "固定额外能量伤害",
	science_point = "升级提升科技",
	defence = "可以减少受到的机械伤害",
	range = "最大的攻击距离",
	healpoint = "每秒百分比恢复血量",
	strike_rate = "额外强击倍率",
	cri_rate = "额外暴击倍率",
	energydefence = "减少受到的能量伤害",
	strike = "强击时默认造成150%伤害",
	extra_energy_defence = "降低受到的能量伤害",
	cd_minus = "减冷却",
	exe_critical = "暴击造成200%伤害",
	movingspeed = "每秒钟移动距离",
	spellpower = "能级",
	force = "普攻时击退敌人的距离单位",
	cd_minus_const = "减冷却",
	hp_percent = "血量百分比",
	spellpower_percent = "奥义",
	extra_attack = "提高所有造成的伤害",
	extra_energy_weak = "造成能量伤害降低",
	reforce = "实际击退距离=击退距离-击退抵抗",
	extra_rage = "提升充能速率",
	exe_dodge = "闪避减少50%受到的伤害",
	damage = "科技值*攻击资质",
	rage_recover_speed = "每秒自动恢复怒气",
	dodge = "闪避时默认受到50%的伤害",
	cri_damage_add = "额外提升暴击伤害",
	healconst = "每秒钟恢复的血量",
	exe_strike = "强击造成150%伤害",
	extra_mechanical_defence = "抵消一定量的机械伤害",
	defence_rate = "额外防御倍率",
	extra_defence_const = "抵消一定量的伤害",
	extra_rage_const = "固定充能",
	tenacity = "减益效果时间减少",
	extra_heal = "百分比额外恢复血量",
	energydefence_rate = "额外能量防御倍率",
	extra_attack_const = "额外造成一定量伤害",
	healrate = "每秒钟恢复的血量百分比",
	extra_heal_const = "额外恢复的血量",
	extra_heal_extern = "额外治疗",
	blind = "使机械普攻伤害降为0%",
	extra_mechanical_weak = "造成机械伤害降低",
	extra_energy_injure = "承受能量伤害加深",
	dodge_damage_add = "减少闪避时受到的伤害",
	exe_strike_resistance = "受到的强击概率降低",
	damage_percent = "攻击百分比",
	extra_mechanical_attack = "造成的机械伤害额外提升",
	energy_attack_resistance = "受到的能量伤害百分比降低",
	critical_resistance = "受到的暴击概率降低",
	mechanical_attack_resistance = "受到的机械伤害百分比降低"
}
FIGHT_ATTR_INFO_Filter = {
	extra_attack = "额外伤害",
	strike_damage_add = "强击伤害",
	dodge = "闪避率",
	defence = "防御值",
	energy_attack_resistance = "能量伤害抗性",
	mechanical_attack_resistance = "机械伤害抗性",
	rage_recover_speed = "每秒充能",
	extra_energy_attack = "额外能伤",
	critical = "暴击率",
	exe_strike_resistance = "强击抗性",
	extra_defence = "额外减伤",
	healpoint = "每秒回复",
	energydefence = "能量防御",
	hp_percent = "总血量",
	extra_heal = "额外治疗",
	spellpower = "能级",
	extra_mechanical_attack = "额外机伤",
	critical_resistance = "暴击抗性"
}

local var_0_0 = 13284355
local bit = require("bit")
local var_0_2 = {
	spellpower_percent = bit.bxor(200, 13284355),
	movingspeed = bit.bxor(160000, 13284355),
	force = bit.bxor(40000, 13284355),
	reforce = bit.bxor(40000, 13284355),
	healpoint = bit.bxor(200000, 13284355),
	hp_percent = bit.bxor(100, 13284355),
	damage_percent = bit.bxor(100, 13284355),
	strike = bit.bxor(150000, 13284355),
	dodge = bit.bxor(150000, 13284355),
	critical = bit.bxor(150000, 13284355),
	defence = bit.bxor(100000, 13284355),
	cri_damage_add = bit.bxor(300, 13284355),
	strike_damage_add = bit.bxor(125, 13284355),
	dodge_damage_add = bit.bxor(100, 13284355),
	extra_attackspeed = bit.bxor(200, 13284355),
	damage = bit.bxor(200000, 13284355),
	hp = bit.bxor(6000000, 13284355),
	spellpower = bit.bxor(100000, 13284355),
	extra_energy_defence = bit.bxor(200, 13284355),
	extra_mechanical_defence = bit.bxor(200, 13284355),
	hematophagy = bit.bxor(200, 13284355),
	extra_attack = bit.bxor(80, 13284355),
	extra_defence = bit.bxor(50, 13284355),
	extra_energy_defence = bit.bxor(100, 13284355),
	energydefence = bit.bxor(100000, 13284355),
	extra_heal = bit.bxor(50, 13284355),
	extra_heal_extern = bit.bxor(50, 13284355),
	extra_mechanical_attack = bit.bxor(75, 13284355),
	extra_energy_attack = bit.bxor(50, 13284355),
	rage_recover_speed = bit.bxor(500, 13284355),
	critical_resistance = bit.bxor(72, 13284355),
	exe_strike_resistance = bit.bxor(55, 13284355),
	energy_attack_resistance = bit.bxor(68, 13284355),
	mechanical_attack_resistance = bit.bxor(68, 13284355)
}

FIGHT_ATTR_TRANS_FAC = setmetatable({}, {
	__index = function(arg_5_0, arg_5_1)
		if var_0_2[arg_5_1] then
			return bit.bxor(var_0_2[arg_5_1], var_0_0) / 100000
		else
			return 1
		end
	end
})
FIGHT_ATTR_FORMAT = setmetatable({
	healpoint = function(arg_6_0)
		return string.format("%.2f%%", arg_6_0 * 0.005)
	end,
	strike = function(arg_7_0)
		return string.format("%.1f%%", arg_7_0 * 0.1)
	end,
	dodge = function(arg_8_0)
		return string.format("%.1f%%", arg_8_0 * 0.1)
	end,
	critical = function(arg_9_0)
		return string.format("%.1f%%", arg_9_0 * 0.1)
	end,
	cri_damage_add = function(arg_10_0)
		return string.format("%.1f%%", arg_10_0 * 100)
	end,
	strike_damage_add = function(arg_11_0)
		return string.format("%.1f%%", arg_11_0 * 100)
	end,
	dodge_damage_add = function(arg_12_0)
		return string.format("%.1f%%", arg_12_0 * 100)
	end,
	spellpower = function(arg_13_0)
		return string.format("%.1f%%", arg_13_0 * 0.1)
	end,
	extra_energy_defence = function(arg_14_0)
		return string.format("%.1f%%", arg_14_0 * 100)
	end,
	extra_defence = function(arg_15_0)
		return string.format("%.1f%%", arg_15_0 * 100)
	end,
	extra_attack = function(arg_16_0)
		return string.format("%.1f%%", arg_16_0 * 100)
	end,
	hematophagy = function(arg_17_0)
		return string.format("%.1f%%", arg_17_0 * 100)
	end,
	damage_percent = function(arg_18_0)
		return string.format("%.1f%%", arg_18_0 * 100)
	end,
	extra_attackspeed = function(arg_19_0)
		return string.format("%.1f%%", arg_19_0 * 100)
	end,
	hp_percent = function(arg_20_0)
		return string.format("%.1f%%", arg_20_0 * 100)
	end,
	healrate = function(arg_21_0)
		return string.format("%.1f%%", arg_21_0 * 100)
	end,
	cd_minus = function(arg_22_0)
		return string.format("%.1f%%", arg_22_0 * 100)
	end,
	extra_rage = function(arg_23_0)
		return string.format("%.1f%%", arg_23_0 * 100)
	end,
	tenacity = function(arg_24_0)
		return string.format("%.1f%%", arg_24_0 * 100)
	end,
	extra_heal = function(arg_25_0)
		return string.format("%.1f%%", arg_25_0 * 100)
	end,
	extra_heal_extern = function(arg_26_0)
		return string.format("%.1f%%", arg_26_0 * 100)
	end,
	extra_mechanical_attack = function(arg_27_0)
		return string.format("%.1f%%", arg_27_0 * 100)
	end,
	extra_energy_attack = function(arg_28_0)
		return string.format("%.1f%%", arg_28_0 * 100)
	end,
	rage_recover_speed = function(arg_29_0)
		return string.format("%.1f%%", arg_29_0 * 100)
	end,
	critical_resistance = function(arg_30_0)
		return string.format("%.1f%%", arg_30_0 * 100)
	end,
	exe_strike_resistance = function(arg_31_0)
		return string.format("%.1f%%", arg_31_0 * 100)
	end,
	energy_attack_resistance = function(arg_32_0)
		return string.format("%.1f%%", arg_32_0 * 100)
	end,
	mechanical_attack_resistance = function(arg_33_0)
		return string.format("%.1f%%", arg_33_0 * 100)
	end
}, {
	__index = function(arg_34_0, arg_34_1)
		return function(arg_35_0)
			return arg_35_0
		end
	end,
	__call = function(self, arg_36_1, arg_36_2)
		return self[arg_36_1](arg_36_2)
	end
})
FIGHT_CAPACITY_TRANS = {
	dodge = 0.001,
	strike_damage_add = 0.00125,
	extra_heal_extern = 0.0005,
	defence = 1,
	energy_attack_resistance = 0.0005,
	mechanical_attack_resistance = 0.0005,
	rage_recover_speed = 0.005,
	extra_energy_attack = 0.0005,
	critical = 0.001,
	exe_strike_resistance = 0.0005,
	extra_defence = 1,
	healpoint = 5e-05,
	healrate = 0.001,
	energydefence = 0.001,
	strike = 0.001,
	extra_heal = 0.0005,
	spellpower = 0.001,
	extra_mechanical_attack = 0.00075,
	critical_resistance = 0.0005
}
COMPONENT_MAIN_ATTR = {
	"spellpower",
	"extra_heal_extern",
	"dodge",
	"extra_attack",
	"hp_percent",
	"critical",
	"defence",
	"strike_damage_add",
	"extra_heal",
	"energydefence",
	"extra_defence",
	"extra_mechanical_attack",
	"extra_energy_attack",
	"rage_recover_speed",
	"critical_resistance",
	"exe_strike_resistance",
	"energy_attack_resistance",
	"mechanical_attack_resistance"
}
COMPONENT_SUB_ATTR_INTRO = FIGHT_ATTR_INFO
ATTR_TRANS_FAC = FIGHT_ATTR_TRANS_FAC
SKILL_PASSIVE = 1
SKILL_SKILL1 = 2
MAX_SKILL1_LEVLE = 3
SELECT_HORCRUX_FIGHT = 1
SELECT_HORCRUX_WORK = 2
SELECT_HORCRUX_COMPOUND = 3
SELECT_HORCRUX_ENERGY = 4
SELECT_HORCRUX_EXPLORE = 5
SELECT_HORCRUX_ARENA_DEFENCE = 6
SELECT_HORCRUX_SPECIAL = 7
SELECT_HORCRUX_ARENA_ATTACK = 8
SELECT_HORCRUX_TVT_DEFENCE = 9
SELECT_HORCRUX_TVT_ATTACK = 10
SELECT_HORCRUX_SUBSTITUTION = 11
SELECT_HORCRUX_EXPLORE_HP_INHERIT = 12
SELECT_HORCRUX_FIGHT_POINT = 13
SELECT_HORCRUX_FIGHT_MODE = 14
SELECT_HORCRUX_FIGHT_MATERIAL = 15
SELECT_HORCRUX_FIGHT_ELEMENTS = 16
SELECT_HORCRUX_DEVOUR = 18
SELECT_HORCRUX_SUBSTITUTION_OLD = 17
SELECT_HORCRUX_JUMP_TOWER = 18
SELECT_HORCRUX_BOSS_FIGHT = 19
SELECT_GIRL_AFK_LEVEL = 29
SELECT_HORCRUX_GROUP_FIGHT = 30
SELECT_HORCRUX_FLYCHESS = 31
SELECT_GIRL_FIGHT = 1
SELECT_GIRL_HOME = 2
SELECT_GIRL_DORMITORY = 3
SELECT_GIRL_EXPLORE = 4
SELECT_GIRL_DATABASE = 5
SELECT_GIRL_QUICKFIGHT = 6
SELECT_GIRL_TRAIN = 7
SELECT_GIRL_SWIM = 8
SELECT_GIRL_ARENA_DEFENCE = 9
SELECT_GIRL_SPECIAL = 10
SELECT_GIRL_ARENA_ATTACK = 11
SELECT_GIRL_PATROL = 12
SELECT_GIRL_TVT_DEFENCE = 13
SELECT_GIRL_TVT_ATTACK = 14
SELECT_GIRL_SUBSTITUTION = 15
SELECT_GIRL_EXPLORE_HP_INHERIT = 16
SELECT_GIRL_EXPEDITION = 17
SELECT_GIRL_EXPEDITION_LIST = 18
SELECT_GIRL_FIGHT_POINT = 19
SELECT_GIRL_FIGHT_MODE = 20
SELECT_GIRL_FIGHT_MATERIAL = 21
SELECT_GIRL_FIGHT_ELEMENTS = 22
SELECT_GIRL_TEST_FIGHT_EMPTY = 23
SELECT_GIRL_TEST_FIGHT_PLAYER = 24
SELECT_GIRL_AUTO_CHESS = 25
SELECT_GIRL_SUBSTITUTION_OLD = 26
SELECT_GIRL_ACTIVITY_GARRISON = 27
SELECT_GIRL_JUMP_TOWER = 28
SELECT_GIRL_BOSS_FIGHT = 29
SELECT_GIRL_GROUP_FIGHT = 30
SELECT_GIRL_FLYCHESS = 31
CONFIG_TYPE_NORMAL = 0
CONFIG_TYPE_HANGUP = 1
CONFIG_TYPE_ADVENTURE = 2
CONFIG_TYPE_ARENA = 3
CONFIG_TYPE_ARENA_DEFENCE = 4
CONFIG_TYPE_EXPLORE = 5
CONFIG_TYPE_SWITCHMODE = 6
CONFIG_TYPE_PATROL = 7
CONFIG_TYPE_SCOREARENA = 8
CONFIG_TYPE_REFIGHT = 9
CONFIG_TYPE_TVT_DEFENCE_FORM = 10
CONFIG_TYPE_TVT_ATTACK_FORM = 14
CONFIG_TYPE_SUBSTITUTION = 12
CONFIG_TYPE_FRIEND_FIGHT = 13
CONFIG_TYPE_EXPLORE_HP_INHERIT = 11
CONFIG_TYPE_MODE = 15
CONFIG_TYPE_MATERIAL = 16
CONFIG_TYPE_ADVENTURE_TOWER = 17
CONFIG_TYPE_TEST_FIGHT_EMPTY = 18
CONFIG_TYPE_TEST_FIGHT_PLAYER = 19
CONFIG_TYPE_EXPEDITION = 20
CONFIG_TYPE_SUBSTITUTION_OLD = 21
CONFIG_TYPE_JUMP_TOWER = 22
CONFIG_TYPE_BOSS_FIGHT = 23
CONFIG_TYPE_GROUP_FIGHT = 24
CONFIG_TYPE_FLYCHESS = 25
ARRAY_STAT_FREE = 0
ARRAY_STAT_HANGUP = 1
ARRAY_STAT_PATROL = 2
NEXT_DAY = "HOUR_0"
RECIPE_UNLOCK = -2
RECIPE_LOCK = -1
RECIPE_FREE = 0
RECIPE_WORKING = 1
RECIPE_COMPLETE = 2
PATROL_MAX_ARRAY_NUM = 5
ATTACK_RAGE_FAC = 1.5
HITTED_RAGE_FAC = 1
HEAL_RAGE_FAC = 0
RAGE_ON_KILL = 10
RAGE_RECOVER_SPEED = 0
CURRENCY_DIAMOND = 0
CURRENCY_GOLD = 1
CURRENCY_HORNOR = 2
CURRENCY_EXPLORECOIN = 3
CURRENCY_ENERGY = 4
CURRENCY_SKIN_CARD = 5
CURRENCY_STRENGTHPOINT = 6
CURRENCY_RMB = 100
GIFT_TICKET = 6800601
CURRENCY_STR = {
	diamond = CURRENCY_DIAMOND,
	gold = CURRENCY_GOLD
}
TRANSFORM_REFERENCE = {
	DOWN = 2,
	UP = 1
}
TRANSFORM_UNIT = {
	PX = 1,
	PER = 2
}
LAYER_INTO_TIME = 0.2
LAYER_OUT_TIME = 0.2
PURCHASE_RESULT_ICON_PATH = {
	[kITEM_EQUIPMENT] = "weaponIcon/",
	[kITEM_HORCRUX] = "roleimage/role1/",
	[kITEM_SCULTURE] = "role/wuji/"
}
RUN_HOURSE_LIGHT_PATH = {
	off_line = {
		"public/button/offline_alert_btn_bg.png",
		"public/button/offline_alert_btn_role.png"
	}
}
LEVEL_STARS_NUM = 3
SERVANT_CAREE_TBL = {
	assassin = "ASS",
	shooter = "DEX",
	witcher = "INT",
	fighter = "FIG",
	tank = "STR",
	support = "SUP"
}
L_CV_TABLE = {
	"能登麻美子",
	"川澄绫子",
	"花泽香菜",
	"茅野爱衣",
	"井口裕香",
	"种田梨沙",
	"钉宫理惠",
	"大西沙织",
	"金元寿子",
	"日高里菜",
	"雨宫天",
	"日笠阳子",
	"大空直美",
	"中原麻衣",
	"丰崎爱生",
	"福圆美里",
	"伊藤静",
	"长绳麻理亚",
	"赤﨑千夏",
	"植田佳奈",
	"小泽亚李",
	"松本純子",
	"富田美憂",
	"小野彩",
	"上坂堇",
	"喜多村英梨",
	"立花铃",
	"绫濑桃",
	"水原圣子",
	"田中绘里",
	"佐佐木奈奈"
}
cvToImageTable = {
	[L_CV_TABLE[1]] = "MarketLayer/cv/cv_1.png",
	[L_CV_TABLE[2]] = "MarketLayer/cv/cv_2.png",
	[L_CV_TABLE[3]] = "MarketLayer/cv/cv_3.png",
	[L_CV_TABLE[4]] = "MarketLayer/cv/cv_4.png",
	[L_CV_TABLE[5]] = "MarketLayer/cv/cv_5.png",
	[L_CV_TABLE[6]] = "MarketLayer/cv/cv_6.png",
	[L_CV_TABLE[7]] = "MarketLayer/cv/cv_7.png",
	[L_CV_TABLE[8]] = "MarketLayer/cv/cv_8.png",
	[L_CV_TABLE[9]] = "MarketLayer/cv/cv_9.png",
	[L_CV_TABLE[10]] = "MarketLayer/cv/cv_10.png",
	[L_CV_TABLE[11]] = "MarketLayer/cv/cv_11.png",
	[L_CV_TABLE[12]] = "MarketLayer/cv/cv_12.png",
	[L_CV_TABLE[13]] = "MarketLayer/cv/cv_13.png",
	[L_CV_TABLE[14]] = "MarketLayer/cv/cv_14.png",
	[L_CV_TABLE[15]] = "MarketLayer/cv/cv_15.png",
	[L_CV_TABLE[16]] = "MarketLayer/cv/cv_16.png",
	[L_CV_TABLE[17]] = "MarketLayer/cv/cv_17.png",
	[L_CV_TABLE[18]] = "MarketLayer/cv/cv_18.png",
	[L_CV_TABLE[19]] = "MarketLayer/cv/cv_19.png",
	[L_CV_TABLE[20]] = "MarketLayer/cv/cv_20.png",
	[L_CV_TABLE[21]] = "MarketLayer/cv/cv_21.png",
	[L_CV_TABLE[22]] = "MarketLayer/cv/cv_22.png",
	[L_CV_TABLE[23]] = "MarketLayer/cv/cv_23.png",
	[L_CV_TABLE[24]] = "MarketLayer/cv/cv_24.png",
	[L_CV_TABLE[25]] = "MarketLayer/cv/cv_25.png",
	[L_CV_TABLE[26]] = "MarketLayer/cv/cv_26.png",
	[L_CV_TABLE[27]] = "MarketLayer/cv/cv_27.png",
	[L_CV_TABLE[28]] = "MarketLayer/cv/cv_28.png",
	[L_CV_TABLE[29]] = "MarketLayer/cv/cv_29.png",
	[L_CV_TABLE[30]] = "MarketLayer/cv/cv_30.png",
	[L_CV_TABLE[31]] = "MarketLayer/cv/cv_31.png"
}
SHOW_TYPE_NORMAL = 0
SHOW_TYPE_FIGHT = 1
SHOW_TYPE_ARENA = 2
SHOW_TYPE_LAB = 3
SHOW_TYPE_MAIN = 4
SHOW_TYPE_FIGHTLAYER = 5
SHOW_TYPE_DROP_PREVIEW = 6
SHOW_TYPE_TWISTEGG_PREVIEW = 7
ANNIVERSARY_EXPLORE_ERROR = {
	time = "未到开始时间",
	level = "通关上一个章节"
}
CURRENCY_DIAMOND_PAID = 8888888
CONSOLE_COLOR_BLACK = 0
CONSOLE_COLOR_BLUE = 1
CONSOLE_COLOR_DARK_GREEN = 2
CONSOLE_COLOR_SKY_BLUE = 3
CONSOLE_COLOR_RED = 4
CONSOLE_COLOR_PUCE = 5
CONSOLE_COLOR_YELLO = 6
CONSOLE_COLOR_DARK_WHITE = 7
CONSOLE_COLOR_GREY = 8
CONSOLE_COLOR_INDIGO = 9
CONSOLE_COLOR_GREEN = 10
CONSOLE_COLOR_CYAN = 11
CONSOLE_COLOR_PINK = 12
CONSOLE_COLOR_PURPLE = 13
CONSOLE_COLOR_LIGHT_GOLD = 14
CONSOLE_COLOR_WHITE = 15
CONSOLE_BG_COLOR_BLACK = 0
CONSOLE_BG_COLOR_BLUE = 16
CONSOLE_COLOR_DARK_GREEN = 32
CONSOLE_BG_COLOR_SKY_BLUE = 48
CONSOLE_BG_COLOR_RED = 64
CONSOLE_BG_COLOR_PUCE = 80
CONSOLE_BG_COLOR_YELLO = 96
CONSOLE_BG_COLOR_DARK_WHITE = 112
CONSOLE_BG_COLOR_GREY = 128
CONSOLE_BG_COLOR_INDIGO = 144
CONSOLE_BG_COLOR_GREEN = 160
CONSOLE_BG_COLOR_CYAN = 176
CONSOLE_BG_COLOR_PINK = 192
CONSOLE_BG_COLOR_PURPLE = 208
CONSOLE_BG_COLOR_LIGHT_GOLD = 224
CONSOLE_BG_COLOR_WHITE = 240
ACTIVITY_LEVEL_FONT_PATH = {
	Default = {
		size = 20,
		path = "fonts/name.ttf"
	},
	[186] = {
		size = 28,
		path = "fonts/W5.ttf"
	}
}
OPEN_BAG_ORDER = {
	[kITEM_ACTIVITY] = 1,
	[kITEM_SERVANT_CHIP] = 2,
	[kITEM_CHOOSE_GIFT] = 3,
	[kITEM_GIFT_BAG] = 4,
	[kITEM_RING_MARRY] = 5,
	[kITEM_AWARD_TICKET] = 6,
	[kITEM_SKIN] = 7,
	[kITEM_HORCRUX] = 8,
	[kITEM_HORCRUX_CHIP] = 9
}

setmetatable(OPEN_BAG_ORDER, {
	__index = function(arg_37_0, arg_37_1)
		return arg_37_1
	end
})

ALMIGHTY_WEAPON = 2000000
GO_BUY_TICKET_TAB = 523
EXPEDITION = {
	SEASONTYPE = {
		Expedition = 1,
		Monopoly = 2
	},
	LEVELSTATUS = {
		Free = 1,
		NeedEvent = 3,
		NeedResult = 4,
		NeedBattle = 2
	},
	ROOMSTATUS = {
		CanOperate = 3,
		HaveGot = 1,
		NotOperate = 4,
		HaveMiss = 2
	},
	SHOP_ITEMTYPE = {
		REBORN = 2,
		SKILL = 1
	},
	FIGHT_RESULT = {
		FAILED = 3,
		TIME_OUT = 1,
		MAX_DAMAGE = 2,
		SUCESS = 4
	},
	EVENT_TYPE = {
		Reborn = 2,
		Skill = 4,
		Drop = 6,
		Blood = 1,
		Clear = 7,
		Recruit = 3,
		Step = 5
	}
}
RARITY_STR_TBL = {
	"r",
	"sr",
	"ur",
	"mr",
	"sp"
}
BIRTHDAY_PARTY = {
	CongratulationStatus = {
		CAN_USE = 2,
		HAVE_UESD = 3,
		NOT_START = 1
	}
}
ExpeditionRoomType = {
	Elite = 3,
	TowerDefenceNormal = 9,
	TowerDefenceBoss = 11,
	Random = 4,
	Recruit = 6,
	Start = 1,
	Rest = 5,
	Boss = 7,
	Transmit = 8,
	TowerDefenceElite = 10,
	Normal = 2
}
FORMATION_SHOW_GIRL_NUM = 5
HORCRUX_DEVOUR_MAX = 4
SHOP_NORMAL_BUY_LIMIT_NUM = 100
RECRUIT_ROLE = {
	ROLE_LIST_STATUS = {
		CAN_RECRUIT = 3,
		LOCK = 1,
		GO_RECRUIT = 2,
		HAVE_GOTTED = 4
	},
	TASK_LIST_STATUS = {
		CAN_TASK = 1,
		HAVE_TASK = 3,
		GO_TASK = 2
	}
}
EXPEDITION_MODE_ID = 119
MONOPOLY_MODE_ID = 127
ACTIVITY_WARORDER_ID = 218
ACTIVITY_BIRTHDAYPARTY_ENTRANCE_ID = 30410001
GUIDE_APPSTAR_AND_DEBUG = 1
MARRY_LEVEL = 6
REAL_ROLE_LEVEL_TYPES = {
	[FIGHTTYPE_NORMAL] = true,
	[FIGHTTYPE_SCOREARENA] = true,
	[FIGHTTYPE_ADVENTURE_TOWER] = true,
	[FIGHTTYPE_EXPEDITION] = true,
	[FIGHTTYPE_EXPEDITION_TOWER] = true,
	[FIGHTTYPE_EXPEDITION_MONOPOLY] = true,
	[FIGHTTYPE_STAKE_PVP] = true,
	[FIGHTTYPE_STAKE_PVE] = true,
	[FIGHTTYPE_ADVENTURE] = true
}
FORMATION_TYPE_TO_FIGHT_TYPE = {
	[CONFIG_TYPE_NORMAL] = FIGHTTYPE_NORMAL,
	[CONFIG_TYPE_HANGUP] = FIGHTTYPE_NORMAL,
	[CONFIG_TYPE_ADVENTURE] = FIGHTTYPE_ADVENTURE,
	[CONFIG_TYPE_ARENA] = FIGHTTYPE_ARENA,
	[CONFIG_TYPE_ARENA_DEFENCE] = FIGHTTYPE_ARENA,
	[CONFIG_TYPE_EXPLORE] = FIGHTTYPE_EXPLORE,
	[CONFIG_TYPE_SCOREARENA] = FIGHTTYPE_SCOREARENA,
	[CONFIG_TYPE_TVT_DEFENCE_FORM] = FIGHTTYPE_ARENATFT,
	[CONFIG_TYPE_TVT_ATTACK_FORM] = FIGHTTYPE_ARENATFT,
	[CONFIG_TYPE_SUBSTITUTION] = FIGHTTYPE_SUBSTITUTION,
	[CONFIG_TYPE_FRIEND_FIGHT] = FIGHTTYPE_FRIENDFIGHT,
	[CONFIG_TYPE_ADVENTURE_TOWER] = FIGHTTYPE_ADVENTURE_TOWER,
	[CONFIG_TYPE_EXPLORE_HP_INHERIT] = FIGHTTYPE_EXPLORE,
	[CONFIG_TYPE_SUBSTITUTION_OLD] = FIGHTTYPE_SUBSTITUTION_OLD,
	[CONFIG_TYPE_GROUP_FIGHT] = FIGHTTYPE_GROUP
}
CONTRACT_ATTR_ADD = 0.0015
CITY_CURRENCY_LIST = {
	AM = "MOP$",
	CN = "￥",
	HK = "HK$",
	TW = "NT$"
}
CITY_KEY_LIST = {
	AM = "hkd",
	CN = "rmb",
	HK = "hkd",
	TW = "twd"
}
TWIST_CHANGE_DES = {
	nil,
	nil,
	"每个角色扩招池的保底单独计算",
	"每个元素扩招池的保底单独计算",
	"每个节日服饰扩招保底单独计算"
}
L_ONCE_RECHARGE_NOVICE = 8999
L_ONCE_RECHARGE_BACK = 99902
SERVANT_CORE_BREAK_MAX = 11
GUIDE_LEVEL_NEW = 1
GUIDE_LEVEL_OLD = 2
SHOP_SKIN_ATTR_ID = {
	"wind",
	"fire",
	"water",
	"light",
	"dark",
	"imaginary",
	"devil",
	"zerosupperession",
	"positive",
	"mimicry",
	"other"
}
SHOP_SKIN_ATTR_NAME = {
	"电磁",
	"热能",
	"量子",
	"光能",
	"暗物质",
	"虚数",
	"反物质",
	"异构",
	"正能量",
	"拟态",
	"其他"
}
BOOSTER_PACKS = 160
PROMOTION_PACKS = 161
WEAPOM_PACKS = 162
ASSISTS_PACKS = 163
SKINS_PACKS = 164
QUICK_FORMATION_ISNEW_SORT_UNLOCK_LEVEL = 3001
FIGHTLAYER_UNLOCK_TIPS_SHOWLEVEL = 1005
FIGHTLAYER_UNLOCK_TIPS = {
	{
		text = "扭蛋",
		unlock_level = 2010
	},
	{
		text = "闯关挑战",
		unlock_level = UNLOCK_SHILIANTA
	},
	{
		text = "积分赛",
		unlock_level = UNLOCK_SCOREARENA
	},
	{
		text = "魂力之塔",
		unlock_level = UNLOCK_WEEKLYTOWERD
	},
	{
		text = "危机行动",
		unlock_level = UNLOCK_EXPLOREOFFERLAYER
	},
	{
		text = "抢位赛",
		unlock_level = UNLOCK_ARENA
	},
	{
		text = "极限拟练",
		unlock_level = UNLOCK_SUBSTITUTION2
	},
	{
		text = "超频战场",
		unlock_level = UNLOCK_SUBSTITUTION
	},
	{
		text = "战争模式",
		unlock_level = UNLOCK_LIMITTOWERDEFENCELEVEL
	},
	{
		text = "团体赛",
		unlock_level = UNLOCK_THREE_VS_THREE
	}
}
HORCRUX_RECOMMEND_NUM = 4
HORCRUX_SCORE_CAREER_ADD = {
	tank = {
		damage = 0.1,
		hp = 0.9
	},
	fighter = {
		damage = 0.6,
		hp = 0.4
	},
	assassin = {
		damage = 0.8,
		hp = 0.2
	},
	shooter = {
		damage = 0.9,
		hp = 0.1
	},
	support = {
		damage = 0.3,
		hp = 0.7
	},
	witcher = {
		damage = 0.7,
		hp = 0.3
	},
	other = {
		damage = 0.5,
		hp = 0.5
	}
}
