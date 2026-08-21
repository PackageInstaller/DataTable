local var_0_0 = class("WatermelonGameConst")

var_0_0.menu_bgm = "story-richang-rosy-short"
var_0_0.game_bgm = "story-richang-rosy-short"
var_0_0.game_time = 0
var_0_0.rule_tip = "watermelon_minigame_help"
var_0_0.rank_tip = "pipe_minigame_rank"
var_0_0.frame_rate = Application.targetFrameRate or 60
var_0_0.ui_atlas = "ui/minigameui/watermelongameui_atlas"
var_0_0.game_ui = "WatermelonGameUI"
var_0_0.game_room_ui = "GameRoomWatermelonUI"
var_0_0.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
var_0_0.SFX_SOUND_FIRE = "event:/ui/kaipao"
var_0_0.SFX_SOUND_BOOM = "event:/ui/baozha3"
var_0_0.SFX_SOUND_SKILL = "event:/ui/chongneng"
var_0_0.SFX_SOUND_ITEM = "event:/ui/mini_shine"
var_0_0.ball_data = {
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
var_0_0.drop_ball_ids = {
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
var_0_0.enter_top_over_time = 3
var_0_0.tpl_ball = "ball"
var_0_0.ball_count_id = 0

return var_0_0
