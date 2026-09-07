local SortGameConst = class("SortGameConst")

SortGameConst.menu_bgm = "story-richang-wavelight"
SortGameConst.game_bgm = "story-richang-wavelight"
SortGameConst.game_time = 240
SortGameConst.rule_tip = "sort_minigame_help"
SortGameConst.frame_rate = Application.targetFrameRate or 60
SortGameConst.ui_atlas = "ui/minigameui/sortgameui_atlas"
SortGameConst.game_ui = "SortGameUI"
SortGameConst.game_room_ui = "GameRoomSortUI"
SortGameConst.grid_bound = {
	338,
	245
}
SortGameConst.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
SortGameConst.SFX_PASS = "event:/ui/mini_miss"
SortGameConst.grid_max_layer = 2
SortGameConst.grid_type_empty = 0
SortGameConst.grid_type_normal = 1
SortGameConst.grid_type_two = 2
SortGameConst.grid_type_out = 3
SortGameConst.sort_conifg_type_time = 1
SortGameConst.sort_conifg_type_combo = 2
SortGameConst.sort_conifg_type_wait = 3
SortGameConst.sort_conifg_type_chat = 4
SortGameConst.pass_limit_num = 7
SortGameConst.init_pass_num = 4
SortGameConst.combo_time = 10
SortGameConst.combo_rate = {
	{
		rate = 1,
		range = {
			1,
			8
		}
	},
	{
		rate = 1.2,
		range = {
			9,
			16
		}
	},
	{
		rate = 1.5,
		range = {
			17,
			26
		}
	},
	{
		rate = 2,
		range = {
			27,
			80
		}
	}
}
SortGameConst.combo_effect_count = {
	9,
	17,
	27
}
SortGameConst.score_num = 200
SortGameConst.wanted_score_num = 500
SortGameConst.common_item_id = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12,
	13,
	14,
	15,
	16,
	17,
	18,
	19,
	20,
	21,
	22,
	23,
	24,
	25,
	26,
	27,
	28,
	29,
	30,
	31,
	32,
	33,
	34,
	35,
	36,
	37,
	38,
	39,
	40,
	41,
	42,
	43,
	44,
	45,
	46,
	47,
	48,
	49,
	50
}
SortGameConst.wanted_refresh_time = 1
SortGameConst.wanted_rate = 1
SortGameConst.wanted_step_time = 20
SortGameConst.time_trans_score = 20
SortGameConst.last_speak_time = 30
SortGameConst.combo_speak_num = {
	5,
	10,
	15,
	20,
	25,
	30,
	35,
	40,
	45,
	50
}
SortGameConst.wait_speak_time = 10
SortGameConst.chapter_data = {
	{
		bound = 1,
		item_rate = 1,
		item_count = 29,
		player_own_item_count = 3,
		item_layer_max = 20,
		offset = 1,
		player_list = {
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		grid_weight = {
			60,
			35,
			5
		}
	},
	{
		bound = 2,
		item_rate = 2,
		item_count = 18,
		player_own_item_count = 3,
		item_layer_max = 20,
		offset = 2,
		player_list = {
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		grid_weight = {
			60,
			35,
			5
		}
	},
	{
		bound = 3,
		item_rate = 2,
		item_count = 18,
		player_own_item_count = 3,
		item_layer_max = 20,
		offset = 3,
		player_list = {
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		grid_weight = {
			60,
			35,
			5
		}
	},
	{
		bound = 4,
		item_rate = 2,
		item_count = 18,
		player_own_item_count = 3,
		item_layer_max = 20,
		offset = 4,
		player_list = {
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		grid_weight = {
			60,
			35,
			5
		}
	},
	{
		bound = 5,
		item_rate = 2,
		item_count = 18,
		player_own_item_count = 3,
		item_layer_max = 20,
		offset = 5,
		player_list = {
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		grid_weight = {
			60,
			35,
			5
		}
	},
	{
		bound = 6,
		item_rate = 2,
		item_count = 18,
		player_own_item_count = 3,
		item_layer_max = 20,
		offset = 6,
		player_list = {
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		grid_weight = {
			60,
			35,
			5
		}
	},
	{
		bound = 7,
		item_rate = 2,
		item_count = 18,
		player_own_item_count = 3,
		item_layer_max = 20,
		offset = 7,
		player_list = {
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		grid_weight = {
			60,
			35,
			5
		}
	}
}
SortGameConst.bounds_data = {
	{
		{
			2,
			1,
			1,
			3
		},
		{
			3,
			1,
			1,
			1
		},
		{
			1,
			1,
			2,
			1
		}
	},
	{
		{
			1,
			1,
			1,
			1
		},
		{
			3,
			2,
			1,
			2
		},
		{
			1,
			1,
			1,
			3
		}
	},
	{
		{
			3,
			1,
			1,
			3
		},
		{
			1,
			2,
			1,
			2
		},
		{
			1,
			1,
			1,
			1
		}
	},
	{
		{
			1,
			2,
			1,
			1
		},
		{
			2,
			3,
			3,
			1
		},
		{
			1,
			1,
			1,
			1
		}
	},
	{
		{
			1,
			1,
			1,
			1
		},
		{
			1,
			1,
			2,
			1
		},
		{
			2,
			3,
			3,
			1
		}
	},
	{
		{
			1,
			1,
			1,
			1
		},
		{
			1,
			1,
			1,
			2
		},
		{
			3,
			3,
			2,
			1
		}
	},
	{
		{
			2,
			1,
			1,
			2
		},
		{
			3,
			1,
			1,
			3
		},
		{
			1,
			1,
			1,
			1
		}
	}
}
SortGameConst.grid_offset = {
	{
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		}
	},
	{
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		}
	},
	{
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		}
	},
	{
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		}
	},
	{
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		}
	},
	{
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		}
	},
	{
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		}
	}
}
SortGameConst.player_data = {
	{
		prefab = "gezi_2",
		name = "gezi_2",
		items = {
			1,
			2,
			3
		}
	},
	{
		prefab = "u2501_2",
		name = "u2501_2",
		items = {
			4,
			5,
			6
		}
	},
	{
		prefab = "molici_2",
		name = "molici_2",
		items = {
			7,
			8,
			9
		}
	},
	{
		prefab = "z15_2",
		name = "z15_2",
		items = {
			10,
			11,
			12
		}
	},
	{
		prefab = "z14_2",
		name = "z14_2",
		items = {
			13,
			14,
			15
		}
	},
	{
		prefab = "mojiaduoer_4",
		name = "mojiaduoer_4",
		items = {
			16,
			17,
			18
		}
	},
	{
		prefab = "tiancheng_cv_3",
		name = "tiancheng_cv_3",
		items = {
			19,
			20,
			21
		}
	}
}

return SortGameConst
