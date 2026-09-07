local CastleGameVo = class("CastleGameVo")

CastleGameVo.game_id = nil
CastleGameVo.hub_id = nil
CastleGameVo.total_times = nil
CastleGameVo.drop = nil
CastleGameVo.game_bgm = "bar-soft"
CastleGameVo.game_time = 90
CastleGameVo.rule_tip = "uscastle2023_minigame_help"
CastleGameVo.frameRate = Application.targetFrameRate or 60
CastleGameVo.ui_atlas = "ui/minigameui/castlegameui_atlas"
CastleGameVo.game_ui = "CastleGameUI"
CastleGameVo.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
CastleGameVo.SFX_POINT_DOWN = "event:/ui/break_out_full"
CastleGameVo.GAME_FAIL = "game fail"
CastleGameVo.w_count = 6
CastleGameVo.h_count = 6
CastleGameVo.stone_broken_time = 1.5
CastleGameVo.floor_remove_time = 3
CastleGameVo.floor_revert_time = 3
CastleGameVo.bubble_ready_time = 0.5
CastleGameVo.bubble_broken_time = 4
CastleGameVo.item_ready_time = 2
CastleGameVo.char_speed = 380
CastleGameVo.char_speed_min = 30
CastleGameVo.score_remove_time = 8.5
CastleGameVo.score_data = {
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
CastleGameVo.floor_rule = {
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
CastleGameVo.round_data = {
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
CastleGameVo.round_rule = {
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

function CastleGameVo:Init(arg_1_1)
	CastleGameVo.game_id = self
	CastleGameVo.hub_id = arg_1_1
	CastleGameVo.total_times = pg.mini_game_hub[CastleGameVo.hub_id]
	CastleGameVo.drop = pg.mini_game[CastleGameVo.game_id].simple_config_data.drop_ids
	CastleGameVo.total_times = pg.mini_game_hub[CastleGameVo.hub_id].reward_need

	return
end

function CastleGameVo.Prepare()
	CastleGameVo.gameTime = CastleGameVo.game_time
	CastleGameVo.gameStepTime = 0
	CastleGameVo.scoreNum = 0

	local var_2_0 = CastleGameVo.round_rule[CastleGameVo.GetGameRound()]

	CastleGameVo.roundData = Clone(CastleGameVo.round_data[var_2_0[math.random(1, #var_2_0)]])

	return
end

function CastleGameVo.GetGameTimes()
	return CastleGameVo.GetMiniGameHubData().count
end

function CastleGameVo.GetGameUseTimes()
	return CastleGameVo.GetMiniGameHubData().usedtime or 0
end

function CastleGameVo.GetGameRound()
	local var_5_0 = CastleGameVo.GetGameUseTimes()
	local var_5_1 = CastleGameVo.GetGameTimes()

	if var_5_1 and var_5_1 > 0 then
		return var_5_0 + 1
	else
		return var_5_0
	end

	return
end

function CastleGameVo.GetMiniGameData()
	return getProxy(MiniGameProxy):GetMiniGameData(CastleGameVo.game_id)
end

function CastleGameVo.GetMiniGameHubData()
	return getProxy(MiniGameProxy):GetHubByHubId(CastleGameVo.hub_id)
end

function CastleGameVo:LoadSkeletonData(arg_8_1)
	LoadAnyAsync(CastleGameVo.ui_atlas, self, typeof(Object), function(arg_9_0)
		if arg_9_0 then
			arg_8_1((SpineAnimUI.AnimChar(self, arg_9_0)))
		end

		return
	end)

	return
end

function CastleGameVo:getBeachMap()
	return GetSpriteFromAtlas(BeachGuardAsset.map_asset_path, self)
end

function CastleGameVo:getFloorImage()
	return GetSpriteFromAtlas(CastleGameVo.ui_atlas, self)
end

function CastleGameVo:Sign(arg_12_1, arg_12_2)
	return (self.x - arg_12_2.x) * (arg_12_1.y - arg_12_2.y) - (arg_12_1.x - arg_12_2.x) * (self.y - arg_12_2.y)
end

function CastleGameVo:PointInTriangle(arg_13_1, arg_13_2, arg_13_3)
	local var_13_2 = CastleGameVo.Sign(self, arg_13_2, arg_13_3)
	local var_13_3 = CastleGameVo.Sign(self, arg_13_3, arg_13_1)
	local var_13_4 = CastleGameVo.Sign(self, arg_13_1, arg_13_2) > 0 or nil > 0 or nil > 0

	return not (nil < 0 or nil < 0 or nil < 0) or not nil
end

function CastleGameVo:PointLeftLine(arg_14_1, arg_14_2)
	return (arg_14_2.x - arg_14_1.x) * (self.y - arg_14_1.y) - (arg_14_2.y - arg_14_1.y) * (self.x - arg_14_1.x) > 0
end

local var_0_1 = 157
local var_0_2 = 123
local var_0_3 = 91
local var_0_4 = 2
local var_0_5 = -0.48
local var_0_6 = Vector2(-671, -95)

function CastleGameVo:GetRotationPos()
	local var_15_0 = math.cos(var_0_5)
	local var_15_1 = math.sin(var_0_5)
	local var_15_2 = math.floor(self / CastleGameVo.h_count)

	return Vector2(var_15_0 * (var_0_1 * (self % CastleGameVo.w_count) + var_0_3 * var_15_2) - var_15_1 * (var_0_2 * var_15_2 + var_0_4 * (self % CastleGameVo.w_count)) + var_0_6.x, var_15_0 * (var_0_2 * var_15_2 + var_0_4 * (self % CastleGameVo.w_count)) + var_15_1 * (var_0_1 * (self % CastleGameVo.w_count) + var_0_3 * var_15_2) + var_0_6.y)
end

function CastleGameVo:GetRotationPosByWH(arg_16_1)
	local var_16_0 = math.cos(var_0_5)
	local var_16_1 = math.sin(var_0_5)

	return Vector2(var_16_0 * (var_0_1 * self + var_0_3 * arg_16_1) - var_16_1 * (var_0_2 * arg_16_1 + var_0_4 * self) + var_0_6.x, var_16_0 * (var_0_2 * arg_16_1 + var_0_4 * self) + var_16_1 * (var_0_1 * self + var_0_3 * arg_16_1) + var_0_6.y)
end

function CastleGameVo:PointFootLine(arg_17_1, arg_17_2)
	local var_17_0 = -((arg_17_1.x - self.x) * (arg_17_2.x - arg_17_1.x) + (arg_17_1.y - self.y) * (arg_17_2.y - arg_17_1.y)) / ((arg_17_1.x - arg_17_2.x) * (arg_17_1.x - arg_17_2.x) + (arg_17_1.y - arg_17_2.y) * (arg_17_1.y - arg_17_2.y))

	return Vector2(var_17_0 * (arg_17_2.x - arg_17_1.x) + arg_17_1.x, var_17_0 * (arg_17_2.y - arg_17_1.y) + arg_17_1.y), not (var_17_0 < 0 or var_17_0 > 1)
end

CastleGameVo.gameTime = 0
CastleGameVo.gameStepTime = 0
CastleGameVo.deltaTime = 0
CastleGameVo.scoreNum = 0
CastleGameVo.joyStickData = nil
CastleGameVo.roundData = nil

return CastleGameVo
