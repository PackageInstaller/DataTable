local CutFruitGameConst = class("CutFruitGameConst")

CutFruitGameConst.menu_bgm = "story-richang-rosy-short"
CutFruitGameConst.game_bgm = "main-chunjie-pv"
CutFruitGameConst.game_time = 80
CutFruitGameConst.rule_tip = "pac_minigame_help"
CutFruitGameConst.rank_tip = "pipe_minigame_rank"
CutFruitGameConst.frame_rate = Application.targetFrameRate or 60
CutFruitGameConst.ui_atlas = "ui/minigameui/cutfruitgameui_atlas"
CutFruitGameConst.game_ui = "CutFruitGameUI"
CutFruitGameConst.game_room_ui = "CutFruitGameUI"
CutFruitGameConst.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
CutFruitGameConst.DIRECT_UP = 1
CutFruitGameConst.DIRECT_LEFT = 2
CutFruitGameConst.DIRECT_DOWN = 3
CutFruitGameConst.DIRECT_RIGHT = 4
CutFruitGameConst.DIRECT_ROTATION = {
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
CutFruitGameConst.character_num = 6
CutFruitGameConst.character_name = {
	"doagame_qiannai",
	"doagame_paidi",
	"doagame_na",
	"doagame_xiangdi",
	"doagame_yilisi",
	"doagame_zhuzi"
}
CutFruitGameConst.chapter_data = {
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

return CutFruitGameConst
