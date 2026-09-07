local MusicBeatGameConst = class("MusicBeatGameConst")

MusicBeatGameConst.bgm_type_default = 1
MusicBeatGameConst.bgm_type_main = 2
MusicBeatGameConst.bgm_type_game = 3
MusicBeatGameConst.bgm_type_intro = 4
MusicBeatGameConst.menu_bgm = "story-game-rhythm"
MusicBeatGameConst.game_time = 0
MusicBeatGameConst.rule_tip = "musicbeat_minigame_help"
MusicBeatGameConst.rank_tip = "musicbeat_minigame_help"
MusicBeatGameConst.frame_rate = Application.targetFrameRate or 60
MusicBeatGameConst.ui_atlas = "ui/minigameui/musicbeatgameui_atlas"
MusicBeatGameConst.game_ui = "MusicBeatGameUI"
MusicBeatGameConst.game_room_ui = "MusicBeatGameUI"
MusicBeatGameConst.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
MusicBeatGameConst.mini_game_id = 88
MusicBeatGameConst.game_room_id = 88
MusicBeatGameConst.sfx_plane_success_hit = "event:/ui/beat-wrong-hit"
MusicBeatGameConst.sfx_plane_success_touch = "event:/ui/beat-wrong-hit"
MusicBeatGameConst.sfx_plane_faild_hit = "event:/ui/beat-wrong-hit"
MusicBeatGameConst.sfx_plane_faild_touch = "event:/ui/beat-wrong-catch"
MusicBeatGameConst.sfx_plane_miss = "event:/ui/baozha1"
MusicBeatGameConst.trigger_key_touch = "K_TOUCH"
MusicBeatGameConst.trigger_key_drag = "K_DRAG"
MusicBeatGameConst.beat_offset = 250
MusicBeatGameConst.map_type_plane = 1
MusicBeatGameConst.map_data = {
	{
		id = 1,
		node_lua = "beat_song_02",
		map_scene = {
			{
				name = "map_plane_1",
				type = MusicBeatGameConst.map_type_plane,
				items = {
					{
						act = "touch",
						score = 500,
						track_key = "K_TOUCH",
						index = 1,
						prefab = "tpl/F4F",
						distance_time = 1000,
						sfx_success = MusicBeatGameConst.sfx_plane_success,
						sfx_fail = MusicBeatGameConst.sfx_plane_faild,
						sfx_success = MusicBeatGameConst.sfx_plane_miss
					},
					{
						act = "touch",
						score = 500,
						track_key = "K_TOUCH",
						index = 2,
						prefab = "tpl/F6F",
						distance_time = 1000,
						sfx_success = MusicBeatGameConst.sfx_plane_success,
						sfx_fail = MusicBeatGameConst.sfx_plane_faild,
						sfx_success = MusicBeatGameConst.sfx_plane_miss
					},
					{
						act = "touch",
						score = 500,
						track_key = "K_TOUCH",
						index = 3,
						prefab = "tpl/sb2c",
						distance_time = 1000,
						sfx_success = MusicBeatGameConst.sfx_plane_success,
						sfx_fail = MusicBeatGameConst.sfx_plane_faild,
						sfx_success = MusicBeatGameConst.sfx_plane_miss
					},
					{
						act = "touch",
						score = 500,
						track_key = "K_TOUCH",
						index = 4,
						prefab = "tpl/SBDwuwei_2",
						distance_time = 1000,
						sfx_success = MusicBeatGameConst.sfx_plane_success,
						sfx_fail = MusicBeatGameConst.sfx_plane_faild,
						sfx_success = MusicBeatGameConst.sfx_plane_miss
					},
					{
						act = "flap",
						score = 500,
						track_key = "K_TOUCH",
						index = 5,
						prefab = "tpl/chengzi",
						distance_time = 1000,
						sfx_success = MusicBeatGameConst.sfx_plane_success,
						sfx_fail = MusicBeatGameConst.sfx_plane_faild,
						sfx_success = MusicBeatGameConst.sfx_plane_miss
					},
					{
						act = "flap",
						score = 500,
						track_key = "K_TOUCH",
						index = 6,
						prefab = "tpl/xiangjiao",
						distance_time = 1000,
						sfx_success = MusicBeatGameConst.sfx_plane_success,
						sfx_fail = MusicBeatGameConst.sfx_plane_faild,
						sfx_success = MusicBeatGameConst.sfx_plane_miss
					},
					{
						act = "flap",
						score = 500,
						track_key = "K_TOUCH",
						index = 7,
						prefab = "tpl/ningmeng",
						distance_time = 1000,
						sfx_success = MusicBeatGameConst.sfx_plane_success,
						sfx_fail = MusicBeatGameConst.sfx_plane_faild,
						sfx_success = MusicBeatGameConst.sfx_plane_miss
					},
					{
						score = 500,
						prefab = "tpl/daningmeng",
						final = true,
						track_key = "K_TOUCH",
						index = 8,
						distance_time = 1000,
						act = "flap",
						sfx_success = MusicBeatGameConst.sfx_plane_success,
						sfx_fail = MusicBeatGameConst.sfx_plane_faild,
						sfx_success = MusicBeatGameConst.sfx_plane_miss
					}
				}
			}
		}
	}
}
MusicBeatGameConst.beat_prepare = 3000

return MusicBeatGameConst
