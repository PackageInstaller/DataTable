local var_0_0 = class("MusicBeatGameConst")

var_0_0.bgm_type_default = 1
var_0_0.bgm_type_main = 2
var_0_0.bgm_type_game = 3
var_0_0.bgm_type_intro = 4
var_0_0.menu_bgm = "story-game-rhythm"
var_0_0.game_time = 0
var_0_0.rule_tip = "musicbeat_minigame_help"
var_0_0.rank_tip = "musicbeat_minigame_help"
var_0_0.frame_rate = Application.targetFrameRate or 60
var_0_0.ui_atlas = "ui/minigameui/musicbeatgameui_atlas"
var_0_0.game_ui = "MusicBeatGameUI"
var_0_0.game_room_ui = "MusicBeatGameUI"
var_0_0.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
var_0_0.mini_game_id = 88
var_0_0.game_room_id = 88
var_0_0.sfx_plane_success_hit = "event:/ui/beat-wrong-hit"
var_0_0.sfx_plane_success_touch = "event:/ui/beat-wrong-hit"
var_0_0.sfx_plane_faild_hit = "event:/ui/beat-wrong-hit"
var_0_0.sfx_plane_faild_touch = "event:/ui/beat-wrong-catch"
var_0_0.sfx_plane_miss = "event:/ui/baozha1"
var_0_0.trigger_key_touch = "K_TOUCH"
var_0_0.trigger_key_drag = "K_DRAG"
var_0_0.beat_offset = 250
var_0_0.map_type_plane = 1
var_0_0.map_data = {
	{
		id = 1,
		node_lua = "beat_song_02",
		map_scene = {
			{
				name = "map_plane_1",
				type = var_0_0.map_type_plane,
				items = {
					{
						act = "touch",
						score = 500,
						track_key = "K_TOUCH",
						index = 1,
						prefab = "tpl/F4F",
						distance_time = 1000,
						sfx_success = var_0_0.sfx_plane_success,
						sfx_fail = var_0_0.sfx_plane_faild,
						sfx_success = var_0_0.sfx_plane_miss
					},
					{
						act = "touch",
						score = 500,
						track_key = "K_TOUCH",
						index = 2,
						prefab = "tpl/F6F",
						distance_time = 1000,
						sfx_success = var_0_0.sfx_plane_success,
						sfx_fail = var_0_0.sfx_plane_faild,
						sfx_success = var_0_0.sfx_plane_miss
					},
					{
						act = "touch",
						score = 500,
						track_key = "K_TOUCH",
						index = 3,
						prefab = "tpl/sb2c",
						distance_time = 1000,
						sfx_success = var_0_0.sfx_plane_success,
						sfx_fail = var_0_0.sfx_plane_faild,
						sfx_success = var_0_0.sfx_plane_miss
					},
					{
						act = "touch",
						score = 500,
						track_key = "K_TOUCH",
						index = 4,
						prefab = "tpl/SBDwuwei_2",
						distance_time = 1000,
						sfx_success = var_0_0.sfx_plane_success,
						sfx_fail = var_0_0.sfx_plane_faild,
						sfx_success = var_0_0.sfx_plane_miss
					},
					{
						act = "flap",
						score = 500,
						track_key = "K_TOUCH",
						index = 5,
						prefab = "tpl/chengzi",
						distance_time = 1000,
						sfx_success = var_0_0.sfx_plane_success,
						sfx_fail = var_0_0.sfx_plane_faild,
						sfx_success = var_0_0.sfx_plane_miss
					},
					{
						act = "flap",
						score = 500,
						track_key = "K_TOUCH",
						index = 6,
						prefab = "tpl/xiangjiao",
						distance_time = 1000,
						sfx_success = var_0_0.sfx_plane_success,
						sfx_fail = var_0_0.sfx_plane_faild,
						sfx_success = var_0_0.sfx_plane_miss
					},
					{
						act = "flap",
						score = 500,
						track_key = "K_TOUCH",
						index = 7,
						prefab = "tpl/ningmeng",
						distance_time = 1000,
						sfx_success = var_0_0.sfx_plane_success,
						sfx_fail = var_0_0.sfx_plane_faild,
						sfx_success = var_0_0.sfx_plane_miss
					},
					{
						score = 500,
						prefab = "tpl/daningmeng",
						final = true,
						track_key = "K_TOUCH",
						index = 8,
						distance_time = 1000,
						act = "flap",
						sfx_success = var_0_0.sfx_plane_success,
						sfx_fail = var_0_0.sfx_plane_faild,
						sfx_success = var_0_0.sfx_plane_miss
					}
				}
			}
		}
	}
}
var_0_0.beat_prepare = 3000

return var_0_0
