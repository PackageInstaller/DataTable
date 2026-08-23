return {
	GUIDE_SERVER_CLOSE_ID = 999999,
	COMMON_GUIDE_PAGE_SHOW_TYPE = {
		VIDEO = 2,
		PIC = 1
	},
	TICK_CONST = {
		BATTLE_FAIL = 5,
		DUNGEON_STAGE = 4,
		MODULE_OPEN = 3,
		LEVEL = 2,
		CREATE = 1,
		ENUM_TICK = 6
	},
	GUIDE_TYPE = {
		WEAK = 2,
		STRONG = 1,
		TICK = 3
	},
	ENUM_TICK = {
		RICH_MAN_MONSTER = 19,
		GENE_TICK_GUIDE_FORCE = 18,
		GVE_RESEARCH_GUIDE = 17,
		PRE_FORMATION_MODULE_OPEN = 16,
		GVE_IS_IN_FORMAL_FIRST_ENTER_STAGE = 15,
		GVE_IS_IN_FORMAL_STAGE = 14,
		GVE_IS_IN_SIGN_UP_STAGE = 13,
		GVE_FIRST_ENTER_GRID_DETAIL = 12,
		GVE_FIRST_ENTER_HALIDOM = 11,
		FOG_FIRST_ENTER_SELECT_KEEP = 10,
		FOG_FIRST_ENTER_TALENT = 9,
		FOG_FIRST_ENTER_IDLE = 8,
		FOG_FIRST_SELECT_SECOND_MONSTER = 7,
		GUIDE_WAR_FIGHT = 6,
		GUIDE_WAR_DEVELOP = 5,
		HOME_SHOWER_GUIDE_TICKED = 4,
		HOME_GUIDE_TICKED = 3,
		PREDESTINATION_TICKED = 2,
		FIRST_LINEUP_SSR = 1,
		DOMAIN_GUIDE = 33,
		OUTPOST_TASK_1017 = 32,
		OUTPOST_TASK_1015 = 31,
		OUTPOST_WEAK_TICK_GUIDE = 30,
		HANDBOOK_GUIDE = 29,
		WARR_GUIDE_TIP = 28,
		OUTPOST_TASK_1013 = 27,
		OUTPOST_TASK_1009 = 26,
		OUTPOST_TASK_1005 = 25,
		OUTPOST_TASK_1004 = 24,
		Dungeon_AUTO_GUIDE = 23,
		WUSH_AUTO_GUIDE = 22,
		NEW_SLG_STEP_GUIDE = 21,
		RICH_MAN_STEAL = 20
	},
	OUTPOST_TASKS = {
		[1015] = "OUTPOST_TASK_1015",
		[1009] = "OUTPOST_TASK_1009",
		[1005] = "OUTPOST_TASK_1005",
		[1004] = "OUTPOST_TASK_1004",
		[1017] = "OUTPOST_TASK_1017",
		[1013] = "OUTPOST_TASK_1013"
	},
	GUIDE_EVENT = {
		"EVENT_GUIDE_PLAY_TEST_BATTLE",
		"EVENT_GUIDE_SHOW_ALL_UNITE_TOKEN",
		"EVENT_GUIDE_ENTER_DUNGEON_CHAPTER_1",
		"EVENT_GUIDE_ENTER_DUNGEON_BATTLE",
		"EVENT_GUIDE_LINEUP_UNITE_TOKEN_1",
		"EVENT_GUIDE_PLAYER_GET_UNITE_TOKEN_1",
		nil,
		"EVENT_GUIDE_PLAYER_GET_KNIGHT",
		"EVENT_GUIDE_LINEUP_UNITE_TOKEN_2",
		"EVENT_GUIDE_PLAYER_GET_UNITE_TOKEN_2",
		"EVENT_GUIDE_PLAYER_GET_UNITE_TOKEN_3",
		"EVENT_GUIDE_NEW_KNIGHT_LINEUP",
		"EVENT_GUIDE_UNIT_RECRUIT",
		"EVENT_GUIDE_ARTIFACT_RECRUIT",
		"EVENT_GUIDE_PET_RECRUIT",
		"JUMP_TO_GVE_TARGET_POS",
		"EVENT_GUIDE_DAILY_RECRUIT",
		"EVENT_GUIDE_PRIMARY_RECRUIT",
		"EVENT_GUIDE_KNIGHT_SOUL_RECRUIT",
		"EVENT_GUIDE_PRECIOUS_RECRUIT",
		"EVENT_HOME_LAND_TO_LEFT",
		"EVENT_OUTPOST_PUSH_LIMIT_TASK",
		"EVENT_OUTPOST_GOTO_EQUIP"
	},
	DEBUG_EVENT = {
		WAIT_NET_LOGIN_ENTER = 32,
		READY_NET_RE_CONNECT = 3001,
		WAIT_NET_TIMEOUT = 31,
		WAIT_NET_DISCONNECT = 30,
		READY_MODULE_POP_ANI = 2101,
		WAIT_MODULE_POP_ANI = 21,
		READY_FUNC_UNLOCK = 2001,
		WAIT_FUNC_UNLOCK = 20,
		READY_FAKE_PVP_RESULT = 1101,
		WAIT_FAKE_PVP_RESULT = 11,
		READY_BATTLE_2_2_ROUND = 1006,
		READY_BATTLE_2_1_SKILL = 1005,
		READY_BATTLE_1_1_START = 1004,
		READY_BATTLE_0_BOSS_ROUND = 1003,
		READY_BATTLE_END = 1002,
		READY_BATTLE_ANIME_END = 1001,
		WAIT_BATTLE_READY_STATE = 10,
		READY_STORY_OVER = 401,
		WAIT_STORY_OVER = 4,
		READY_LOADING_MASK = 301,
		WAIT_LOADING_MASK = 3,
		READY_COMMON_GUIDE = 201,
		WAIT_COMMON_GUIDE = 2,
		READY_NEXT_FRAME_DELAY = 101,
		WAIT_NEXT_FRAME_DELAY = 1,
		READY_TEST_MATCH_EVENT = 99901,
		WAIT_TEST_MATCH_EVENT = 999,
		READY_SURE_OK_EVENT = 88801,
		WAIT_SURE_OK_EVENT = 888,
		READY_OUTPOST_KNIGHT_PAUSE = 4401,
		WAIT_OUTPOST_KNIGHT_RESUME = 44,
		READY_NET_LOGIN_PAUSE = 3301,
		WAIT_NET_LOGIN_RESUME = 33,
		READY_NET_LOGIN_EXIT = 3201
	},
	TICK_WEAK_GUIDE_CFG = {
		TEST_GUIDE = {
			tipsTxt = 10,
			canReTick = false,
			attachGuideLayer = true,
			opeType = 1,
			finger = true,
			frame = 0,
			isBigTips = false,
			checkFunc = function()
				return true
			end,
			tipsTxtDir = {
				y = -300,
				x = -500
			},
			fingerRevert = {
				y = -1,
				x = -1
			},
			fingerDir = {
				y = 1,
				x = 1
			},
			worldPos = {},
			size = {}
		},
		FIRST_ENTER_FIGHT_WITH_AUTO_OPEN = {
			tickEventDesc = "触发自动战斗引导",
			tipsTxt = 84,
			canReTick = false,
			tickEventId = 3010,
			addToSelf = true,
			finishEventId = 3020,
			finishEventDesc = "点击自动战斗按钮",
			opeType = 0,
			finger = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 50,
				x = -600
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		FIGHT_2X_OPEN = {
			tickEventDesc = "触发战斗加速引导",
			tipsTxt = 85,
			canReTick = false,
			tickEventId = 3030,
			addToSelf = true,
			finishEventId = 3040,
			finishEventDesc = "点击战斗加速按钮",
			finger = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 50,
				x = -600
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		FIGHT_3X_OPEN = {
			tickEventDesc = "触发三倍速引导",
			tipsTxt = 86,
			canReTick = false,
			tickEventId = 3050,
			addToSelf = true,
			finishEventId = 3060,
			finishEventDesc = "点击开启三倍速",
			finger = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 50,
				x = -600
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		SKIP_BATTLE_OPEN = {
			tickEventDesc = "触发跳过战斗引导",
			tipsTxt = 87,
			canReTick = false,
			tickEventId = 3070,
			addToSelf = true,
			finishEventId = 3080,
			finishEventDesc = "点击跳过战斗按钮",
			opeType = 1,
			finger = false,
			frame = 0,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 50,
				x = -600
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		BIO_PUZZLE_STAGE_1 = {
			finishEventDesc = "拖动插梢",
			finishEventId = 3120,
			canReTick = true,
			tickEventDesc = "触发解密引导",
			tickEventId = 3110,
			addToSelf = true,
			finger = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = -1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		BIO_PUZZLE_STAGE_2 = {
			tickTimes = 4,
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = -1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		BIO_TOUCH_GAME_STAGE_1 = {
			finishEventDesc = "点击第一个触摸点",
			finishEventId = 3140,
			canReTick = true,
			tickEventDesc = "触发触摸引导",
			tickEventId = 3130,
			addToSelf = true,
			finger = true,
			checkFunc = function()
				return true
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		BIO_TOUCH_GAME_STAGE_2 = {
			tickTimes = 4,
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return true
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		BIO_CLICK_GAME_STAGE_1 = {
			tickTimes = 2,
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return true
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		BIO_CLICK_GAME_STAGE_2 = {
			tickTimes = 4,
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return true
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		LINE_POS_5 = {
			finishEventDesc = "点击阵位5",
			finishEventId = 3160,
			canReTick = true,
			tickEventDesc = "触发阵位5引导",
			tickEventId = 3150,
			addToSelf = true,
			finger = true,
			checkFunc = function()
				return true
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		EQUIP_STEP_1 = {
			finishEventDesc = "点击装备入口按钮",
			finishEventId = 3180,
			canReTick = true,
			tickEventDesc = "触发装备入口引导",
			tickEventId = 3170,
			addToSelf = true,
			finger = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = -0.4
			}
		},
		EQUIP_STEP_2 = {
			finishEventDesc = "点击装备槽位",
			tickEventDesc = 3190,
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		WUSH_ENTRUST_FIGHT = {
			tickEventDesc = "触发委托作战引导",
			tipsTxt = 89,
			canReTick = false,
			tickEventId = 3200,
			addToSelf = true,
			finishEventId = 3210,
			finishEventDesc = "点击委托作战按钮",
			opeType = 1,
			frame = 0,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = -200,
				x = -300
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		UNITE_TOKEN_POS_1_CAN_USE = {
			finishEventDesc = "点击古物阵位1",
			finishEventId = 3230,
			canReTick = false,
			tickEventDesc = "触发古物满能量引导",
			tickEventId = 3220,
			finger = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GOTO_RECRUIT_KNIGHT = {
			finishEventDesc = "点击建构按钮",
			finishEventId = 3250,
			canReTick = true,
			tickEventDesc = "触发抽卡引导",
			tickEventId = 3240,
			addToSelf = true,
			finger = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		FATE_STEP_0 = {
			tickEventDesc = "点击援助按钮",
			tipsTxt = 90,
			canReTick = false,
			tickEventId = 3260,
			addToSelf = true,
			finger = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = -100,
				x = 400
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		FATE_STEP_1 = {
			tickEventId = 3270,
			canReTick = false,
			finger = true,
			addToSelf = true,
			tickEventDesc = "点击援助按钮",
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		FATE_STEP_2 = {
			finishEventId = 3280,
			tipsTxt = 91,
			canReTick = false,
			finishEventDesc = "点击空援助位",
			addToSelf = true,
			finger = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = -200,
				x = 0
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		FIRST_ENTER_GIVING_GIFT_LAYER = {
			tickEventDesc = "触发优化体送礼引导",
			tipsTxt = 92,
			canReTick = false,
			tickEventId = 3290,
			addToSelf = true,
			opeType = 1,
			finger = false,
			frame = 0,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 120,
				x = -600
			}
		},
		DUNGEON_STAGE_STAY = {
			tickEventDesc = "触发章节内停留引导",
			canReTick = true,
			tickEventId = 3300,
			addToSelf = true,
			opeType = 1,
			finger = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = -0.3,
				x = 0
			}
		},
		DUNGEON_PRIMARY_ENTRANCE_GUIDE = {
			addToSelf = true,
			canReTick = true,
			finger = true,
			frame = 0,
			fingerDir = {
				y = 0,
				x = 0
			},
			fingerRevert = {
				y = 1,
				x = -1
			}
		},
		DUNGEON_MAIN_LAYER_STAY_1 = {
			tickEventDesc = "触发板块内停留引导",
			canReTick = true,
			tickEventId = 3310,
			addToSelf = true,
			opeType = 1,
			finger = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		DUNGEON_MAIN_LAYER_STAY_2 = {
			tickEventDesc = "触发板块内停留引导",
			canReTick = true,
			tickEventId = 3310,
			addToSelf = true,
			opeType = 1,
			finger = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		BIO_STAGE_STAY = {
			tickEventDesc = "触发列传停留引导",
			canReTick = true,
			tickEventId = 3320,
			addToSelf = true,
			opeType = 1,
			finger = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = -1
			},
			fingerDir = {
				y = 0.4,
				x = 0
			}
		},
		WUSH_MAIN_STAY = {
			tickEventId = 3330,
			canReTick = true,
			finger = true,
			addToSelf = true,
			tickEventDesc = "触发黑渊停留引导",
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = -1
			},
			fingerDir = {
				y = 0,
				x = -0.6
			}
		},
		WUSH_FIRST_FAIL = {
			tipsTxt = 105,
			canReTick = false,
			addToSelf = true,
			finger = true,
			frame = 0,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 0,
				x = -400
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		REBEL_WEAK_FINGER = {
			canReTick = false,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		STORM_WEAK_FINGER = {
			canReTick = false,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = -1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		BIO_TEAM_WEAK_FINGER = {
			canReTick = false,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_DUNGEON_WEAK_FINGER = {
			canReTick = false,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0.5,
				x = 0
			}
		},
		GUIDE_HOME_SHOWER_WEAK_FINGER = {
			finishEventDesc = "点击浴缸",
			finishEventId = 3350,
			canReTick = true,
			tickEventDesc = "触发浴缸引导",
			tickEventId = 3340,
			addToSelf = true,
			finger = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_FIRST_RECHARGE = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		PHOENIX_GIFT_ENTERED = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		BATTLE_SPEED_ENTERED = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = -1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		CROSS_FRIEND_STEP_1 = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		CROSS_FRIEND_STEP_2 = {
			tipsTxt = 210,
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 300,
				x = 200
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_DAILY_COST_STEP_1 = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_DAILY_COST_STEP_2 = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_PASS_CARD = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_PEAK_ARENA = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_MINE_SCORE = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_DUNGEON_FAIL = {
			tipsTxt = 30,
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			},
			tipsTxtDir = {
				y = -300,
				x = 700
			}
		},
		GUIDE_ONLINE_GIFT = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_BIO_FIRST_CHAPTER_FINISH = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUILD_CHECK_KNIGHT_ADVANCE_1 = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUILD_CHECK_KNIGHT_ADVANCE_2 = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = -0.7
			}
		},
		GUILD_THEME_TURN_CARD_START = {
			frame = 0,
			canReTick = false,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUILD_THEME_TURN_CARD_TOUCH = {
			frame = 0,
			tickTimes = 3,
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUILD_THEME_PUZZLE_START = {
			tickTimes = 3,
			canReTick = true,
			addToSelf = false,
			opeType = 1,
			finger = true,
			isDrag = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_CHECK_FOG_EXPLORE = {
			tickTimes = 5,
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_CHECK_FOG_IDLE_FIRST = {
			tipsTxt = 138,
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 0,
				x = 300
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_CHECK_FOG_IDLE_FULL = {
			tipsTxt = 137,
			tickTimes = 5,
			canReTick = true,
			addToSelf = true,
			finger = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 0,
				x = 300
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_CHECK_FOG_TALENT_FIRST = {
			tipsTxt = 140,
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 0,
				x = 300
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_CHECK_FOG_TALENT = {
			tickTimes = 5,
			tipsTxt = 139,
			canReTick = true,
			addToSelf = true,
			finger = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 0,
				x = 300
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_CHECK_FOG_BATTLE_FINISH = {
			tickTimes = 5,
			tipsTxt = 141,
			canReTick = true,
			addToSelf = true,
			finger = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = -200,
				x = 0
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_CHECK_FOG_STAGE_REWARD = {
			tipsTxt = 156,
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = -200,
				x = 200
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_CHECK_FOG_SELECT_STAGE = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_GVE_IDLE_REWARD = {
			tipsTxt = 164,
			canReTick = false,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = -200,
				x = -200
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_GVE_HALIDOM_LE_UP = {
			tipsTxt = 165,
			canReTick = false,
			finger = true,
			addToSelf = false,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 200,
				x = -200
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_GVE_HALIDOM_CHANGE_BRANCH = {
			tipsTxt = 166,
			canReTick = false,
			addToSelf = true,
			opeType = 1,
			finger = false,
			isBigTips = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_GVE_MAIN_HALIDOM_CHANGE_BRANCH = {
			tipsTxt = 168,
			canReTick = false,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 200,
				x = -400
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_PEAK_FORMATION = {
			canReTick = false,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_GVE_NOT_UP_FORMATION = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		GUIDE_GVE_NO_PRE_FORMATION = {
			canReTick = false,
			finger = true,
			addToSelf = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		},
		CS_ARENA_ROBOT_GUIDE = {
			tipsTxt = 218,
			canReTick = true,
			addToSelf = true,
			finger = true,
			checkFunc = function()
				return g.core.model.User:isFormationValid()
			end,
			tipsTxtDir = {
				y = 0,
				x = 350
			},
			fingerRevert = {
				y = 1,
				x = 1
			},
			fingerDir = {
				y = 0,
				x = 0
			},
			worldPos = {},
			size = {}
		},
		CS_ARENA_ROBOT_CHALLENGE = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			fingerDir = {
				y = 0,
				x = -0.6
			},
			fingerRevert = {
				y = 1,
				x = 1
			}
		},
		CS_ARENA_ROBOT_FORMATION = {
			addToSelf = true,
			canReTick = true,
			finger = true,
			frame = 0,
			fingerDir = {
				y = 0,
				x = -50
			},
			fingerRevert = {
				y = 0,
				x = 0
			}
		},
		CS_ARENA_ADDITION = {
			addToSelf = true,
			canReTick = false,
			finger = true,
			frame = 0,
			fingerDir = {
				y = 0,
				x = -50
			},
			fingerRevert = {
				y = 0,
				x = 0
			}
		},
		DUNGEON_BIO_ENTRANCE_GUIDE = {
			addToSelf = true,
			canReTick = true,
			finger = true,
			frame = 0,
			fingerDir = {
				y = 0,
				x = 0
			},
			fingerRevert = {
				y = 1,
				x = -1
			}
		},
		GOLD_SAVING_POP = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			fingerDir = {
				y = 0,
				x = 0
			},
			fingerRevert = {
				y = 1,
				x = 1
			}
		},
		REGIST_SHOW = {
			canReTick = true,
			finger = true,
			addToSelf = true,
			fingerDir = {
				y = 0,
				x = 0
			},
			fingerRevert = {
				y = 1,
				x = -1
			}
		},
		FOG_BATTLE_RETRY_TIP = {
			tipsTxt = 225,
			canReTick = true,
			addToSelf = true,
			opeType = 1,
			finger = true,
			frame = 0,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				y = 0,
				x = -400
			},
			fingerRevert = {
				y = 1,
				x = -1
			},
			fingerDir = {
				y = 0,
				x = 0
			}
		}
	},
	ONE_LAYER_TIPS_GUIDE = {
		AUTO_FORMATION = {
			{
				frame = 0,
				tipsTxt = 176,
				tipsTxtDir = {
					y = 0,
					x = 400
				}
			},
			{
				frame = 0,
				tipsTxt = 177,
				tipsTxtDir = {
					y = 0,
					x = -500
				}
			},
			{
				frame = 0,
				tipsTxt = 178,
				tipsTxtDir = {
					y = 300,
					x = 0
				}
			},
			{
				frame = 0,
				tipsTxt = 179,
				tipsTxtDir = {
					y = -200,
					x = -400
				}
			}
		},
		GVE_FORMATION = {
			{
				tipsTxt = 188,
				isBigTips = true
			},
			{
				dragShow = true,
				tipsTxt = 189,
				dragY = 200,
				frame = 0,
				dragX = 200,
				tipsTxtDir = {
					y = 0,
					x = -500
				}
			},
			{
				frame = 0,
				tipsTxt = 190,
				tipsTxtDir = {
					y = -200,
					x = -400
				}
			},
			{
				frame = 0,
				tipsTxt = 191,
				tipsTxtDir = {
					y = 200,
					x = 400
				}
			}
		},
		GVE_FORMATION_NEW = {
			{
				tipsTxt = 188,
				isBigTips = true
			},
			{
				dragShow = true,
				tipsTxt = 189,
				dragY = 200,
				frame = 0,
				dragX = 200,
				tipsTxtDir = {
					y = 0,
					x = -500
				}
			},
			{
				frame = 0,
				tipsTxt = 191,
				tipsTxtDir = {
					y = 200,
					x = 400
				}
			}
		},
		GVE_KILLER_TASK = {
			{
				storyId = 1778
			},
			{
				frame = 0,
				tipsTxt = 182,
				tipsTxtDir = {
					y = -100,
					x = -300
				}
			},
			{
				frame = 0,
				tipsTxt = 183,
				tipsTxtDir = {
					y = 0,
					x = -400
				}
			}
		},
		GVE_RESEARCH_TASK = {
			{
				storyId = 1777
			},
			{
				frame = 0,
				tipsTxt = 180,
				tipsTxtDir = {
					y = -100,
					x = -300
				}
			},
			{
				frame = 0,
				tipsTxt = 181,
				tipsTxtDir = {
					y = 0,
					x = -400
				}
			}
		},
		GVE_FIRST_STAGE_FINISH = {
			{
				event = "JUMP_TO_GVE_FIRST_STAGE"
			},
			{
				tipsTxt = 184,
				isBigTips = true
			},
			{
				tipsTxt = 185,
				isBigTips = true
			}
		},
		GVE_SECOND_STAGE_FINISH = {
			{
				event = "JUMP_TO_GVE_SECOND_STAGE"
			},
			{
				tipsTxt = 186,
				isBigTips = true
			},
			{
				tipsTxt = 187,
				isBigTips = true
			}
		},
		WUSH_TOWER_USE_CARD = {
			{
				frame = 0,
				tipsTxt = 200,
				tipsTxtDir = {
					y = -100,
					x = 400
				}
			},
			{
				finger = true,
				tipsTxt = 201,
				tipsTxtDir = {
					y = -100,
					x = 400
				}
			},
			{
				tipsTxt = 202,
				tipsTxtDir = {
					y = -100,
					x = -400
				}
			}
		},
		ECHOLAB_ENTER_COLLECT = {
			{
				frame = 0,
				tipsTxt = 207,
				tipsTxtDir = {
					y = 100,
					x = 0
				}
			},
			{
				frame = 0,
				tipsTxt = 208,
				tipsTxtDir = {
					y = -200,
					x = -400
				}
			},
			{
				frame = 0,
				tipsTxt = 209,
				tipsTxtDir = {
					y = 0,
					x = -300
				}
			}
		},
		CS_ARENA_BATTLE_PREPARE = {
			{
				tipsTxt = 219,
				tipsTxtDir = {
					y = 0,
					x = 0
				}
			},
			{
				finger = true,
				tipsTxt = 220,
				tipsTxtDir = {
					y = -100,
					x = 240
				}
			},
			{
				frame = 0,
				tipsTxt = 221,
				tipsTxtDir = {
					y = -100,
					x = -400
				}
			},
			{
				frame = 0,
				tipsTxt = 222,
				tipsTxtDir = {
					y = 160,
					x = -250
				}
			},
			{
				frame = 0,
				tipsTxt = 228,
				tipsTxtDir = {
					y = -220,
					x = -200
				}
			}
		},
		CS_ARENA_BATTLE_ENTER = {
			{
				tipsTxt = 223,
				finger = true,
				frame = 0,
				tipsTxtDir = {
					y = -100,
					x = -560
				},
				fingerDir = {
					y = 0,
					x = -100
				}
			}
		},
		GENE_DRAG_GUIDE = {
			{
				dragShow = true,
				tipsTxt = 215,
				dragY = 105,
				frame = 0,
				dragX = 105,
				tipsTxtDir = {
					y = -240,
					x = 100
				}
			}
		},
		TEAM_PVP_MAIN_LAYER_GUIDE = {
			{
				finger = false,
				tipsTxt = 229,
				tipsTxtDir = {
					y = -140,
					x = 50
				}
			},
			{
				frame = 0,
				tipsTxt = 230,
				finger = false,
				tipsTxtDir = {
					y = 0,
					x = -650
				}
			},
			{
				frame = 0,
				tipsTxt = 231,
				finger = false,
				tipsTxtDir = {
					y = -200,
					x = -500
				}
			},
			{
				event = "TEAM_PVP_GUIDE_VIDEO"
			}
		},
		EXPLORATION_MAIN_LAYER_GUIDE1 = {
			{
				finger = false,
				tipsTxt = 236,
				tipsTxtDir = {
					y = 0,
					x = 0
				}
			},
			{
				frame = 1,
				tipsTxt = 237,
				finger = false,
				tipsTxtDir = {
					y = 0,
					x = -650
				}
			},
			{
				event = "EXPLORATION_GUIDE_MOVE_TO_MIRROR"
			},
			{
				frame = 1,
				tipsTxt = 238,
				finger = false,
				tipsTxtDir = {
					y = -150,
					x = 0
				}
			},
			{
				finger = false,
				tipsTxt = 239,
				tipsTxtDir = {
					y = -150,
					x = 0
				}
			},
			{
				event = "EXPLORATION_GUIDE_POP_MIRROR"
			}
		},
		EXPLORATION_MAIN_LAYER_GUIDE2 = {
			{
				finger = false,
				tipsTxt = 240,
				tipsTxtDir = {
					y = 0,
					x = 0
				}
			},
			{
				event = "EXPLORATION_GUIDE_MOVE_TO_FIRST_MONSTER"
			},
			{
				finger = false,
				tipsTxt = 241,
				tipsTxtDir = {
					y = 100,
					x = 0
				}
			},
			{
				event = "EXPLORATION_GUIDE_MOVE_TO_SHOP"
			},
			{
				frame = 1,
				tipsTxt = 242,
				finger = false,
				tipsTxtDir = {
					y = 100,
					x = 0
				}
			}
		},
		EXPLORATION_SLAVE_GUIDE = {
			{
				frame = 0,
				tipsTxt = 243,
				finger = true,
				tipsTxtDir = {
					y = -300,
					x = 100
				}
			},
			{
				event = "EXPLORATION_OPEN_KNIGHT_BAG"
			}
		},
		RED_CLIFF_APPLY_GUIDE = {
			{
				frame = 0,
				tipsTxt = 248,
				finger = true,
				tipsTxtDir = {
					y = -300,
					x = -800
				}
			}
		},
		RED_CLIFF_APPLY_FAIL_GUIDE = {
			{
				finger = false,
				tipsTxt = 249,
				tipsTxtDir = {
					y = -300,
					x = -800
				}
			}
		},
		BOUNTY_SUMMON_WEEK_GUIDE = {
			{
				frame = 0,
				tipsTxt = 253,
				tipsTxtDir = {
					y = -300,
					x = -800
				}
			},
			{
				event = "BOUNTY_SUMMON_WEEK_GUIDE_END"
			}
		},
		BOUNTY_BTN_WEEK_GUIDE = {
			{
				frame = 0,
				tipsTxt = 254,
				tipsTxtDir = {
					y = -89,
					x = 339
				}
			},
			{
				tipsTxt = 255
			}
		},
		THEME_THIRD_BOSS_GUIDE = {
			{
				frame = 0,
				tipsTxt = 264,
				tipsTxtDir = {
					y = 10,
					x = -420
				}
			},
			{
				frame = 0,
				tipsTxt = 265,
				tipsTxtDir = {
					y = -89,
					x = -399
				}
			}
		},
		RERUN_CHOOSE_AWARD_WEEK_GUIDE = {
			{
				frame = 0,
				opeType = 0,
				tipsTxt = 266,
				tipsTxtDir = {
					y = 89,
					x = -339
				}
			}
		},
		RERUN_CHOOSE_AWARD_POP_WEEK_GUIDE = {
			{
				tipsTxt = 267
			}
		}
	},
	SAVE_SERVER_DATA_IDS = {
		FOG_TALENT_ENTER = 1010,
		FOG_IDLE_ENTER = 1009,
		ONLINE_GIFT_ENTER = 1008,
		MINE_SCORE_CLICKED = 1007,
		PEAK_ARENA_FIGHT_CLICKED = 1006,
		FIRST_FIGHT_WAR_ENTER = 1005,
		FIRST_DAILY_COST_ENTER = 1004,
		FIRST_RECHARGE_ENTER = 1003,
		HOME_LAND_HOME_SHOWER = 1002,
		HOME_LAND_HOME_LIVED = 1001,
		START = 1000,
		DOMAIN_CHOOSE_TICK_GUIDE_ID = 49,
		PEAK_ARENA_TICK_GUIDE_ID = 16,
		BOUNTY_SUMMON_WEEK_GUIDE = 1035,
		RERUN_CHOOSE_AWARD_POP_WEEK_GUIDE = 1039,
		RERUN_CHOOSE_AWARD_WEEK_GUIDE = 1038,
		THEME_THIRD_BOSS_GUIDE = 1037,
		BOUNTY_BTN_WEEK_GUIDE = 1036,
		NEW_SLG_STEP_GUIDE = 1042,
		BATTLE_SPEED_ENTERED = 1029,
		PHOENIX_GIFT_ENTERED = 1028,
		RED_CLIFF_APPLY_GUIDE = 1034,
		OUTPOST_WEAK_TICK_GUIDE = 1047,
		EXPLORATION_SLAVE_GUIDE = 1033,
		EXPLORATION_MAIN_LAYER_GUIDE2 = 1032,
		EXPLORATION_MAIN_LAYER_GUIDE1 = 1031,
		TEAM_PVP_MAIN_LAYER_GUIDE = 1030,
		WARR_GUIDE_1 = 1046,
		HANDBOOK_GUIDE_1 = 1045,
		WUSH_AUTO_CHALLENGE_GUIDE = 1044,
		NEW_SLG_STEP_GUIDE_S2 = 1043,
		RICH_MAN_FIRST_STEAL = 1041,
		RICH_MAN_FIRST_MONSTER = 1040,
		GOLD_SAVING_TICK2 = 1027,
		GOLD_SAVING_TICK = 1026,
		CROSS_SERVER_ARENA3 = 1025,
		CROSS_SERVER_ARENA2 = 1024,
		CROSS_SERVER_ARENA1 = 1023,
		CROSS_FRIEND_2 = 1022,
		CROSS_FRIEND_1 = 1021,
		ECHOLAB_FIRST_ENTER_COLLECT = 1020,
		WUSH_TOWER_FIRST_USE_CARD = 1019,
		GVE_FIRST_ENTER_KILL_RESEARCH = 1018,
		GVE_FIRST_ENTER_GUIDE1 = 1017,
		GVE_BOSS_AVG_PLAY = 1016,
		GVE_FORMAL_STAGE_IN = 1015,
		GVE_SIGN_UP_STAGE_IN = 1014,
		GVE_STORY_PLAYED = 1013,
		GVE_GRID_DETAIL_ENTER = 1012,
		GVE_HALIDOM_ENTER = 1011
	},
	SPE_STORY_IDS = {
		ONLINE_GIFT_STORY = 1756
	},
	VALENTINES_DAY_VOTE = {
		FIRST_ENTER = 1764
	}
}
