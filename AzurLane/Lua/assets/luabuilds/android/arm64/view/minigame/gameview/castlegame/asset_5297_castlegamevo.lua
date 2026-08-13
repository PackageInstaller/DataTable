class = var_0_10000

local var_0_0 = var_0_10000("CastleGameVo")

var_0_0.game_id = nil
var_0_0.hub_id = nil
var_0_0.total_times = nil
var_0_0.drop = nil
var_0_0.game_bgm = "bar-soft"
var_0_0.game_time = 90
var_0_0.rule_tip = "uscastle2023_minigame_help"
Application = var_1

local var_0_1

if not var_1.targetFrameRate then
	var_0_1 = 60
end

var_0_0.frameRate = var_0_1
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

	local var_1_0 = var_0_0

	pg = var_1_10003
	var_1_0.total_times = var_1_10003.mini_game_hub[var_0_0.hub_id]

	local var_1_1 = var_0_0

	pg = var_3
	var_1_1.drop = var_3.mini_game[var_0_0.game_id].simple_config_data.drop_ids

	local var_1_2 = var_0_0

	pg = var_3
	var_1_2.total_times = var_3.mini_game_hub[var_0_0.hub_id].reward_need

	return
end

function var_0_0.Prepare()
	var_0_0.gameTime = var_0_0.game_time
	var_0_0.gameStepTime = 0
	var_0_0.scoreNum = 0

	local var_2_0 = var_0_0.round_rule[var_0_0.GetGameRound()]
	local var_2_1 = var_0_0

	Clone = var_1_10002
	CastleGameVo = var_1_10004

	local var_2_2 = var_1_10004.round_data

	math = var_1_10005
	var_2_1.roundData = var_1_10002(var_2_2[var_2_0[var_1_10005.random(1, #var_2_0)]])

	return
end

function var_0_0.GetGameTimes()
	return var_0_0.GetMiniGameHubData().count
end

function var_0_0.GetGameUseTimes()
	local var_4_0

	if not var_0_0.GetMiniGameHubData().usedtime then
		var_4_0 = 0
	end

	return var_4_0
end

function var_0_0.GetGameRound()
	local var_5_0 = var_0_0.GetGameUseTimes()

	if var_0_0.GetGameTimes() and var_1 > 0 then
		return var_5_0 + 1
	else
		return var_5_0
	end

	return
end

function var_0_0.GetMiniGameData()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10002

	local var_6_0 = var_1_10000(var_1_10002)

	return var_0.GetMiniGameData(var_6_0, var_0_0.game_id)
end

function var_0_0.GetMiniGameHubData()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10002

	local var_7_0 = var_1_10000(var_1_10002)

	return var_0.GetHubByHubId(var_7_0, var_0_0.hub_id)
end

function var_0_0.LoadSkeletonData(arg_8_0, arg_8_1)
	LoadAnyAsync = var_1_10002

	local var_8_0 = var_0_0.ui_atlas
	local var_8_1 = arg_8_0

	typeof = var_1_10006
	Object = var_1_10008

	var_1_10002(var_8_0, var_8_1, var_1_10006(var_1_10008), function(arg_9_0)
		if arg_9_0 then
			SpineAnimUI = var_2_10001

			local var_9_0 = var_2_10001.AnimChar(arg_8_0, arg_9_0)

			arg_8_1(var_9_0)
		end

		return
	end)

	return
end

function var_0_0.getBeachMap(arg_10_0)
	GetSpriteFromAtlas = var_1_10001
	BeachGuardAsset = var_1_10003

	return var_1_10001(var_1_10003.map_asset_path, arg_10_0)
end

function var_0_0.getFloorImage(arg_11_0)
	GetSpriteFromAtlas = var_1_10001
	CastleGameVo = var_1_10003

	return var_1_10001(var_1_10003.ui_atlas, arg_11_0)
end

function var_0_0.Sign(arg_12_0, arg_12_1, arg_12_2)
	return (arg_12_0.x - arg_12_2.x) * (arg_12_1.y - arg_12_2.y) - (arg_12_1.x - arg_12_2.x) * (arg_12_0.y - arg_12_2.y)
end

function var_0_0.PointInTriangle(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0
	local var_13_1
	local var_13_2
	local var_13_3
	local var_13_4
	local var_13_5 = var_0_0.Sign(arg_13_0, arg_13_1, arg_13_2)
	local var_13_6 = var_0_0.Sign(arg_13_0, arg_13_2, arg_13_3)
	local var_13_7 = var_0_0.Sign(arg_13_0, arg_13_3, arg_13_1)
	local var_13_8 = var_13_5 < 0 or var_13_6 < 0 or var_13_7 < 0
	local var_13_9 = var_13_5 > 0 or var_13_6 > 0 or var_13_7 > 0

	return not var_13_8 or not var_13_9
end

function var_0_0.PointLeftLine(arg_14_0, arg_14_1, arg_14_2)
	return (arg_14_2.x - arg_14_1.x) * (arg_14_0.y - arg_14_1.y) - (arg_14_2.y - arg_14_1.y) * (arg_14_0.x - arg_14_1.x) > 0
end

local var_0_2 = 157
local var_0_3 = 123
local var_0_4 = 91
local var_0_5 = 2
local var_0_6 = -0.48

Vector2 = var_0_10006

local var_0_7 = var_0_10006(-671, -95)

function var_0_0.GetRotationPos(arg_15_0)
	math = var_1_10001

	local var_15_0 = var_1_10001.cos(var_0_6)

	math = var_1_10002

	local var_15_1 = var_1_10002.sin(var_0_6)

	CastleGameVo = var_3

	local var_15_2 = arg_15_0 % var_3.w_count

	math = var_4

	local var_15_3 = var_4.floor

	CastleGameVo = var_1_10006

	local var_15_4 = var_15_3(arg_15_0 / var_1_10006.h_count)
	local var_15_5 = var_0_2 * var_15_2 + var_0_4 * var_15_4
	local var_15_6 = var_0_3 * var_15_4 + var_0_5 * var_15_2
	local var_15_7 = var_15_0 * var_15_5 - var_15_1 * var_15_6 + var_0_7.x
	local var_15_8 = var_15_0 * var_15_6 + var_15_1 * var_15_5 + var_0_7.y

	Vector2 = var_9

	return var_9(var_15_7, var_15_8)
end

function var_0_0.GetRotationPosByWH(arg_16_0, arg_16_1)
	math = var_1_10002

	local var_16_0 = var_1_10002.cos(var_0_6)

	math = var_1_10003

	local var_16_1 = var_1_10003.sin(var_0_6)
	local var_16_2 = var_0_2 * arg_16_0 + var_0_4 * arg_16_1
	local var_16_3 = var_0_3 * arg_16_1 + var_0_5 * arg_16_0
	local var_16_4 = var_16_0 * var_16_2 - var_16_1 * var_16_3 + var_0_7.x
	local var_16_5 = var_16_0 * var_16_3 + var_16_1 * var_16_2 + var_0_7.y

	Vector2 = var_8

	return var_8(var_16_4, var_16_5)
end

function var_0_0.PointFootLine(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.x
	local var_17_1 = arg_17_0.y
	local var_17_2 = arg_17_1.x
	local var_17_3 = arg_17_1.y
	local var_17_4 = arg_17_2.x
	local var_17_5 = arg_17_2.y
	local var_17_6 = -((var_17_2 - var_17_0) * (var_17_4 - var_17_2) + (var_17_3 - var_17_1) * (var_17_5 - var_17_3)) / ((var_17_2 - var_17_4) * (var_17_2 - var_17_4) + (var_17_3 - var_17_5) * (var_17_3 - var_17_5)) * (var_17_4 - var_17_2) + var_17_2
	local var_17_7 = var_9 * (var_17_5 - var_17_3) + var_17_3
	local var_17_8 = true

	if var_9 < 0 or 1 < var_9 then
		var_17_8 = false
	end

	Vector2 = var_13

	return var_13(var_17_6, var_17_7), var_17_8
end

var_0_0.gameTime = 0
var_0_0.gameStepTime = 0
var_0_0.deltaTime = 0
var_0_0.scoreNum = 0
var_0_0.joyStickData = nil
var_0_0.roundData = nil

return var_0_0
