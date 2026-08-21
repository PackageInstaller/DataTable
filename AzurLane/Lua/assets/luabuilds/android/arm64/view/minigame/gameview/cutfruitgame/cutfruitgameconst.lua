local var_0_0 = class("CutFruitGameConst")

var_0_0.menu_bgm = "story-richang-rosy-short"
var_0_0.game_bgm = "main-chunjie-pv"
var_0_0.game_time = 80
var_0_0.rule_tip = "pac_minigame_help"
var_0_0.rank_tip = "pipe_minigame_rank"
var_0_0.frame_rate = Application.targetFrameRate or 60
var_0_0.ui_atlas = "ui/minigameui/cutfruitgameui_atlas"
var_0_0.game_ui = "CutFruitGameUI"
var_0_0.game_room_ui = "CutFruitGameUI"
var_0_0.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
var_0_0.DIRECT_UP = 1
var_0_0.DIRECT_LEFT = 2
var_0_0.DIRECT_DOWN = 3
var_0_0.DIRECT_RIGHT = 4
var_0_0.DIRECT_ROTATION = {
	{
		rotation = Vector3(0, 0, 0)
	},
	{
		rotation = Vector3(0, 0, 90)
	},
	{
		rotation = Vector3(0, 0, 180)
	},
	{
		rotation = Vector3(0, 0, 270)
	}
}
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
