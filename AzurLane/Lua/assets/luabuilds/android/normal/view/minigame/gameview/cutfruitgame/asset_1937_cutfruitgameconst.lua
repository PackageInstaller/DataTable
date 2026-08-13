class = var_0_10000

local var_0_0 = var_0_10000("CutFruitGameConst")

var_0_0.menu_bgm = "story-richang-rosy-short"
var_0_0.game_bgm = "main-chunjie-pv"
var_0_0.game_time = 80
var_0_0.rule_tip = "pac_minigame_help"
var_0_0.rank_tip = "pipe_minigame_rank"
Application = var_1

local var_0_1

if not var_1.targetFrameRate then
	var_0_1 = 60
end

var_0_0.frame_rate = var_0_1
var_0_0.ui_atlas = "ui/minigameui/cutfruitgameui_atlas"
var_0_0.game_ui = "CutFruitGameUI"
var_0_0.game_room_ui = "CutFruitGameUI"
var_0_0.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
var_0_0.DIRECT_UP = 1
var_0_0.DIRECT_LEFT = 2
var_0_0.DIRECT_DOWN = 3
var_0_0.DIRECT_RIGHT = 4

local var_0_2 = {}
local var_0_3 = {}

Vector3 = var_0_10003
var_0_3.rotation = var_0_10003(0, 0, 0)
var_0_2[1] = var_0_3

local var_0_4 = {}

Vector3 = var_3
var_0_4.rotation = var_3(0, 0, 90)
var_0_2[2] = var_0_4

local var_0_5 = {}

Vector3 = var_3
var_0_5.rotation = var_3(0, 0, 180)
var_0_2[3] = var_0_5

local var_0_6 = {}

Vector3 = var_3
var_0_6.rotation = var_3(0, 0, 270)
var_0_2[4] = var_0_6
var_0_0.DIRECT_ROTATION = var_0_2
var_0_0.character_num = 6
var_0_0.character_name = {
	"doagame_qiannai",
	"doagame_paidi",
	"doagame_na",
	"doagame_xiangdi",
	"doagame_yilisi",
	"doagame_zhuzi"
}
var_0_0.chapter_data = {
	{
		speed = 75,
		distance = 100,
		time = 60,
		char = 1,
		target = 680,
		npc = {}
	},
	{
		speed = 75,
		distance = 100,
		time = 60,
		char = 1,
		target = 680,
		npc = {}
	},
	{
		speed = 75,
		distance = 100,
		time = 60,
		char = 1,
		target = 680,
		npc = {}
	},
	{
		speed = 75,
		distance = 100,
		time = 60,
		char = 1,
		target = 680,
		npc = {}
	},
	{
		speed = 75,
		distance = 100,
		time = 60,
		char = 1,
		target = 680,
		npc = {}
	},
	{
		speed = 75,
		distance = 100,
		time = 60,
		char = 1,
		target = 680,
		npc = {}
	},
	{
		speed = 75,
		distance = 100,
		time = 60,
		char = 1,
		target = 680,
		npc = {}
	}
}

return var_0_0
