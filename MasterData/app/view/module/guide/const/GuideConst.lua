return {
	GUIDE_SERVER_CLOSE_ID = 999999,
	COMMON_GUIDE_PAGE_SHOW_TYPE = {
		PIC = 1,
		VIDEO = 2
	},
	TICK_CONST = {
		DUNGEON_STAGE = 4,
		LEVEL = 2,
		CREATE = 1,
		ENUM_TICK = 6,
		BATTLE_FAIL = 5,
		MODULE_OPEN = 3
	},
	GUIDE_TYPE = {
		STRONG = 1,
		TICK = 3,
		WEAK = 2
	},
	ENUM_TICK = {
		OUTPOST_TASK_1005 = 25,
		HOME_SHOWER_GUIDE_TICKED = 4,
		GVE_FIRST_ENTER_GRID_DETAIL = 12,
		OUTPOST_TASK_1009 = 26,
		GUIDE_WAR_DEVELOP = 5,
		FOG_FIRST_ENTER_IDLE = 8,
		PREDESTINATION_TICKED = 2,
		Dungeon_AUTO_GUIDE = 23,
		RICH_MAN_MONSTER = 19,
		GVE_IS_IN_FORMAL_FIRST_ENTER_STAGE = 15,
		FOG_FIRST_SELECT_SECOND_MONSTER = 7,
		FIRST_LINEUP_SSR = 1,
		WARR_GUIDE_TIP = 28,
		GUIDE_WAR_FIGHT = 6,
		OUTPOST_TASK_1017 = 32,
		FOG_FIRST_ENTER_TALENT = 9,
		FOG_FIRST_ENTER_SELECT_KEEP = 10,
		RICH_MAN_STEAL = 20,
		GVE_IS_IN_SIGN_UP_STAGE = 13,
		HOME_GUIDE_TICKED = 3,
		PRE_FORMATION_MODULE_OPEN = 16,
		DOMAIN_GUIDE = 33,
		GENE_TICK_GUIDE_FORCE = 18,
		OUTPOST_TASK_1004 = 24,
		OUTPOST_TASK_1015 = 31,
		OUTPOST_WEAK_TICK_GUIDE = 30,
		GVE_RESEARCH_GUIDE = 17,
		GVE_IS_IN_FORMAL_STAGE = 14,
		HANDBOOK_GUIDE = 29,
		WUSH_AUTO_GUIDE = 22,
		GVE_FIRST_ENTER_HALIDOM = 11,
		NEW_SLG_STEP_GUIDE = 21,
		OUTPOST_TASK_1013 = 27
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
		READY_NET_LOGIN_EXIT = 3201,
		WAIT_STORY_OVER = 4,
		READY_MODULE_POP_ANI = 2101,
		WAIT_SURE_OK_EVENT = 888,
		READY_BATTLE_0_BOSS_ROUND = 1003,
		READY_BATTLE_1_1_START = 1004,
		READY_STORY_OVER = 401,
		WAIT_TEST_MATCH_EVENT = 999,
		READY_BATTLE_2_2_ROUND = 1006,
		WAIT_NET_LOGIN_ENTER = 32,
		WAIT_MODULE_POP_ANI = 21,
		READY_OUTPOST_KNIGHT_PAUSE = 4401,
		WAIT_NET_DISCONNECT = 30,
		WAIT_BATTLE_READY_STATE = 10,
		WAIT_FUNC_UNLOCK = 20,
		READY_NET_RE_CONNECT = 3001,
		WAIT_NET_TIMEOUT = 31,
		READY_BATTLE_2_1_SKILL = 1005,
		WAIT_NEXT_FRAME_DELAY = 1,
		READY_TEST_MATCH_EVENT = 99901,
		READY_COMMON_GUIDE = 201,
		READY_BATTLE_END = 1002,
		READY_BATTLE_ANIME_END = 1001,
		WAIT_OUTPOST_KNIGHT_RESUME = 44,
		READY_NET_LOGIN_PAUSE = 3301,
		WAIT_NET_LOGIN_RESUME = 33,
		READY_FUNC_UNLOCK = 2001,
		READY_FAKE_PVP_RESULT = 1101,
		READY_NEXT_FRAME_DELAY = 101,
		READY_LOADING_MASK = 301,
		WAIT_FAKE_PVP_RESULT = 11,
		WAIT_LOADING_MASK = 3,
		WAIT_COMMON_GUIDE = 2,
		READY_SURE_OK_EVENT = 88801
	},
	TICK_WEAK_GUIDE_CFG = {
		TEST_GUIDE = {
			finger = true,
			frame = 0,
			attachGuideLayer = true,
			tipsTxt = 10,
			opeType = 1,
			canReTick = false,
			isBigTips = false,
			checkFunc = function()
				return true
			end,
			tipsTxtDir = {
				x = -500,
				y = -300
			},
			fingerRevert = {
				x = -1,
				y = -1
			},
			fingerDir = {
				x = 1,
				y = 1
			},
			worldPos = {},
			size = {}
		},
		FIRST_ENTER_FIGHT_WITH_AUTO_OPEN = {
			addToSelf = true,
			finger = true,
			tickEventDesc = "触发自动战斗引导",
			tipsTxt = 84,
			tickEventId = 3010,
			opeType = 0,
			finishEventId = 3020,
			canReTick = false,
			finishEventDesc = "点击自动战斗按钮",
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = -600,
				y = 50
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		FIGHT_2X_OPEN = {
			finger = true,
			addToSelf = true,
			tickEventDesc = "触发战斗加速引导",
			tipsTxt = 85,
			tickEventId = 3030,
			finishEventId = 3040,
			finishEventDesc = "点击战斗加速按钮",
			canReTick = false,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = -600,
				y = 50
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		FIGHT_3X_OPEN = {
			finger = true,
			addToSelf = true,
			tickEventDesc = "触发三倍速引导",
			tipsTxt = 86,
			tickEventId = 3050,
			finishEventId = 3060,
			finishEventDesc = "点击开启三倍速",
			canReTick = false,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = -600,
				y = 50
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		SKIP_BATTLE_OPEN = {
			addToSelf = true,
			frame = 0,
			finger = false,
			tipsTxt = 87,
			tickEventId = 3070,
			opeType = 1,
			tickEventDesc = "触发跳过战斗引导",
			canReTick = false,
			finishEventId = 3080,
			finishEventDesc = "点击跳过战斗按钮",
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = -600,
				y = 50
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		BIO_PUZZLE_STAGE_1 = {
			addToSelf = true,
			tickEventDesc = "触发解密引导",
			finger = true,
			finishEventId = 3120,
			finishEventDesc = "拖动插梢",
			tickEventId = 3110,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = -1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		BIO_PUZZLE_STAGE_2 = {
			addToSelf = true,
			tickTimes = 4,
			canReTick = true,
			finger = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = -1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		BIO_TOUCH_GAME_STAGE_1 = {
			addToSelf = true,
			tickEventDesc = "触发触摸引导",
			finger = true,
			finishEventId = 3140,
			finishEventDesc = "点击第一个触摸点",
			tickEventId = 3130,
			canReTick = true,
			checkFunc = function()
				return true
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		BIO_TOUCH_GAME_STAGE_2 = {
			finger = true,
			tickTimes = 4,
			canReTick = true,
			addToSelf = true,
			checkFunc = function()
				return true
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		BIO_CLICK_GAME_STAGE_1 = {
			finger = true,
			tickTimes = 2,
			canReTick = true,
			addToSelf = true,
			checkFunc = function()
				return true
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		BIO_CLICK_GAME_STAGE_2 = {
			finger = true,
			tickTimes = 4,
			canReTick = true,
			addToSelf = true,
			checkFunc = function()
				return true
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		LINE_POS_5 = {
			finger = true,
			tickEventDesc = "触发阵位5引导",
			addToSelf = true,
			finishEventId = 3160,
			finishEventDesc = "点击阵位5",
			tickEventId = 3150,
			canReTick = true,
			checkFunc = function()
				return true
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		EQUIP_STEP_1 = {
			finger = true,
			tickEventDesc = "触发装备入口引导",
			addToSelf = true,
			finishEventId = 3180,
			finishEventDesc = "点击装备入口按钮",
			tickEventId = 3170,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = -0.4,
				y = 0
			}
		},
		EQUIP_STEP_2 = {
			addToSelf = true,
			finger = true,
			canReTick = true,
			finishEventDesc = "点击装备槽位",
			tickEventDesc = 3190,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		WUSH_ENTRUST_FIGHT = {
			addToSelf = true,
			frame = 0,
			tickEventDesc = "触发委托作战引导",
			tipsTxt = 89,
			tickEventId = 3200,
			opeType = 1,
			finishEventId = 3210,
			canReTick = false,
			finishEventDesc = "点击委托作战按钮",
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = -300,
				y = -200
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		UNITE_TOKEN_POS_1_CAN_USE = {
			finger = true,
			tickEventDesc = "触发古物满能量引导",
			finishEventDesc = "点击古物阵位1",
			finishEventId = 3230,
			tickEventId = 3220,
			canReTick = false,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GOTO_RECRUIT_KNIGHT = {
			addToSelf = true,
			tickEventDesc = "触发抽卡引导",
			finger = true,
			finishEventId = 3250,
			finishEventDesc = "点击建构按钮",
			tickEventId = 3240,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		FATE_STEP_0 = {
			addToSelf = true,
			finger = true,
			tickEventDesc = "点击援助按钮",
			tipsTxt = 90,
			tickEventId = 3260,
			canReTick = false,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = 400,
				y = -100
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		FATE_STEP_1 = {
			finger = true,
			addToSelf = true,
			canReTick = false,
			tickEventDesc = "点击援助按钮",
			tickEventId = 3270,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		FATE_STEP_2 = {
			addToSelf = true,
			finger = true,
			finishEventId = 3280,
			tipsTxt = 91,
			finishEventDesc = "点击空援助位",
			canReTick = false,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = 0,
				y = -200
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		FIRST_ENTER_GIVING_GIFT_LAYER = {
			finger = false,
			addToSelf = true,
			frame = 0,
			tipsTxt = 92,
			tickEventDesc = "触发优化体送礼引导",
			tickEventId = 3290,
			opeType = 1,
			canReTick = false,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = -600,
				y = 120
			}
		},
		DUNGEON_STAGE_STAY = {
			addToSelf = true,
			finger = true,
			tickEventDesc = "触发章节内停留引导",
			tickEventId = 3300,
			opeType = 1,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = -0.3
			}
		},
		DUNGEON_PRIMARY_ENTRANCE_GUIDE = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			frame = 0,
			fingerDir = {
				x = 0,
				y = 0
			},
			fingerRevert = {
				x = -1,
				y = 1
			}
		},
		DUNGEON_MAIN_LAYER_STAY_1 = {
			addToSelf = true,
			finger = true,
			tickEventDesc = "触发板块内停留引导",
			tickEventId = 3310,
			opeType = 1,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		DUNGEON_MAIN_LAYER_STAY_2 = {
			addToSelf = true,
			finger = true,
			tickEventDesc = "触发板块内停留引导",
			tickEventId = 3310,
			opeType = 1,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		BIO_STAGE_STAY = {
			finger = true,
			addToSelf = true,
			tickEventDesc = "触发列传停留引导",
			tickEventId = 3320,
			opeType = 1,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = -1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0.4
			}
		},
		WUSH_MAIN_STAY = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			tickEventDesc = "触发黑渊停留引导",
			tickEventId = 3330,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = -1,
				y = 1
			},
			fingerDir = {
				x = -0.6,
				y = 0
			}
		},
		WUSH_FIRST_FAIL = {
			finger = true,
			frame = 0,
			addToSelf = true,
			tipsTxt = 105,
			canReTick = false,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = -400,
				y = 0
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		REBEL_WEAK_FINGER = {
			finger = true,
			addToSelf = true,
			canReTick = false,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		STORM_WEAK_FINGER = {
			finger = true,
			addToSelf = true,
			canReTick = false,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = -1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		BIO_TEAM_WEAK_FINGER = {
			finger = true,
			addToSelf = true,
			canReTick = false,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_DUNGEON_WEAK_FINGER = {
			finger = true,
			addToSelf = true,
			canReTick = false,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0.5
			}
		},
		GUIDE_HOME_SHOWER_WEAK_FINGER = {
			addToSelf = true,
			tickEventDesc = "触发浴缸引导",
			finger = true,
			finishEventId = 3350,
			finishEventDesc = "点击浴缸",
			tickEventId = 3340,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_FIRST_RECHARGE = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		PHOENIX_GIFT_ENTERED = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		BATTLE_SPEED_ENTERED = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = -1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		CROSS_FRIEND_STEP_1 = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		CROSS_FRIEND_STEP_2 = {
			addToSelf = true,
			finger = true,
			canReTick = true,
			tipsTxt = 210,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = 200,
				y = 300
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_DAILY_COST_STEP_1 = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_DAILY_COST_STEP_2 = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_PASS_CARD = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_PEAK_ARENA = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_MINE_SCORE = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_DUNGEON_FAIL = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			tipsTxt = 30,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			},
			tipsTxtDir = {
				x = 700,
				y = -300
			}
		},
		GUIDE_ONLINE_GIFT = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_BIO_FIRST_CHAPTER_FINISH = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUILD_CHECK_KNIGHT_ADVANCE_1 = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUILD_CHECK_KNIGHT_ADVANCE_2 = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = -0.7,
				y = 0
			}
		},
		GUILD_THEME_TURN_CARD_START = {
			addToSelf = true,
			finger = true,
			canReTick = false,
			frame = 0,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUILD_THEME_TURN_CARD_TOUCH = {
			addToSelf = true,
			tickTimes = 3,
			canReTick = true,
			finger = true,
			frame = 0,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUILD_THEME_PUZZLE_START = {
			finger = true,
			addToSelf = false,
			tickTimes = 3,
			isDrag = true,
			opeType = 1,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_CHECK_FOG_EXPLORE = {
			addToSelf = true,
			tickTimes = 5,
			canReTick = true,
			finger = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_CHECK_FOG_IDLE_FIRST = {
			addToSelf = true,
			finger = true,
			canReTick = true,
			tipsTxt = 138,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = 300,
				y = 0
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_CHECK_FOG_IDLE_FULL = {
			finger = true,
			addToSelf = true,
			tickTimes = 5,
			tipsTxt = 137,
			canReTick = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = 300,
				y = 0
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_CHECK_FOG_TALENT_FIRST = {
			addToSelf = true,
			finger = true,
			canReTick = true,
			tipsTxt = 140,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = 300,
				y = 0
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_CHECK_FOG_TALENT = {
			finger = true,
			addToSelf = true,
			tickTimes = 5,
			tipsTxt = 139,
			canReTick = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = 300,
				y = 0
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_CHECK_FOG_BATTLE_FINISH = {
			finger = true,
			addToSelf = true,
			tickTimes = 5,
			tipsTxt = 141,
			canReTick = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = 0,
				y = -200
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_CHECK_FOG_STAGE_REWARD = {
			addToSelf = true,
			finger = true,
			canReTick = true,
			tipsTxt = 156,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = 200,
				y = -200
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_CHECK_FOG_SELECT_STAGE = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_GVE_IDLE_REWARD = {
			addToSelf = true,
			finger = true,
			canReTick = false,
			tipsTxt = 164,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = -200,
				y = -200
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_GVE_HALIDOM_LE_UP = {
			addToSelf = false,
			finger = true,
			canReTick = false,
			tipsTxt = 165,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = -200,
				y = 200
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_GVE_HALIDOM_CHANGE_BRANCH = {
			finger = false,
			addToSelf = true,
			tipsTxt = 166,
			opeType = 1,
			canReTick = false,
			isBigTips = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_GVE_MAIN_HALIDOM_CHANGE_BRANCH = {
			addToSelf = true,
			finger = true,
			canReTick = false,
			tipsTxt = 168,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = -400,
				y = 200
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_PEAK_FORMATION = {
			finger = true,
			addToSelf = true,
			canReTick = false,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_GVE_NOT_UP_FORMATION = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		GUIDE_GVE_NO_PRE_FORMATION = {
			finger = true,
			addToSelf = true,
			canReTick = false,
			checkFunc = function()
				return
			end,
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		},
		CS_ARENA_ROBOT_GUIDE = {
			finger = true,
			addToSelf = true,
			tipsTxt = 218,
			canReTick = true,
			checkFunc = function()
				return g.core.model.User:isFormationValid()
			end,
			tipsTxtDir = {
				x = 350,
				y = 0
			},
			fingerRevert = {
				x = 1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			},
			worldPos = {},
			size = {}
		},
		CS_ARENA_ROBOT_CHALLENGE = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			fingerDir = {
				x = -0.6,
				y = 0
			},
			fingerRevert = {
				x = 1,
				y = 1
			}
		},
		CS_ARENA_ROBOT_FORMATION = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			frame = 0,
			fingerDir = {
				x = -50,
				y = 0
			},
			fingerRevert = {
				x = 0,
				y = 0
			}
		},
		CS_ARENA_ADDITION = {
			finger = true,
			addToSelf = true,
			canReTick = false,
			frame = 0,
			fingerDir = {
				x = -50,
				y = 0
			},
			fingerRevert = {
				x = 0,
				y = 0
			}
		},
		DUNGEON_BIO_ENTRANCE_GUIDE = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			frame = 0,
			fingerDir = {
				x = 0,
				y = 0
			},
			fingerRevert = {
				x = -1,
				y = 1
			}
		},
		GOLD_SAVING_POP = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			fingerDir = {
				x = 0,
				y = 0
			},
			fingerRevert = {
				x = 1,
				y = 1
			}
		},
		REGIST_SHOW = {
			finger = true,
			addToSelf = true,
			canReTick = true,
			fingerDir = {
				x = 0,
				y = 0
			},
			fingerRevert = {
				x = -1,
				y = 1
			}
		},
		FOG_BATTLE_RETRY_TIP = {
			finger = true,
			frame = 0,
			addToSelf = true,
			tipsTxt = 225,
			opeType = 1,
			canReTick = true,
			checkFunc = function()
				return
			end,
			tipsTxtDir = {
				x = -400,
				y = 0
			},
			fingerRevert = {
				x = -1,
				y = 1
			},
			fingerDir = {
				x = 0,
				y = 0
			}
		}
	},
	ONE_LAYER_TIPS_GUIDE = {
		AUTO_FORMATION = {
			{
				tipsTxt = 176,
				frame = 0,
				tipsTxtDir = {
					x = 400,
					y = 0
				}
			},
			{
				tipsTxt = 177,
				frame = 0,
				tipsTxtDir = {
					x = -500,
					y = 0
				}
			},
			{
				tipsTxt = 178,
				frame = 0,
				tipsTxtDir = {
					x = 0,
					y = 300
				}
			},
			{
				tipsTxt = 179,
				frame = 0,
				tipsTxtDir = {
					x = -400,
					y = -200
				}
			}
		},
		GVE_FORMATION = {
			{
				tipsTxt = 188,
				isBigTips = true
			},
			{
				tipsTxt = 189,
				dragY = 200,
				frame = 0,
				dragShow = true,
				dragX = 200,
				tipsTxtDir = {
					x = -500,
					y = 0
				}
			},
			{
				tipsTxt = 190,
				frame = 0,
				tipsTxtDir = {
					x = -400,
					y = -200
				}
			},
			{
				tipsTxt = 191,
				frame = 0,
				tipsTxtDir = {
					x = 400,
					y = 200
				}
			}
		},
		GVE_FORMATION_NEW = {
			{
				tipsTxt = 188,
				isBigTips = true
			},
			{
				tipsTxt = 189,
				dragY = 200,
				frame = 0,
				dragShow = true,
				dragX = 200,
				tipsTxtDir = {
					x = -500,
					y = 0
				}
			},
			{
				tipsTxt = 191,
				frame = 0,
				tipsTxtDir = {
					x = 400,
					y = 200
				}
			}
		},
		GVE_KILLER_TASK = {
			{
				storyId = 1778
			},
			{
				tipsTxt = 182,
				frame = 0,
				tipsTxtDir = {
					x = -300,
					y = -100
				}
			},
			{
				tipsTxt = 183,
				frame = 0,
				tipsTxtDir = {
					x = -400,
					y = 0
				}
			}
		},
		GVE_RESEARCH_TASK = {
			{
				storyId = 1777
			},
			{
				tipsTxt = 180,
				frame = 0,
				tipsTxtDir = {
					x = -300,
					y = -100
				}
			},
			{
				tipsTxt = 181,
				frame = 0,
				tipsTxtDir = {
					x = -400,
					y = 0
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
				tipsTxt = 200,
				frame = 0,
				tipsTxtDir = {
					x = 400,
					y = -100
				}
			},
			{
				tipsTxt = 201,
				finger = true,
				tipsTxtDir = {
					x = 400,
					y = -100
				}
			},
			{
				tipsTxt = 202,
				tipsTxtDir = {
					x = -400,
					y = -100
				}
			}
		},
		ECHOLAB_ENTER_COLLECT = {
			{
				tipsTxt = 207,
				frame = 0,
				tipsTxtDir = {
					x = 0,
					y = 100
				}
			},
			{
				tipsTxt = 208,
				frame = 0,
				tipsTxtDir = {
					x = -400,
					y = -200
				}
			},
			{
				tipsTxt = 209,
				frame = 0,
				tipsTxtDir = {
					x = -300,
					y = 0
				}
			}
		},
		CS_ARENA_BATTLE_PREPARE = {
			{
				tipsTxt = 219,
				tipsTxtDir = {
					x = 0,
					y = 0
				}
			},
			{
				tipsTxt = 220,
				finger = true,
				tipsTxtDir = {
					x = 240,
					y = -100
				}
			},
			{
				tipsTxt = 221,
				frame = 0,
				tipsTxtDir = {
					x = -400,
					y = -100
				}
			},
			{
				tipsTxt = 222,
				frame = 0,
				tipsTxtDir = {
					x = -250,
					y = 160
				}
			},
			{
				tipsTxt = 228,
				frame = 0,
				tipsTxtDir = {
					x = -200,
					y = -220
				}
			}
		},
		CS_ARENA_BATTLE_ENTER = {
			{
				finger = true,
				tipsTxt = 223,
				frame = 0,
				tipsTxtDir = {
					x = -560,
					y = -100
				},
				fingerDir = {
					x = -100,
					y = 0
				}
			}
		},
		GENE_DRAG_GUIDE = {
			{
				tipsTxt = 215,
				dragY = 105,
				frame = 0,
				dragShow = true,
				dragX = 105,
				tipsTxtDir = {
					x = 100,
					y = -240
				}
			}
		},
		TEAM_PVP_MAIN_LAYER_GUIDE = {
			{
				tipsTxt = 229,
				finger = false,
				tipsTxtDir = {
					x = 50,
					y = -140
				}
			},
			{
				tipsTxt = 230,
				frame = 0,
				finger = false,
				tipsTxtDir = {
					x = -650,
					y = 0
				}
			},
			{
				tipsTxt = 231,
				frame = 0,
				finger = false,
				tipsTxtDir = {
					x = -500,
					y = -200
				}
			},
			{
				event = "TEAM_PVP_GUIDE_VIDEO"
			}
		},
		EXPLORATION_MAIN_LAYER_GUIDE1 = {
			{
				tipsTxt = 236,
				finger = false,
				tipsTxtDir = {
					x = 0,
					y = 0
				}
			},
			{
				tipsTxt = 237,
				frame = 1,
				finger = false,
				tipsTxtDir = {
					x = -650,
					y = 0
				}
			},
			{
				event = "EXPLORATION_GUIDE_MOVE_TO_MIRROR"
			},
			{
				tipsTxt = 238,
				frame = 1,
				finger = false,
				tipsTxtDir = {
					x = 0,
					y = -150
				}
			},
			{
				tipsTxt = 239,
				finger = false,
				tipsTxtDir = {
					x = 0,
					y = -150
				}
			},
			{
				event = "EXPLORATION_GUIDE_POP_MIRROR"
			}
		},
		EXPLORATION_MAIN_LAYER_GUIDE2 = {
			{
				tipsTxt = 240,
				finger = false,
				tipsTxtDir = {
					x = 0,
					y = 0
				}
			},
			{
				event = "EXPLORATION_GUIDE_MOVE_TO_FIRST_MONSTER"
			},
			{
				tipsTxt = 241,
				finger = false,
				tipsTxtDir = {
					x = 0,
					y = 100
				}
			},
			{
				event = "EXPLORATION_GUIDE_MOVE_TO_SHOP"
			},
			{
				tipsTxt = 242,
				frame = 1,
				finger = false,
				tipsTxtDir = {
					x = 0,
					y = 100
				}
			}
		},
		EXPLORATION_SLAVE_GUIDE = {
			{
				tipsTxt = 243,
				frame = 0,
				finger = true,
				tipsTxtDir = {
					x = 100,
					y = -300
				}
			},
			{
				event = "EXPLORATION_OPEN_KNIGHT_BAG"
			}
		},
		RED_CLIFF_APPLY_GUIDE = {
			{
				tipsTxt = 248,
				frame = 0,
				finger = true,
				tipsTxtDir = {
					x = -800,
					y = -300
				}
			}
		},
		RED_CLIFF_APPLY_FAIL_GUIDE = {
			{
				tipsTxt = 249,
				finger = false,
				tipsTxtDir = {
					x = -800,
					y = -300
				}
			}
		},
		BOUNTY_SUMMON_WEEK_GUIDE = {
			{
				tipsTxt = 253,
				frame = 0,
				tipsTxtDir = {
					x = -800,
					y = -300
				}
			},
			{
				event = "BOUNTY_SUMMON_WEEK_GUIDE_END"
			}
		},
		BOUNTY_BTN_WEEK_GUIDE = {
			{
				tipsTxt = 254,
				frame = 0,
				tipsTxtDir = {
					x = 339,
					y = -89
				}
			},
			{
				tipsTxt = 255
			}
		},
		THEME_THIRD_BOSS_GUIDE = {
			{
				tipsTxt = 264,
				frame = 0,
				tipsTxtDir = {
					x = -420,
					y = 10
				}
			},
			{
				tipsTxt = 265,
				frame = 0,
				tipsTxtDir = {
					x = -399,
					y = -89
				}
			}
		},
		RERUN_CHOOSE_AWARD_WEEK_GUIDE = {
			{
				opeType = 0,
				frame = 0,
				tipsTxt = 266,
				tipsTxtDir = {
					x = -339,
					y = 89
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
		GVE_SIGN_UP_STAGE_IN = 1014,
		START = 1000,
		CROSS_SERVER_ARENA1 = 1023,
		WUSH_TOWER_FIRST_USE_CARD = 1019,
		FIRST_RECHARGE_ENTER = 1003,
		MINE_SCORE_CLICKED = 1007,
		EXPLORATION_MAIN_LAYER_GUIDE1 = 1031,
		RED_CLIFF_APPLY_GUIDE = 1034,
		GVE_GRID_DETAIL_ENTER = 1012,
		BOUNTY_SUMMON_WEEK_GUIDE = 1035,
		GVE_FIRST_ENTER_KILL_RESEARCH = 1018,
		RERUN_CHOOSE_AWARD_WEEK_GUIDE = 1038,
		HOME_LAND_HOME_SHOWER = 1002,
		CROSS_FRIEND_1 = 1021,
		RERUN_CHOOSE_AWARD_POP_WEEK_GUIDE = 1039,
		PEAK_ARENA_FIGHT_CLICKED = 1006,
		FOG_IDLE_ENTER = 1009,
		RICH_MAN_FIRST_MONSTER = 1040,
		EXPLORATION_SLAVE_GUIDE = 1033,
		FOG_TALENT_ENTER = 1010,
		RICH_MAN_FIRST_STEAL = 1041,
		NEW_SLG_STEP_GUIDE_S2 = 1043,
		WUSH_AUTO_CHALLENGE_GUIDE = 1044,
		HANDBOOK_GUIDE_1 = 1045,
		PEAK_ARENA_TICK_GUIDE_ID = 16,
		TEAM_PVP_MAIN_LAYER_GUIDE = 1030,
		FIRST_DAILY_COST_ENTER = 1004,
		CROSS_FRIEND_2 = 1022,
		GVE_HALIDOM_ENTER = 1011,
		ECHOLAB_FIRST_ENTER_COLLECT = 1020,
		OUTPOST_WEAK_TICK_GUIDE = 1047,
		CROSS_SERVER_ARENA3 = 1025,
		FIRST_FIGHT_WAR_ENTER = 1005,
		BATTLE_SPEED_ENTERED = 1029,
		ONLINE_GIFT_ENTER = 1008,
		GVE_FORMAL_STAGE_IN = 1015,
		GVE_FIRST_ENTER_GUIDE1 = 1017,
		CROSS_SERVER_ARENA2 = 1024,
		GOLD_SAVING_TICK2 = 1027,
		GVE_BOSS_AVG_PLAY = 1016,
		BOUNTY_BTN_WEEK_GUIDE = 1036,
		GOLD_SAVING_TICK = 1026,
		HOME_LAND_HOME_LIVED = 1001,
		NEW_SLG_STEP_GUIDE = 1042,
		WARR_GUIDE_1 = 1046,
		PHOENIX_GIFT_ENTERED = 1028,
		EXPLORATION_MAIN_LAYER_GUIDE2 = 1032,
		GVE_STORY_PLAYED = 1013,
		THEME_THIRD_BOSS_GUIDE = 1037,
		DOMAIN_CHOOSE_TICK_GUIDE_ID = 49
	},
	SPE_STORY_IDS = {
		ONLINE_GIFT_STORY = 1756
	},
	VALENTINES_DAY_VOTE = {
		FIRST_ENTER = 1764
	}
}
