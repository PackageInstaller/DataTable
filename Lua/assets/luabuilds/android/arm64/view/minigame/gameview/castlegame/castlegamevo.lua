local var_0_0 = class("CastleGameVo")

var_0_0.game_id = nil
var_0_0.hub_id = nil
var_0_0.total_times = nil
var_0_0.drop = nil
var_0_0.game_bgm = "bar-soft"
var_0_0.game_time = 90
var_0_0.rule_tip = "uscastle2023_minigame_help"
var_0_0.frameRate = Application.targetFrameRate or 60
var_0_0.ui_atlas = "ui/minigameui/castlegameui_atlas"
var_0_0.game_ui = "CastleGameUI"
var_0_0.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
var_0_0.SFX_POINT_DOWN = "event:/ui/break_out_full"
var_0_0.GAME_FAIL = "game fail"
var_0_0.w_count = 6
var_0_0.h_count = 6
var_0_0.stone_broken_time = 1.5
var_0_0.floor_remove_time = 3
var_0_0.floor_revert_time = 3
var_0_0.bubble_ready_time = 0.5
var_0_0.bubble_broken_time = 4
var_0_0.item_ready_time = 2
var_0_0.char_speed = 380
var_0_0.char_speed_min = 30
var_0_0.score_remove_time = 8.5
var_0_0.score_data = {
	{
		score = 200,
		speed = 50,
		time = 5,
		tpl = "chengbao_guangqiu_jin"
	},
	{
		score = 100,
		speed = 25,
		time = 5,
		tpl = "chengbao_guangqiu_zi"
	},
	{
		score = 50,
		speed = 10,
		time = 5,
		tpl = "chengbao_guangqiu_lan"
	}
}
var_0_0.floor_rule = {
	{
		0,
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
		17
	},
	{
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
		35
	},
	{
		7,
		8,
		9,
		10,
		13,
		16,
		19,
		22,
		25,
		26,
		27,
		28
	},
	{
		0,
		1,
		6,
		7,
		4,
		5,
		10,
		11,
		24,
		25,
		30,
		31,
		28,
		29,
		34,
		35
	},
	{
		2,
		3,
		8,
		9,
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
		26,
		27,
		32,
		33
	},
	{
		7,
		8,
		9,
		10,
		13,
		14,
		15,
		16,
		19,
		20,
		21,
		22,
		25,
		26,
		27,
		28
	},
	{
		12,
		13,
		16,
		17,
		18,
		19,
		22,
		23,
		24,
		25,
		28,
		29,
		30,
		31,
		32,
		33,
		34,
		35
	},
	{
		0,
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
		14,
		15,
		20,
		21,
		26,
		27
	},
	{
		3,
		4,
		5,
		9,
		10,
		11,
		15,
		16,
		17,
		18,
		19,
		20,
		24,
		25,
		26,
		30,
		31,
		32
	},
	{
		0,
		1,
		2,
		6,
		7,
		8,
		12,
		13,
		14,
		21,
		22,
		23,
		27,
		28,
		29,
		33,
		34,
		35
	},
	{
		1,
		3,
		5,
		6,
		14,
		15,
		17,
		18,
		20,
		21,
		29,
		30,
		32,
		34
	},
	{
		0,
		5,
		7,
		10,
		14,
		15,
		20,
		21,
		25,
		28,
		30,
		35
	},
	{
		1,
		4,
		6,
		7,
		8,
		9,
		10,
		11,
		13,
		16,
		19,
		22,
		24,
		25,
		26,
		27,
		28,
		29,
		31,
		34
	}
}
var_0_0.round_data = {
	{
		floors = {
			{
				time = 5,
				rule_id = {
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
					13
				}
			},
			{
				time = 13,
				rule_id = {
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
					13
				}
			},
			{
				time = 21,
				rule_id = {
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
					13
				}
			},
			{
				time = 29,
				rule_id = {
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
					13
				}
			},
			{
				time = 37,
				rule_id = {
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
					13
				}
			},
			{
				time = 45,
				rule_id = {
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
					13
				}
			},
			{
				time = 53,
				rule_id = {
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
					13
				}
			},
			{
				time = 61,
				rule_id = {
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
					13
				}
			},
			{
				time = 69,
				rule_id = {
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
					13
				}
			},
			{
				time = 77,
				rule_id = {
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
					13
				}
			},
			{
				time = 85,
				rule_id = {
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
					13
				}
			}
		},
		carriage = {
			34,
			42,
			50,
			58,
			66,
			74,
			82
		},
		stone = {
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		boom = {
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		score_time = {
			{
				num = 18,
				time = 2,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 12,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 20,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 28,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 36,
				score = {
					4,
					6,
					8
				}
			},
			{
				num = 18,
				time = 44,
				score = {
					4,
					6,
					8
				}
			},
			{
				num = 18,
				time = 52,
				score = {
					4,
					6,
					8
				}
			},
			{
				num = 18,
				time = 60,
				score = {
					4,
					6,
					8
				}
			},
			{
				num = 18,
				time = 68,
				score = {
					8,
					10,
					0
				}
			},
			{
				num = 18,
				time = 76,
				score = {
					8,
					10,
					0
				}
			},
			{
				num = 18,
				time = 84,
				score = {
					12,
					0,
					0
				}
			}
		},
		bubble_time = {
			{
				time = 8.5,
				num = 1
			},
			{
				time = 16.5,
				num = 1
			},
			{
				time = 24.5,
				num = 1
			},
			{
				time = 32.5,
				num = 1
			},
			{
				time = 40.5,
				num = 1
			},
			{
				time = 48.5,
				num = 1
			},
			{
				time = 56.5,
				num = 1
			},
			{
				time = 64.5,
				num = 2
			},
			{
				time = 72.5,
				num = 2
			},
			{
				time = 80.5,
				num = 2
			},
			{
				time = 88.5,
				num = 2
			}
		}
	},
	{
		floors = {
			{
				time = 5,
				rule_id = {
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
					13
				}
			},
			{
				time = 13,
				rule_id = {
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
					13
				}
			},
			{
				time = 21,
				rule_id = {
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
					13
				}
			},
			{
				time = 29,
				rule_id = {
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
					13
				}
			},
			{
				time = 37,
				rule_id = {
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
					13
				}
			},
			{
				time = 45,
				rule_id = {
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
					13
				}
			},
			{
				time = 53,
				rule_id = {
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
					13
				}
			},
			{
				time = 61,
				rule_id = {
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
					13
				}
			},
			{
				time = 69,
				rule_id = {
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
					13
				}
			},
			{
				time = 77,
				rule_id = {
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
					13
				}
			},
			{
				time = 85,
				rule_id = {
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
					13
				}
			}
		},
		carriage = {
			100
		},
		stone = {
			{
				time = {
					5.5,
					5.5
				},
				index = {}
			},
			{
				time = {
					13.5,
					13.5
				},
				index = {}
			},
			{
				time = {
					21.5,
					21.5
				},
				index = {}
			},
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		boom = {
			{
				time = {
					5.5,
					5.5
				},
				index = {}
			},
			{
				time = {
					13.5,
					13.5
				},
				index = {}
			},
			{
				time = {
					21.5,
					21.5
				},
				index = {}
			},
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		score_time = {
			{
				num = 18,
				time = 2,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 12,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 20,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 28,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 36,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 44,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 52,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 60,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 68,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 76,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 84,
				score = {
					2,
					4,
					12
				}
			}
		},
		bubble_time = {
			{
				time = 8.5,
				num = 2
			},
			{
				time = 16.5,
				num = 2
			},
			{
				time = 24.5,
				num = 2
			},
			{
				time = 32.5,
				num = 2
			},
			{
				time = 40.5,
				num = 2
			},
			{
				time = 48.5,
				num = 2
			},
			{
				time = 56.5,
				num = 2
			},
			{
				time = 64.5,
				num = 2
			},
			{
				time = 72.5,
				num = 2
			},
			{
				time = 80.5,
				num = 2
			},
			{
				time = 88.5,
				num = 2
			}
		}
	},
	{
		floors = {
			{
				time = 5,
				rule_id = {
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
					13
				}
			},
			{
				time = 13,
				rule_id = {
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
					13
				}
			},
			{
				time = 21,
				rule_id = {
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
					13
				}
			},
			{
				time = 29,
				rule_id = {
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
					13
				}
			},
			{
				time = 37,
				rule_id = {
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
					13
				}
			},
			{
				time = 45,
				rule_id = {
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
					13
				}
			},
			{
				time = 53,
				rule_id = {
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
					13
				}
			},
			{
				time = 61,
				rule_id = {
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
					13
				}
			},
			{
				time = 69,
				rule_id = {
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
					13
				}
			},
			{
				time = 77,
				rule_id = {
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
					13
				}
			},
			{
				time = 85,
				rule_id = {
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
					13
				}
			}
		},
		carriage = {
			100
		},
		stone = {
			{
				time = {
					5.5,
					5.5
				},
				index = {}
			},
			{
				time = {
					13.5,
					13.5
				},
				index = {}
			},
			{
				time = {
					21.5,
					21.5
				},
				index = {}
			},
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		boom = {
			{
				time = {
					5.5,
					5.5
				},
				index = {}
			},
			{
				time = {
					13.5,
					13.5
				},
				index = {}
			},
			{
				time = {
					21.5,
					21.5
				},
				index = {}
			},
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		score_time = {
			{
				num = 18,
				time = 2,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 12,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 20,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 28,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 36,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 44,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 52,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 60,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 68,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 76,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 84,
				score = {
					2,
					4,
					12
				}
			}
		},
		bubble_time = {
			{
				time = 8.5,
				num = 2
			},
			{
				time = 16.5,
				num = 2
			},
			{
				time = 24.5,
				num = 2
			},
			{
				time = 32.5,
				num = 2
			},
			{
				time = 40.5,
				num = 2
			},
			{
				time = 48.5,
				num = 2
			},
			{
				time = 56.5,
				num = 2
			},
			{
				time = 64.5,
				num = 2
			},
			{
				time = 72.5,
				num = 2
			},
			{
				time = 80.5,
				num = 2
			},
			{
				time = 88.5,
				num = 2
			}
		}
	},
	{
		floors = {
			{
				time = 5,
				rule_id = {
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
					13
				}
			},
			{
				time = 13,
				rule_id = {
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
					13
				}
			},
			{
				time = 21,
				rule_id = {
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
					13
				}
			},
			{
				time = 29,
				rule_id = {
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
					13
				}
			},
			{
				time = 37,
				rule_id = {
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
					13
				}
			},
			{
				time = 45,
				rule_id = {
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
					13
				}
			},
			{
				time = 53,
				rule_id = {
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
					13
				}
			},
			{
				time = 61,
				rule_id = {
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
					13
				}
			},
			{
				time = 69,
				rule_id = {
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
					13
				}
			},
			{
				time = 77,
				rule_id = {
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
					13
				}
			},
			{
				time = 85,
				rule_id = {
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
					13
				}
			}
		},
		carriage = {
			100
		},
		stone = {
			{
				time = {
					5.5,
					5.5
				},
				index = {}
			},
			{
				time = {
					13.5,
					13.5
				},
				index = {}
			},
			{
				time = {
					21.5,
					21.5
				},
				index = {}
			},
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		boom = {
			{
				time = {
					5.5,
					5.5
				},
				index = {}
			},
			{
				time = {
					13.5,
					13.5
				},
				index = {}
			},
			{
				time = {
					21.5,
					21.5
				},
				index = {}
			},
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		score_time = {
			{
				num = 18,
				time = 2,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 12,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 20,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 28,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 36,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 44,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 52,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 60,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 68,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 76,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 84,
				score = {
					2,
					4,
					12
				}
			}
		},
		bubble_time = {
			{
				time = 8.5,
				num = 2
			},
			{
				time = 16.5,
				num = 2
			},
			{
				time = 24.5,
				num = 2
			},
			{
				time = 32.5,
				num = 2
			},
			{
				time = 40.5,
				num = 2
			},
			{
				time = 48.5,
				num = 2
			},
			{
				time = 56.5,
				num = 2
			},
			{
				time = 64.5,
				num = 2
			},
			{
				time = 72.5,
				num = 2
			},
			{
				time = 80.5,
				num = 2
			},
			{
				time = 88.5,
				num = 2
			}
		}
	},
	{
		floors = {
			{
				time = 5,
				rule_id = {
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
					13
				}
			},
			{
				time = 13,
				rule_id = {
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
					13
				}
			},
			{
				time = 21,
				rule_id = {
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
					13
				}
			},
			{
				time = 29,
				rule_id = {
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
					13
				}
			},
			{
				time = 37,
				rule_id = {
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
					13
				}
			},
			{
				time = 45,
				rule_id = {
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
					13
				}
			},
			{
				time = 53,
				rule_id = {
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
					13
				}
			},
			{
				time = 61,
				rule_id = {
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
					13
				}
			},
			{
				time = 69,
				rule_id = {
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
					13
				}
			},
			{
				time = 77,
				rule_id = {
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
					13
				}
			},
			{
				time = 85,
				rule_id = {
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
					13
				}
			}
		},
		carriage = {
			100
		},
		stone = {
			{
				time = {
					5.5,
					5.5
				},
				index = {}
			},
			{
				time = {
					13.5,
					13.5
				},
				index = {}
			},
			{
				time = {
					21.5,
					21.5
				},
				index = {}
			},
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		boom = {
			{
				time = {
					5.5,
					5.5
				},
				index = {}
			},
			{
				time = {
					13.5,
					13.5
				},
				index = {}
			},
			{
				time = {
					21.5,
					21.5
				},
				index = {}
			},
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		score_time = {
			{
				num = 18,
				time = 2,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 12,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 20,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 28,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 36,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 44,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 52,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 60,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 68,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 76,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 84,
				score = {
					2,
					4,
					12
				}
			}
		},
		bubble_time = {
			{
				time = 8.5,
				num = 2
			},
			{
				time = 16.5,
				num = 2
			},
			{
				time = 24.5,
				num = 2
			},
			{
				time = 32.5,
				num = 2
			},
			{
				time = 40.5,
				num = 2
			},
			{
				time = 48.5,
				num = 2
			},
			{
				time = 56.5,
				num = 2
			},
			{
				time = 64.5,
				num = 2
			},
			{
				time = 72.5,
				num = 2
			},
			{
				time = 80.5,
				num = 2
			},
			{
				time = 88.5,
				num = 2
			}
		}
	},
	{
		floors = {
			{
				time = 5,
				rule_id = {
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
					13
				}
			},
			{
				time = 13,
				rule_id = {
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
					13
				}
			},
			{
				time = 21,
				rule_id = {
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
					13
				}
			},
			{
				time = 29,
				rule_id = {
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
					13
				}
			},
			{
				time = 37,
				rule_id = {
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
					13
				}
			},
			{
				time = 45,
				rule_id = {
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
					13
				}
			},
			{
				time = 53,
				rule_id = {
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
					13
				}
			},
			{
				time = 61,
				rule_id = {
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
					13
				}
			},
			{
				time = 69,
				rule_id = {
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
					13
				}
			},
			{
				time = 77,
				rule_id = {
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
					13
				}
			},
			{
				time = 85,
				rule_id = {
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
					13
				}
			}
		},
		carriage = {
			100
		},
		stone = {
			{
				time = {
					5.5,
					5.5
				},
				index = {}
			},
			{
				time = {
					13.5,
					13.5
				},
				index = {}
			},
			{
				time = {
					21.5,
					21.5
				},
				index = {}
			},
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		boom = {
			{
				time = {
					5.5,
					5.5
				},
				index = {}
			},
			{
				time = {
					13.5,
					13.5
				},
				index = {}
			},
			{
				time = {
					21.5,
					21.5
				},
				index = {}
			},
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		score_time = {
			{
				num = 18,
				time = 2,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 12,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 20,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 28,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 36,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 44,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 52,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 60,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 68,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 76,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 84,
				score = {
					2,
					4,
					12
				}
			}
		},
		bubble_time = {
			{
				time = 8.5,
				num = 2
			},
			{
				time = 16.5,
				num = 2
			},
			{
				time = 24.5,
				num = 2
			},
			{
				time = 32.5,
				num = 2
			},
			{
				time = 40.5,
				num = 2
			},
			{
				time = 48.5,
				num = 2
			},
			{
				time = 56.5,
				num = 2
			},
			{
				time = 64.5,
				num = 2
			},
			{
				time = 72.5,
				num = 2
			},
			{
				time = 80.5,
				num = 2
			},
			{
				time = 88.5,
				num = 2
			}
		}
	},
	{
		floors = {
			{
				time = 5,
				rule_id = {
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
					13
				}
			},
			{
				time = 13,
				rule_id = {
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
					13
				}
			},
			{
				time = 21,
				rule_id = {
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
					13
				}
			},
			{
				time = 29,
				rule_id = {
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
					13
				}
			},
			{
				time = 37,
				rule_id = {
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
					13
				}
			},
			{
				time = 45,
				rule_id = {
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
					13
				}
			},
			{
				time = 53,
				rule_id = {
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
					13
				}
			},
			{
				time = 61,
				rule_id = {
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
					13
				}
			},
			{
				time = 69,
				rule_id = {
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
					13
				}
			},
			{
				time = 77,
				rule_id = {
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
					13
				}
			},
			{
				time = 85,
				rule_id = {
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
					13
				}
			}
		},
		carriage = {
			100
		},
		stone = {
			{
				time = {
					5.5,
					5.5
				},
				index = {}
			},
			{
				time = {
					13.5,
					13.5
				},
				index = {}
			},
			{
				time = {
					21.5,
					21.5
				},
				index = {}
			},
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		boom = {
			{
				time = {
					5.5,
					5.5
				},
				index = {}
			},
			{
				time = {
					13.5,
					13.5
				},
				index = {}
			},
			{
				time = {
					21.5,
					21.5
				},
				index = {}
			},
			{
				time = {
					29.5,
					29.5
				},
				index = {}
			},
			{
				time = {
					37.5,
					37.5
				},
				index = {}
			},
			{
				time = {
					45.5,
					45.5
				},
				index = {}
			},
			{
				time = {
					53.5,
					53.5
				},
				index = {}
			},
			{
				time = {
					61.5,
					61.5
				},
				index = {}
			},
			{
				time = {
					69.5,
					69.5
				},
				index = {}
			},
			{
				time = {
					77.5,
					77.5
				},
				index = {}
			},
			{
				time = {
					85.5,
					85.5
				},
				index = {}
			}
		},
		score_time = {
			{
				num = 18,
				time = 2,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 12,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 20,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 28,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 36,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 44,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 52,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 60,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 68,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 76,
				score = {
					2,
					4,
					12
				}
			},
			{
				num = 18,
				time = 84,
				score = {
					2,
					4,
					12
				}
			}
		},
		bubble_time = {
			{
				time = 8.5,
				num = 2
			},
			{
				time = 16.5,
				num = 2
			},
			{
				time = 24.5,
				num = 2
			},
			{
				time = 32.5,
				num = 2
			},
			{
				time = 40.5,
				num = 2
			},
			{
				time = 48.5,
				num = 2
			},
			{
				time = 56.5,
				num = 2
			},
			{
				time = 64.5,
				num = 2
			},
			{
				time = 72.5,
				num = 2
			},
			{
				time = 80.5,
				num = 2
			},
			{
				time = 88.5,
				num = 2
			}
		}
	}
}
var_0_0.round_rule = {
	{
		1
	},
	{
		1
	},
	{
		1
	},
	{
		1
	},
	{
		1
	},
	{
		1
	},
	{
		1
	}
}

function var_0_0.Init(arg_1_0, arg_1_1)
	var_0_0.game_id = arg_1_0
	var_0_0.hub_id = arg_1_1
	var_0_0.total_times = pg.mini_game_hub[var_0_0.hub_id]
	var_0_0.drop = pg.mini_game[var_0_0.game_id].simple_config_data.drop_ids
	var_0_0.total_times = pg.mini_game_hub[var_0_0.hub_id].reward_need

	return
end

function var_0_0.Prepare()
	var_0_0.gameTime = var_0_0.game_time
	var_0_0.gameStepTime = 0
	var_0_0.scoreNum = 0

	local var_2_0 = var_0_0.round_rule[var_0_0.GetGameRound()]

	var_0_0.roundData = Clone(CastleGameVo.round_data[var_2_0[math.random(1, #var_2_0)]])

	return
end

function var_0_0.GetGameTimes()
	return var_0_0.GetMiniGameHubData().count
end

function var_0_0.GetGameUseTimes()
	return var_0_0.GetMiniGameHubData().usedtime or 0
end

function var_0_0.GetGameRound()
	local var_5_0 = var_0_0.GetGameUseTimes()
	local var_5_1 = var_0_0.GetGameTimes()

	if var_5_1 and var_5_1 > 0 then
		return var_5_0 + 1
	else
		return var_5_0
	end

	return
end

function var_0_0.GetMiniGameData()
	return getProxy(MiniGameProxy):GetMiniGameData(var_0_0.game_id)
end

function var_0_0.GetMiniGameHubData()
	return getProxy(MiniGameProxy):GetHubByHubId(var_0_0.hub_id)
end

function var_0_0.LoadSkeletonData(arg_8_0, arg_8_1)
	LoadAnyAsync(var_0_0.ui_atlas, arg_8_0, typeof(Object), function(arg_9_0)
		if arg_9_0 then
			arg_8_1((SpineAnimUI.AnimChar(arg_8_0, arg_9_0)))
		end

		return
	end)

	return
end

function var_0_0.getBeachMap(arg_10_0)
	return GetSpriteFromAtlas(BeachGuardAsset.map_asset_path, arg_10_0)
end

function var_0_0.getFloorImage(arg_11_0)
	return GetSpriteFromAtlas(CastleGameVo.ui_atlas, arg_11_0)
end

function var_0_0.Sign(arg_12_0, arg_12_1, arg_12_2)
	return (arg_12_0.x - arg_12_2.x) * (arg_12_1.y - arg_12_2.y) - (arg_12_1.x - arg_12_2.x) * (arg_12_0.y - arg_12_2.y)
end

function var_0_0.PointInTriangle(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_2 = var_0_0.Sign(arg_13_0, arg_13_2, arg_13_3)
	local var_13_3 = var_0_0.Sign(arg_13_0, arg_13_3, arg_13_1)
	local var_13_4 = var_0_0.Sign(arg_13_0, arg_13_1, arg_13_2) > 0 or nil > 0 or nil > 0

	return not (nil < 0 or nil < 0 or nil < 0) or not nil
end

function var_0_0.PointLeftLine(arg_14_0, arg_14_1, arg_14_2)
	return (arg_14_2.x - arg_14_1.x) * (arg_14_0.y - arg_14_1.y) - (arg_14_2.y - arg_14_1.y) * (arg_14_0.x - arg_14_1.x) > 0
end

local var_0_1 = 157
local var_0_2 = 123
local var_0_3 = 91
local var_0_4 = 2
local var_0_5 = -0.48
local var_0_6 = Vector2(-671, -95)

function var_0_0.GetRotationPos(arg_15_0)
	local var_15_0 = math.cos(var_0_5)
	local var_15_1 = math.sin(var_0_5)
	local var_15_2 = math.floor(arg_15_0 / CastleGameVo.h_count)

	return Vector2(var_15_0 * (var_0_1 * (arg_15_0 % CastleGameVo.w_count) + var_0_3 * var_15_2) - var_15_1 * (var_0_2 * var_15_2 + var_0_4 * (arg_15_0 % CastleGameVo.w_count)) + var_0_6.x, var_15_0 * (var_0_2 * var_15_2 + var_0_4 * (arg_15_0 % CastleGameVo.w_count)) + var_15_1 * (var_0_1 * (arg_15_0 % CastleGameVo.w_count) + var_0_3 * var_15_2) + var_0_6.y)
end

function var_0_0.GetRotationPosByWH(arg_16_0, arg_16_1)
	local var_16_0 = math.cos(var_0_5)
	local var_16_1 = math.sin(var_0_5)

	return Vector2(var_16_0 * (var_0_1 * arg_16_0 + var_0_3 * arg_16_1) - var_16_1 * (var_0_2 * arg_16_1 + var_0_4 * arg_16_0) + var_0_6.x, var_16_0 * (var_0_2 * arg_16_1 + var_0_4 * arg_16_0) + var_16_1 * (var_0_1 * arg_16_0 + var_0_3 * arg_16_1) + var_0_6.y)
end

function var_0_0.PointFootLine(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = -((arg_17_1.x - arg_17_0.x) * (arg_17_2.x - arg_17_1.x) + (arg_17_1.y - arg_17_0.y) * (arg_17_2.y - arg_17_1.y)) / ((arg_17_1.x - arg_17_2.x) * (arg_17_1.x - arg_17_2.x) + (arg_17_1.y - arg_17_2.y) * (arg_17_1.y - arg_17_2.y)) * (arg_17_2.x - arg_17_1.x) + arg_17_1.x
	local var_17_1 = -((arg_17_1.x - arg_17_0.x) * (arg_17_2.x - arg_17_1.x) + (arg_17_1.y - arg_17_0.y) * (arg_17_2.y - arg_17_1.y)) / ((arg_17_1.x - arg_17_2.x) * (arg_17_1.x - arg_17_2.x) + (arg_17_1.y - arg_17_2.y) * (arg_17_1.y - arg_17_2.y)) * (arg_17_2.y - arg_17_1.y) + arg_17_1.y
	local var_17_2 = true

	if -((arg_17_1.x - arg_17_0.x) * (arg_17_2.x - arg_17_1.x) + (arg_17_1.y - arg_17_0.y) * (arg_17_2.y - arg_17_1.y)) / ((arg_17_1.x - arg_17_2.x) * (arg_17_1.x - arg_17_2.x) + (arg_17_1.y - arg_17_2.y) * (arg_17_1.y - arg_17_2.y)) < 0 or -((arg_17_1.x - arg_17_0.x) * (arg_17_2.x - arg_17_1.x) + (arg_17_1.y - arg_17_0.y) * (arg_17_2.y - arg_17_1.y)) / ((arg_17_1.x - arg_17_2.x) * (arg_17_1.x - arg_17_2.x) + (arg_17_1.y - arg_17_2.y) * (arg_17_1.y - arg_17_2.y)) > 1 then
		var_17_2 = false
	end

	return Vector2(var_17_0, var_17_1), var_17_2
end

var_0_0.gameTime = 0
var_0_0.gameStepTime = 0
var_0_0.deltaTime = 0
var_0_0.scoreNum = 0
var_0_0.joyStickData = nil
var_0_0.roundData = nil

return var_0_0
