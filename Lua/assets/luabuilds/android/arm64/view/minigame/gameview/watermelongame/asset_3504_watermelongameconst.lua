local WatermelonGameConst = class("WatermelonGameConst")

WatermelonGameConst.menu_bgm = "story-richang-rosy-short"
WatermelonGameConst.game_bgm = "story-richang-rosy-short"
WatermelonGameConst.game_time = 0
WatermelonGameConst.rule_tip = "watermelon_minigame_help"
WatermelonGameConst.rank_tip = "pipe_minigame_rank"
WatermelonGameConst.frame_rate = Application.targetFrameRate or 60
WatermelonGameConst.ui_atlas = "ui/minigameui/watermelongameui_atlas"
WatermelonGameConst.game_ui = "WatermelonGameUI"
WatermelonGameConst.game_room_ui = "GameRoomWatermelonUI"
WatermelonGameConst.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
WatermelonGameConst.SFX_SOUND_FIRE = "event:/ui/kaipao"
WatermelonGameConst.SFX_SOUND_BOOM = "event:/ui/baozha3"
WatermelonGameConst.SFX_SOUND_SKILL = "event:/ui/chongneng"
WatermelonGameConst.SFX_SOUND_ITEM = "event:/ui/mini_shine"
WatermelonGameConst.ball_data = {
	{
		id = 1,
		size = 47,
		score = 0,
		next_id = 2
	},
	{
		id = 2,
		size = 55,
		score = 100,
		next_id = 3
	},
	{
		id = 3,
		size = 68,
		score = 200,
		next_id = 4
	},
	{
		id = 4,
		size = 80,
		score = 400,
		next_id = 5
	},
	{
		id = 5,
		size = 92,
		score = 800,
		next_id = 6
	},
	{
		id = 6,
		size = 108,
		score = 1600,
		next_id = 7
	},
	{
		id = 7,
		size = 120,
		score = 3200,
		next_id = 8
	},
	{
		id = 8,
		size = 132,
		score = 6400,
		next_id = 9
	},
	{
		id = 9,
		size = 143,
		score = 12800,
		next_id = 10
	},
	{
		id = 10,
		size = 152,
		score = 25600,
		next_id = 11
	},
	{
		id = 11,
		size = 168,
		score = 51200
	}
}
WatermelonGameConst.drop_ball_ids = {
	{
		id = 1,
		weight = 20
	},
	{
		id = 2,
		weight = 20
	},
	{
		id = 3,
		weight = 20
	},
	{
		id = 4,
		weight = 20
	},
	{
		id = 5,
		weight = 20
	}
}
WatermelonGameConst.enter_top_over_time = 3
WatermelonGameConst.tpl_ball = "ball"
WatermelonGameConst.ball_count_id = 0

return WatermelonGameConst
