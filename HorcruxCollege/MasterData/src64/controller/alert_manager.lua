local var_0_0 = {}

require("data.constants")

function var_0_0.dispatch_alert(arg_1_0, arg_1_1)
	print("dispatch_alert is deprecated")
end

function var_0_0.undispatch_alert(arg_2_0, arg_2_1)
	print("undispatch_alert is deprecated")
end

function var_0_0.getSysAlertShowLayer(arg_3_0, arg_3_1)
	print("getSysAlertShowLayer is deprecated")

	return nil
end

function var_0_0.isSystemNewAlert(arg_4_0, arg_4_1)
	print("isSystemNewAlert is deprecated")

	return nil
end

function var_0_0.getMainLayerSystem(arg_5_0, arg_5_1)
	print("getMainLayerSystem is deprecated")

	return nil
end

ALERT_SHOW_REDDOT = 1
ALERT_SHOW_SHINE = 2
ALERT_SHOW_FULL = 3
ALERT_SHOW_NEW = 4
ALERT_SHOW_TWIST_TEN = 5
ALERT_SHOW_UPDOT = 6
ALERT_SHOW_CAN_PATROL = 7
AERT_SHOW_NEW_TOWER = 8

local var_0_1 = {
	{
		name = "alert_new_tower",
		type = AERT_SHOW_NEW_TOWER
	},
	{
		name = "alert_new",
		type = ALERT_SHOW_NEW
	},
	{
		name = "alert_twist_ten",
		type = ALERT_SHOW_TWIST_TEN
	},
	{
		name = "alert_reddot",
		type = ALERT_SHOW_REDDOT
	},
	{
		name = "alert_can_patrol",
		type = ALERT_SHOW_CAN_PATROL
	}
}
local var_0_2 = {
	[ALERT_MARKET] = {
		systemlayer = "MarketLayer",
		showlayer = {
			"MainLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"button_lab",
				cc.p(120, 130)
			}
		}
	},
	[ALERT_MAIL] = {
		systemlayer = "MailLayer",
		showlayer = "MainLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"button_mail",
			cc.p(40, 35)
		}
	},
	[ALERT_SIGN] = {
		systemlayer = "SignLayer",
		showlayer = {
			"MainLayer",
			"ActivityEntranceLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"button_sign",
				cc.p(40, 35)
			},
			{
				ALERT_SHOW_REDDOT,
				"1000003",
				cc.p(455, 690)
			}
		}
	},
	[ALERT_TWISTEGG] = {
		systemlayer = "TwisteggLayer",
		showlayer = {
			"MainLayer",
			"ActivityEntranceLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"button_market",
				cc.p(120, 130)
			},
			{
				ALERT_SHOW_REDDOT,
				"1000005",
				cc.p(455, 690)
			}
		}
	},
	[ALERT_TASK] = {
		systemlayer = "TaskLayer",
		showlayer = "MainLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"button_task",
			cc.p(40, 45)
		}
	},
	[ALERT_TRAVEL] = {
		systemlayer = "DormitoryLayer",
		showlayer = "DormitoryLayer"
	},
	[ALERT_DORM_DR] = {
		systemlayer = "DormitoryLayer",
		showlayer = "DormitoryLayer"
	},
	[ALERT_GO_TRAVEL] = {
		systemlayer = "DormitoryLayer",
		showlayer = "DormitoryLayer"
	},
	[ALERT_TOP_PLOT] = {
		executelayer = "TopcostLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"plotBnt",
			cc.p(54, 27)
		}
	},
	[E_ALERT_OLD_DAILY_TASK] = {
		executelayer = "TopcostLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"plotBnt",
			cc.p(54, 27)
		},
		conditionCheck = function()
			local lua = require("controller.daily_weekly_manager.lua")

			return require("controller.time_check_manager").getCurTime(lua) < lua:getInstance():getOpenTime()
		end
	},
	[E_ALERT_NEW_DAILY_TASK] = {
		executelayer = "TopcostLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"plotBnt",
			cc.p(54, 27)
		},
		conditionCheck = function()
			local lua = require("controller.daily_weekly_manager.lua")

			return require("controller.time_check_manager").getCurTime(lua) >= lua:getInstance():getOpenTime()
		end
	},
	[ALERT_BAG] = {
		executelayer = "ListButtonLayer",
		showlayer = {},
		showconfig = {}
	},
	[ALERT_TRAIN] = {
		systemlayer = "SchoolTrainLayer",
		showlayer = "SchoolAreaLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"btn_trainRoomTips",
			cc.p(180, 60)
		}
	},
	[ALERT_SWIMMING] = {
		systemlayer = "SchoolAreaLayer",
		showlayer = "SchoolAreaLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"Image_swimmingRoomTips",
			cc.p(180, 60)
		}
	},
	[ALERT_LAB] = {
		systemlayer = "LabMenuLayer",
		showlayer = {
			"SchoolAreaLayer",
			"MainLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"btn_labRoomTips",
				cc.p(180, 60)
			}
		}
	},
	[ALERT_MIDAS] = {
		systemlayer = "HandOfMidasLayer",
		showlayer = "ActivityEntranceLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"1000008",
			cc.p(455, 690)
		}
	},
	[ALERT_STRENGTHEN] = {
		systemlayer = "FightLayer",
		showlayer = "FightLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"btn_strength",
			cc.p(55, 65)
		}
	},
	[ALERT_TWIST_TEN] = {
		systemlayer = "TwisteggLayer",
		showlayer = "MainLayer",
		showconfig = {
			ALERT_SHOW_TWIST_TEN,
			"button_market",
			cc.p(120, 130)
		}
	},
	[ALERT_ACTIVTIY_NEW_LOG] = {
		executelayer = "MainLayer",
		showlayer = "MainLayer",
		showconfig = {
			ALERT_SHOW_NEW,
			"button_activity",
			cc.p(120, 120)
		}
	},
	[ALERT_ACTIVTIYNEWLOG_TWISTEGG] = {
		systemlayer = "TwisteggLayer",
		showlayer = {
			"MainLayer",
			"ActivityEntranceLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_NEW,
				"button_market",
				cc.p(120, 130)
			},
			{
				ALERT_SHOW_NEW,
				"1000005",
				cc.p(600, 260)
			}
		}
	},
	[ALERT_NEW_HORCRUX] = {
		executelayer = "ListButtonLayer",
		listbuttonswitchtag = 1,
		showlayer = {
			"FightLayer",
			"WareHouseListBottonLayer",
			"GirlSelectLayer",
			"AdventureLayer",
			"MainLayer",
			"DormitoryLayer",
			"SchoolAreaLayer",
			"ActivityEntranceLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_NEW,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn3",
				cc.p(80, 60)
			}
		}
	},
	[ALERT_NEW_SERVANT] = {
		executelayer = "ListButtonLayer",
		listbuttonswitchtag = 1,
		showlayer = {
			"FightLayer",
			"WareHouseListBottonLayer",
			"AdventureLayer",
			"GirlSelectLayer",
			"HorcruxLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_NEW,
				"select_btn2",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn2",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn2",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn2",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn2",
				cc.p(80, 60)
			}
		}
	},
	[ALERT_NEW_MARKET] = {
		showlayer = "MainLayer",
		showconfig = {
			ALERT_SHOW_NEW,
			"button_lab",
			cc.p(120, 130)
		}
	},
	[ALERT_PATROL] = {
		showlayer = "FightLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"btn_map",
			cc.p(50, 60),
			nil,
			1
		}
	},
	[ALERT_NEW_TWIST] = {
		systemlayer = "TwisteggLayer",
		showlayer = "MainLayer",
		showconfig = {
			ALERT_SHOW_NEW,
			"button_market",
			cc.p(120, 130)
		}
	},
	[ALERT_STRENGTHEN_HORCRUX] = {
		executelayer = "ListButtonLayer",
		showlayer = {
			"FightLayer",
			"WareHouseListBottonLayer",
			"AdventureLayer",
			"GirlSelectLayer",
			"ActivityEntranceLayer",
			"MainLayer",
			"SchoolAreaLayer",
			"DormitoryLayer",
			"HorcruxLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			}
		}
	},
	[ALERT_SCHOOL] = {
		executelayer = "ListButtonLayer",
		listbuttonswitchtag = 0,
		showlayer = {
			"MainLayer",
			"DormitoryLayer",
			"WareHouseListBottonLayer",
			"HorcruxLayer",
			"ActivityEntranceLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			}
		}
	},
	[ALERT_NEW_CHANGEENTER_SCROCE] = {
		executelayer = "ListButtonLayer",
		systemlayer = "AdventureLayer",
		showlayer = {
			"AdventureLayer",
			"CompetitionLayer",
			"AdventureLayer",
			"FightLayer",
			"WareHouseListBottonLayer",
			"AdventureLayer",
			"GirlSelectLayer",
			"HorcruxLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_NEW,
				"btn_ScoreArenaLayer",
				cc.p(580, 280)
			},
			{
				ALERT_SHOW_NEW,
				"btn_ScoreArenaLayer",
				cc.p(580, 230)
			},
			{
				ALERT_SHOW_NEW,
				"btn_CompetitionLayer",
				cc.p(580, 200)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			}
		},
		unlocklevel = UNLOCK_SCOREARENA
	},
	[ALERT_NEW_CHANGEENTER_AREAN] = {
		executelayer = "ListButtonLayer",
		systemlayer = "AdventureLayer",
		listbuttonswitchtag = 1,
		showlayer = {
			"AdventureLayer",
			"CompetitionLayer",
			"AdventureLayer",
			"FightLayer",
			"WareHouseListBottonLayer",
			"AdventureLayer",
			"GirlSelectLayer",
			"HorcruxLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_NEW,
				"btn_ArenaLayer",
				cc.p(580, 280)
			},
			{
				ALERT_SHOW_NEW,
				"btn_ArenaLayer",
				cc.p(580, 230)
			},
			{
				ALERT_SHOW_NEW,
				"btn_CompetitionLayer",
				cc.p(580, 200)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			}
		},
		unlocklevel = UNLOCK_ARENA
	},
	[ALERT_NEW_CHANGEENTER_ADE1] = {
		systemlayer = "AdventureLayer",
		showlayer = {
			"AdventureLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_NEW,
				"btn_WeekendAdventureLayer",
				cc.p(580, 200)
			}
		}
	},
	[ALERT_NEW_CHANGEENTER_ADE2] = {
		systemlayer = "AdventureLayer",
		showlayer = {
			"AdventureLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_NEW,
				"btn_WeekendAdventureLayer",
				cc.p(580, 200)
			}
		}
	},
	[ALERT_NEW_CHANGEENTER_ADE3] = {
		systemlayer = "AdventureLayer",
		showlayer = {
			"AdventureLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_NEW,
				"btn_WeekendAdventureLayer",
				cc.p(580, 200)
			}
		}
	},
	[ALERT_NEW_CHANGING] = {
		executelayer = "ListButtonLayer",
		systemlayer = "AdventureLayer",
		listbuttonswitchtag = 1,
		showlayer = {
			"FightLayer",
			"WareHouseListBottonLayer",
			"AdventureLayer",
			"GirlSelectLayer",
			"HorcruxLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_NEW,
				"select_btn4",
				cc.p(80, 60)
			}
		},
		unlocklevel = UNLOCK_AD
	},
	[ALERT_RED_CHANGING] = {
		systemlayer = "AdventureLayer",
		executelayer = "ListButtonLayer",
		listbuttonswitchtag = 1,
		showlayer = {
			"FightLayer",
			"WareHouseListBottonLayer",
			"AdventureLayer",
			"GirlSelectLayer",
			"HorcruxLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn4",
				cc.p(80, 60)
			}
		}
	},
	[ALERT_NEW_CITY] = {
		showlayer = {
			"FightLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_NEW,
				"btn_map",
				cc.p(50, 60)
			}
		}
	},
	[ALERT_NEW_EVENT] = {
		systemlayer = "PatrolFightLayer",
		showlayer = {
			"FightLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"patrolPopBnt",
				cc.p(20, 75)
			}
		}
	},
	[ALERT_PATROL_FIGHT] = {
		systemlayer = "PatrolFightLayer",
		showlayer = "FightLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"patrolPopBnt",
			cc.p(20, 140)
		}
	},
	[ALERT_STAR_REWARD] = {
		showlayer = "FightLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"btn_map",
			cc.p(50, 60)
		}
	},
	[ALERT_BATTLE_PASS] = {
		showlayer = "MainLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"button_battle_pass",
			cc.p(40, 40)
		}
	},
	[ALERT_BATTLE_PASS_TASK] = {
		showlayer = {
			"MainLayer",
			"BattlePassLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"button_battle_pass",
				cc.p(40, 40)
			},
			{
				ALERT_SHOW_REDDOT,
				"btn_jump_to",
				cc.p(170, 60)
			}
		}
	},
	[ALERT_NEW_SHOP_WITH_TWIST] = {
		showlayer = "MainLayer",
		showconfig = {
			ALERT_SHOW_NEW,
			"button_market",
			cc.p(120, 130)
		}
	},
	[E_ALERT_ARENATFT_DAILYAWARDS] = {
		showlayer = {
			"CompetitionLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"btn_ThreeVsThreeLayer",
				cc.p(580, 230)
			}
		}
	},
	[ALERT_SUPERMARKET_NEW] = {
		showlayer = "MainLayer",
		showconfig = {
			ALERT_SHOW_NEW,
			"button_recharge",
			cc.p(110, 110)
		}
	},
	[ALERT_SUPERMARKET_FREE] = {
		showlayer = "MainLayer",
		showconfig = {
			ALERT_SHOW_REDDOT,
			"button_recharge",
			cc.p(110, 110)
		}
	},
	[ALERT_RED_COMMITY] = {
		systemlayer = "CommunityMainLayer",
		showlayer = {
			"SchoolAreaLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"btn_community",
				cc.p(180, 60)
			}
		}
	},
	[ALERT_RED_ACTIVITY] = {
		executelayer = "ListButtonLayer",
		listbuttonswitchtag = 0,
		showlayer = {
			"MainLayer",
			"SchoolAreaLayer",
			"DormitoryLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn4",
				cc.p(80, 60)
			}
		}
	},
	[ALERT_BOND] = {
		listbuttonswitchtag = 0,
		showlayer = {
			"MainLayer",
			"DormitoryLayer",
			"WareHouseListBottonLayer",
			"ActivityEntranceLayer",
			"SchoolAreaLayer",
			"SchoolFileLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"select_btn3",
				cc.p(80, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"btn_fileRoomTips",
				cc.p(180, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"toggle5",
				cc.p(88, 45)
			}
		}
	},
	[ALERT_ORDER_NEW] = {
		systemlayer = "LabMenuLayer",
		showlayer = {
			"FightLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_NEW,
				"patrolPopBnt",
				cc.p(20, 75)
			}
		}
	},
	[ALERT_ORDER] = {
		systemlayer = "SchoolOrderLayer",
		showlayer = {
			"FightLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"patrolPopBnt",
				cc.p(20, 75)
			}
		}
	},
	[E_ALTER_LEVEL_ADVENTURE] = {
		executelayer = "ListButtonLayer",
		systemlayer = "AdventureLayer",
		listbuttonswitchtag = 1,
		showlayer = {
			"FightLayer",
			"WareHouseListBottonLayer",
			"AdventureLayer",
			"GirlSelectLayer",
			"HorcruxLayer"
		},
		showconfig = {
			{
				AERT_SHOW_NEW_TOWER,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				AERT_SHOW_NEW_TOWER,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				AERT_SHOW_NEW_TOWER,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				AERT_SHOW_NEW_TOWER,
				"select_btn4",
				cc.p(80, 60)
			},
			{
				AERT_SHOW_NEW_TOWER,
				"select_btn4",
				cc.p(80, 60)
			}
		},
		unlocklevel = UNLOCK_AD
	},
	[E_ALERT_ONLINE_REWARD] = {
		showlayer = {
			"FightLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"btn_onlinereward",
				cc.p(70, 80)
			}
		}
	},
	[ALERT_AFK_LEVEL] = {
		systemlayer = "AfkLevelLayer",
		showlayer = {
			"GirlSelectLayer",
			"SchoolAreaLayer"
		},
		showconfig = {
			{
				ALERT_SHOW_REDDOT,
				"afkLVBtn",
				cc.p(290, 60)
			},
			{
				ALERT_SHOW_REDDOT,
				"btn_afkLevel",
				cc.p(210, 80)
			}
		}
	}
}
local var_0_3 = {
	MainLayer = {
		ALERT_BATTLE_PASS_TASK,
		ALERT_BATTLE_PASS,
		ALERT_NEW_MARKET,
		ALERT_MARKET,
		ALERT_MAIL,
		ALERT_SIGN,
		ALERT_TASK,
		ALERT_TWISTEGG,
		ALERT_TWIST_TEN,
		ALERT_ACTIVTIY_NEW_LOG,
		ALERT_SUPERMARKET_FREE,
		ALERT_SUPERMARKET_NEW,
		ALERT_ACTIVTIYNEWLOG_TWISTEGG,
		ALERT_NEW_TWIST,
		ALERT_NEW_NOTICE,
		ALERT_NEW_SHOP_WITH_TWIST,
		ALERT_BOND,
		ALERT_RED_ACTIVITY
	},
	ActivityEntranceLayer = {
		ALERT_SIGN,
		ALERT_MIDAS,
		ALERT_TWISTEGG,
		ALERT_FIRST_RECHARGE,
		ALERT_RED_ACTIVITY,
		ALERT_SCHOOL
	},
	FightLayer = {
		ALERT_STRENGTHEN,
		ALERT_ORDER,
		ALERT_PATROL,
		ALERT_NEW_MODE,
		ALERT_NEW_CHAPTER,
		ALERT_NEW_CITY,
		ALERT_NEW_EVENT,
		ALERT_PATROL_FIGHT,
		ALERT_STAR_REWARD
	},
	SchoolAreaLayer = {
		ALERT_LAB,
		ALERT_SWIMMING,
		ALERT_TRAIN,
		ALERT_BOND,
		ALERT_AFK_LEVEL,
		ALERT_RED_COMMITY
	},
	AdventureLayer = {
		ALERT_NEW_CHANGEENTER_SCROCE,
		ALERT_NEW_CHANGEENTER_AREAN,
		ALERT_NEW_CHANGEENTER_ADE1,
		ALERT_NEW_CHANGEENTER_ADE2,
		ALERT_NEW_CHANGEENTER_ADE3,
		ALERT_NEW_CHANGEENTER_SCROCE,
		ALERT_NEW_CHANGEENTER_AREAN
	},
	CompetitionLayer = {
		ALERT_NEW_CHANGEENTER_SCROCE,
		ALERT_NEW_CHANGEENTER_AREAN
	},
	BattlePassLayer = {
		ALERT_BATTLE_PASS_TASK
	},
	SchoolFileLayer = {
		ALERT_BOND
	},
	GirlSelectLayer = {
		ALERT_AFK_LEVEL
	}
}
local var_0_4 = {
	FightLayer = {
		E_ALTER_LEVEL_ADVENTURE,
		ALERT_SERVANT_UPDATE,
		ALERT_NEW_HORCRUX,
		ALERT_NEW_SERVANT,
		ALERT_BAG,
		ALERT_STRENGTHEN_HORCRUX,
		ALERT_NEW_CHANGING,
		ALERT_RED_CHANGING,
		ALERT_NEW_CHANGEENTER_AREAN,
		ALERT_NEW_CHANGEENTER_SCROCE
	},
	WareHouseListBottonLayer = {
		E_ALTER_LEVEL_ADVENTURE,
		ALERT_SERVANT_UPDATE,
		ALERT_NEW_SERVANT,
		ALERT_SCHOOL,
		ALERT_NEW_CHANGING,
		ALERT_RED_CHANGING,
		ALERT_NEW_HORCRUX,
		ALERT_NEW_CHANGEENTER_AREAN,
		ALERT_NEW_CHANGEENTER_SCROCE
	},
	HorcruxLayer = {
		E_ALTER_LEVEL_ADVENTURE,
		ALERT_SERVANT_UPDATE,
		ALERT_NEW_SERVANT,
		ALERT_SCHOOL,
		ALERT_NEW_CHANGING,
		ALERT_RED_CHANGING,
		ALERT_NEW_CHANGEENTER_AREAN,
		ALERT_NEW_CHANGEENTER_SCROCE
	},
	GirlSelectLayer = {
		E_ALTER_LEVEL_ADVENTURE,
		ALERT_NEW_HORCRUX,
		ALERT_BAG,
		ALERT_NEW_SERVANT,
		ALERT_STRENGTHEN_HORCRUX,
		ALERT_NEW_CHANGING,
		ALERT_RED_CHANGING,
		ALERT_NEW_CHANGEENTER_AREAN,
		ALERT_NEW_CHANGEENTER_SCROCE
	},
	AdventureLayer = {
		ALERT_SERVANT_UPDATE,
		ALERT_NEW_SERVANT,
		ALERT_BAG,
		ALERT_NEW_HORCRUX,
		ALERT_STRENGTHEN_HORCRUX
	},
	MainLayer = {
		ALERT_BAG,
		ALERT_SCHOOL,
		ALERT_NEW_HORCRUX,
		ALERT_RED_ACTIVITY,
		ALERT_DORMITORY_FAVOUR,
		ALERT_CLOTHES_REWRAD,
		ALERT_RED_COMMITY
	},
	DormitoryLayer = {
		ALERT_BAG,
		ALERT_SCHOOL,
		ALERT_NEW_HORCRUX,
		ALERT_STRENGTHEN_HORCRUX,
		ALERT_DORMITORY_FAVOUR,
		ALERT_CLOTHES_REWRAD
	},
	SchoolAreaLayer = {
		ALERT_BAG,
		ALERT_NEW_HORCRUX,
		ALERT_STRENGTHEN_HORCRUX,
		ALERT_RED_COMMITY,
		ALERT_DORMITORY_FAVOUR,
		ALERT_CLOTHES_REWRAD,
		ALERT_RED_ACTIVITY
	},
	ActivityEntranceLayer = {
		ALERT_SIGN,
		ALERT_MIDAS,
		ALERT_TWISTEGG,
		ALERT_FIRST_RECHARGE,
		ALERT_RED_ACTIVITY,
		ALERT_SCHOOL
	}
}

function var_0_0.add_shine(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 then
		return
	end

	if arg_8_2 then
		if not arg_8_1.alert_shine then
			arg_8_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.8, 100), cc.FadeTo:create(0.8, 255), cc.DelayTime:create(0.4))))

			arg_8_1.alert_shine = true

			if config._DEBUG then
				redDot = cc.Sprite:create("public/reddot/reddot2.png") or cc.Sprite:createWithSpriteFrameName("public/reddot/reddot2.png")
			end

			redDot:setName("alert_shine")

			pos = pos or LISTBUTTON_THIRD

			redDot:setPosition(pos)

			if rotate then
				redDot:runAction(cc.RotateTo:create(0, rotate))
			end

			arg_8_1:addChild(redDot)
		end
	elseif arg_8_1.alert_shine then
		arg_8_1:stopAllActions()
		arg_8_1:setOpacity(255)

		arg_8_1.alert_shine = false

		arg_8_1:getChildByName("alert_shine"):removeFromParent()
	end
end

local var_0_5 = {
	button_market = cc.p(20, 115),
	button_lab = cc.p(10, 90),
	button_adventure = cc.p(0, 70),
	button_twist = cc.p(30, 90),
	button_favor = cc.p(10, 95),
	button_main = cc.p(10, 65),
	button_equ = cc.p(40, 55),
	button_fight = cc.p(10, 65),
	button_task = cc.p(50, 55),
	button_bag = cc.p(125, 65)
}

function var_0_0.add_redDot(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_1:getChildByName("alert_reddot")

	if arg_9_2 then
		if not var_9_0 then
			var_9_0 = arg_9_5 and (arg_9_6 and cc.Sprite:createWithSpriteFrameName(arg_9_5) or cc.Sprite:create(arg_9_5)) or config._DEBUG and cc.Sprite:create("public/reddot/reddot2.png") or cc.Sprite:createWithSpriteFrameName("public/reddot/reddot2.png")

			var_9_0:setName("alert_reddot")

			arg_9_3 = arg_9_3 or LISTBUTTON

			var_9_0:setPosition(arg_9_3)

			if arg_9_4 then
				var_9_0:runAction(cc.RotateTo:create(0, arg_9_4))
			end

			arg_9_1:addChild(var_9_0)
		end

		var_9_0:setVisible(true)
	elseif var_9_0 then
		var_9_0:removeFromParent()
	end
end

function var_0_0.add_upDot(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not arg_10_1 then
		return
	end

	local var_10_0 = arg_10_1:getChildByName("alert_reddot")

	if arg_10_2 then
		if not var_10_0 then
			var_10_0 = config._DEBUG and cc.Sprite:create("public/reddot/up.png") or cc.Sprite:createWithSpriteFrameName("public/reddot/up.png")

			var_10_0:setName("alert_reddot")

			arg_10_3 = arg_10_3 or LISTBUTTON

			var_10_0:setPosition(arg_10_3)

			if arg_10_4 then
				var_10_0:runAction(cc.RotateTo:create(0, arg_10_4))
			end

			arg_10_1:addChild(var_10_0)
		end
	elseif var_10_0 then
		var_10_0:removeFromParent()
	end
end

function var_0_0.add_yellowDot(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if not arg_11_1 then
		return
	end

	local var_11_0 = arg_11_1:getChildByName("alert_reddot")

	if arg_11_2 then
		if not var_11_0 then
			var_11_0 = config._DEBUG and cc.Sprite:create("public/reddot/reddot_y.png") or cc.Sprite:createWithSpriteFrameName("public/reddot/reddot_y.png")

			var_11_0:setName("alert_reddot")

			arg_11_3 = arg_11_3 or LISTBUTTON

			var_11_0:setPosition(arg_11_3)

			if arg_11_4 then
				var_11_0:runAction(cc.RotateTo:create(0, arg_11_4))
			end

			arg_11_1:addChild(var_11_0)
		end
	elseif var_11_0 then
		var_11_0:removeFromParent()
	end
end

function var_0_0.add_fullTag(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_1:getChildByName("fulltag")

	if arg_12_2 then
		if not var_12_0 then
			var_12_0 = config._DEBUG and cc.Sprite:create("public/reddot/reddot2.png") or cc.Sprite:createWithSpriteFrameName("public/reddot/reddot2.png")

			var_12_0:setName("fulltag")

			arg_12_3 = arg_12_3 or var_0_5.button_bag

			var_12_0:setPosition(arg_12_3)

			if arg_12_4 then
				arg_12_4:runAction(cc.RotateTo:create(0, arg_12_4))
			end

			arg_12_1:addChild(var_12_0)
		end
	elseif var_12_0 then
		var_12_0:removeFromParent()
	end
end

function var_0_0.add_new_mark(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	if not arg_13_1 then
		return
	end

	local var_13_0 = arg_13_1:getChildByName("alert_new")

	if arg_13_2 then
		if not var_13_0 then
			var_13_0 = arg_13_5 and (arg_13_6 and cc.Sprite:createWithSpriteFrameName(arg_13_5) or cc.Sprite:create(arg_13_5)) or config._DEBUG and cc.Sprite:create("public/reddot/reddot0.png") or cc.Sprite:createWithSpriteFrameName("public/reddot/reddot0.png")

			var_13_0:setName("alert_new")

			arg_13_3 = arg_13_3 or LISTBUTTON

			var_13_0:setPosition(arg_13_3)

			if arg_13_4 then
				var_13_0:runAction(cc.RotateTo:create(0, arg_13_4))
			end

			arg_13_1:addChild(var_13_0)
			var_13_0:setLocalZOrder(999)
		end
	elseif var_13_0 then
		var_13_0:removeFromParent()
	end
end

function var_0_0.add_new_tower_mark(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	if not arg_14_1 then
		return
	end

	local var_14_0 = arg_14_1:getChildByName("alert_new_tower")

	if arg_14_2 then
		if not var_14_0 then
			var_14_0 = arg_14_5 and (arg_14_6 and cc.Sprite:createWithSpriteFrameName(arg_14_5) or cc.Sprite:create(arg_14_5)) or config._DEBUG and cc.Sprite:create("public/reddot/newTower.png") or cc.Sprite:createWithSpriteFrameName("public/reddot/newTower.png")

			var_14_0:setName("alert_new_tower")

			arg_14_3 = arg_14_3 or LISTBUTTON

			var_14_0:setPosition(arg_14_3)

			if arg_14_4 then
				var_14_0:runAction(cc.RotateTo:create(0, arg_14_4))
			end

			arg_14_1:addChild(var_14_0)
			var_14_0:setLocalZOrder(999)
		end
	elseif var_14_0 then
		var_14_0:removeFromParent()
	end
end

function var_0_0.add_twist_ten_remind(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if not arg_15_1 then
		return
	end

	local var_15_0 = arg_15_1:getChildByName("alert_twist_ten")

	if arg_15_2 then
		if not var_15_0 then
			var_15_0 = config._DEBUG and cc.Sprite:create("public/reddot/reddot_twist.png") or cc.Sprite:createWithSpriteFrameName("public/reddot/reddot_twist.png")

			var_15_0:setName("alert_twist_ten")

			arg_15_3 = arg_15_3 or LISTBUTTON

			var_15_0:setPosition(arg_15_3)

			if arg_15_4 then
				var_15_0:runAction(cc.RotateTo:create(0, arg_15_4))
			end

			arg_15_1:addChild(var_15_0)
		end
	elseif var_15_0 then
		var_15_0:removeFromParent()
	end
end

function var_0_0.add_can_patrol_remind(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	if not arg_16_1 then
		return
	end

	local var_16_0 = arg_16_1:getChildByName("alert_can_patrol")

	if arg_16_2 then
		if not var_16_0 then
			var_16_0 = arg_16_5 and (arg_16_6 and cc.Sprite:createWithSpriteFrameName(arg_16_5) or cc.Sprite:create(arg_16_5)) or config._DEBUG and cc.Sprite:create("public/reddot/can_patrol.png") or cc.Sprite:createWithSpriteFrameName("public/reddot/can_patrol.png")

			var_16_0:setName("alert_can_patrol")

			arg_16_3 = arg_16_3 or LISTBUTTON

			var_16_0:setPosition(arg_16_3)

			if arg_16_4 then
				var_16_0:runAction(cc.RotateTo:create(0, arg_16_4))
			end

			arg_16_1:addChild(var_16_0)
		end
	elseif var_16_0 then
		var_16_0:removeFromParent()
	end
end

function var_0_0.update_alert_zorder(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(var_0_1) do
		if arg_17_1:getChildByName(iter_17_1.name) then
			arg_17_1:getChildByName(iter_17_1.name):setVisible(true)
		end
	end
end

function var_0_0.add_alert(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	print("add_alert is deprecated, please use add_alert_by_config")
end

function var_0_0:add_alert_by_config(arg_19_1, arg_19_2, arg_19_3)
	if not arg_19_1 then
		return
	end

	if type(arg_19_3[1]) == "number" then
		local var_19_0 = arg_19_3[3] or cc.p(arg_19_1:getContentSize().width * 3 / 4, arg_19_1:getContentSize().height)

		if arg_19_3[1] == AERT_SHOW_NEW_TOWER then
			self:add_new_tower_mark(arg_19_1, arg_19_2, var_19_0, nil, arg_19_3[4])
		elseif arg_19_3[1] == ALERT_SHOW_REDDOT then
			self:add_redDot(arg_19_1, arg_19_2, var_19_0, nil, arg_19_3[4], arg_19_3[5])
		elseif arg_19_3[1] == ALERT_SHOW_UPDOT then
			self:add_upDot(arg_19_1, arg_19_2, var_19_0)
		elseif arg_19_3[1] == ALERT_SHOW_FULL then
			self:add_fullTag(arg_19_1, arg_19_2, var_19_0)
		elseif arg_19_3[1] == ALERT_SHOW_SHINE then
			self:add_shine(arg_19_1, arg_19_2, var_19_0)
		elseif arg_19_3[1] == ALERT_SHOW_NEW then
			self:add_new_mark(arg_19_1, arg_19_2, var_19_0, nil, arg_19_3[4])
		elseif arg_19_3[1] == ALERT_SHOW_TWIST_TEN then
			self:add_twist_ten_remind(arg_19_1, arg_19_2, var_19_0)
		elseif arg_19_3[1] == ALERT_SHOW_CAN_PATROL then
			self:add_can_patrol_remind(arg_19_1, arg_19_2, var_19_0, nil, arg_19_3[4], arg_19_3[5])
		end
	elseif type(arg_19_3[1]) == "function" then
		arg_19_3[1](arg_19_1, arg_19_2)
	end

	self:update_alert_zorder(arg_19_1)
end

function var_0_0.remove_all_alert(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1:getChildByName("alert_reddot")

	if var_20_0 then
		var_20_0:removeFromParent()
	end

	local var_20_1 = arg_20_1:getChildByName("alert_new_tower")

	if var_20_1 then
		var_20_1:removeFromParent()
	end

	local var_20_2 = arg_20_1:getChildByName("fulltag")

	if var_20_2 then
		var_20_2:removeFromParent()
	end

	local var_20_3 = arg_20_1:getChildByName("alert_shine")

	if var_20_3 then
		var_20_3:removeFromParent()
	end

	local var_20_4 = arg_20_1:getChildByName("alert_new")

	if var_20_4 then
		var_20_4:removeFromParent()
	end

	local var_20_5 = arg_20_1:getChildByName("alert_twist_ten")

	if var_20_5 then
		var_20_5:removeFromParent()
	end

	local var_20_6 = arg_20_1:getChildByName("alert_can_patrol")

	if var_20_6 then
		var_20_6:removeFromParent()
	end
end

var_0_0.alertsys = {}

local function var_0_6(arg_21_0, arg_21_1)
	local function var_21_0(arg_22_0)
		if not arg_22_0 then
			return
		end

		if type(arg_22_0) == "table" then
			for iter_22_0, iter_22_1 in pairs(arg_22_0) do
				local var_22_0 = var_21_0(iter_22_1)

				if var_22_0 then
					return var_22_0
				end
			end

			return nil
		elseif arg_22_0:getName() == arg_21_1 then
			return arg_22_0
		else
			return var_21_0(arg_22_0:getChildren())
		end
	end

	return var_21_0(arg_21_0)
end

function var_0_0:init_system_alert(arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	if not arg_23_4 then
		if not global_basic_scene then
			return
		end

		if LayerManager:getActiveLayerName() ~= arg_23_2 then
			return
		end

		if arg_23_3 and not LayerManager:getLayerUnlockStat(arg_23_3) then
			return
		end

		local var_23_0 = LayerManager:getActiveLayerObj()

		if var_23_0.updateAlert then
			var_23_0:updateAlert(arg_23_1)
		end
	else
		if self.alertsys[arg_23_1] then
			return
		end

		self.alertsys[arg_23_1] = true

		if not global_basic_scene then
			return
		end

		if arg_23_3 and not LayerManager:getLayerUnlockStat(arg_23_3) then
			return
		end

		if LayerManager:getActiveLayerName() == arg_23_2 then
			if arg_23_5 == "ListButtonLayer" then
				if var_0_2[arg_23_1].listbuttonswitchtag then
					if var_0_2[arg_23_1].listbuttonswitchtag == LayerManager:getUIElement("ListButton"):getListButtonSwitchTag() then
						local var_23_1 = var_0_6(LayerManager:getUIElement("ListButton"), arg_23_4[2])

						if var_23_1 then
							self:add_alert_by_config(var_23_1, true, arg_23_4)
						end

						goto label_23_0
					end
				end
			end

			local var_23_2 = var_0_6(LayerManager:getActiveLayerObj(), arg_23_4[2])

			if var_23_2 then
				self:add_alert_by_config(var_23_2, true, arg_23_4)
			end
		end
	end

	::label_23_0::
end

function var_0_0:remove_system_alert(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if not arg_24_3 then
		if not global_basic_scene then
			return
		end

		if LayerManager:getActiveLayerName() ~= arg_24_2 then
			return
		end

		if LayerManager:getActiveLayerObj().removeAlert then
			LayerManager:getActiveLayerObj():removeAlert(arg_24_1)
		end
	else
		if not global_basic_scene then
			return
		end

		if LayerManager:getActiveLayerName() == arg_24_2 then
			if arg_24_4 == "ListButtonLayer" then
				local var_24_0 = var_0_6(LayerManager:getUIElement("ListButton"), arg_24_3[2])

				if var_24_0 then
					self:add_alert_by_config(var_24_0, false, arg_24_3)
				end
			else
				local var_24_1 = var_0_6(LayerManager:getActiveLayerObj(), arg_24_3[2])

				if var_24_1 then
					self:add_alert_by_config(var_24_1, false, arg_24_3)
				end
			end
		elseif LayerManager:isShowPopLayer() and LayerManager:isShowPopLayerWithLayerName(arg_24_2) then
			local var_24_2 = var_0_6(LayerManager:getPopLayerWithLayerName(arg_24_2), arg_24_3[2])

			print(arg_24_3[2], var_24_2)

			if var_24_2 then
				self:add_alert_by_config(var_24_2, false, arg_24_3)
			end
		end
	end
end

local function var_0_7(arg_25_0, arg_25_1)
	if not arg_25_0 then
		return nil
	end

	if type(arg_25_0) == "table" then
		return arg_25_0[arg_25_1]
	else
		return arg_25_0
	end
end

function var_0_0:register_alert(arg_26_1)
	if not var_0_2[arg_26_1] then
		return
	end

	if var_0_2[arg_26_1].executelayer == "TopcostLayer" and var_0_2[arg_26_1].conditionCheck and not var_0_2[arg_26_1].conditionCheck() then
		return
	end

	if var_0_2[arg_26_1].executelayer == "TopcostLayer" then
		self.alertsys[arg_26_1] = true

		if not global_basic_scene then
			return
		end

		self:add_alert_by_config(var_0_6(LayerManager:getUIElement("TopcostLayer"), var_0_2[arg_26_1].showconfig[2]), true, var_0_2[arg_26_1].showconfig)
	end

	if type(var_0_2[arg_26_1].showlayer) ~= "table" then
		self:init_system_alert(arg_26_1, var_0_2[arg_26_1].showlayer, var_0_2[arg_26_1].systemlayer, var_0_2[arg_26_1].showconfig, var_0_2[arg_26_1].executelayer)
	else
		for iter_26_0, iter_26_1 in pairs(var_0_2[arg_26_1].showlayer) do
			self:init_system_alert(arg_26_1, iter_26_1, var_0_2[arg_26_1].systemlayer, var_0_2[arg_26_1].showconfig[iter_26_0], var_0_7(var_0_2[arg_26_1].executelayer, iter_26_0))
		end
	end
end

function var_0_0:unregister_alert(arg_27_1, arg_27_2)
	if not self.alertsys[arg_27_1] then
		return
	end

	self.alertsys[arg_27_1] = nil

	if not var_0_2[arg_27_1] then
		return
	end

	if var_0_2[arg_27_1].executelayer == "TopcostLayer" then
		if not global_basic_scene then
			return
		end

		self:remove_all_alert((var_0_6(LayerManager:getUIElement("TopcostLayer"), var_0_2[arg_27_1].showconfig[2])))
	end

	if not arg_27_2 then
		return
	end

	local var_27_0 = LayerManager:getActiveLayerName()

	if type(var_0_2[arg_27_1].showlayer) ~= "table" then
		if var_27_0 == var_0_2[arg_27_1].showlayer then
			self:remove_system_alert(arg_27_1, var_0_2[arg_27_1].showlayer, var_0_2[arg_27_1].showconfig, var_0_2[arg_27_1].executelayer)
		end
	else
		for iter_27_0, iter_27_1 in pairs(var_0_2[arg_27_1].showlayer) do
			if iter_27_1 == var_27_0 then
				self:remove_system_alert(arg_27_1, iter_27_1, var_0_2[arg_27_1].showconfig[iter_27_0], var_0_7(var_0_2[arg_27_1].executelayer, iter_27_0))
			end
		end
	end

	if LayerManager:isShowPopLayer() then
		if type(var_0_2[arg_27_1].showlayer) ~= "table" then
			if LayerManager:isShowPopLayerWithLayerName(var_0_2[arg_27_1].showlayer) then
				self:remove_system_alert(arg_27_1, var_0_2[arg_27_1].showlayer, var_0_2[arg_27_1].showconfig, var_0_2[arg_27_1].executelayer)
			end
		else
			for iter_27_2, iter_27_3 in pairs(var_0_2[arg_27_1].showlayer) do
				if LayerManager:isShowPopLayerWithLayerName(iter_27_3) then
					self:remove_system_alert(arg_27_1, iter_27_3, var_0_2[arg_27_1].showconfig[iter_27_2], var_0_7(var_0_2[arg_27_1].executelayer, iter_27_2))
				end
			end
		end
	end

	cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("alertmanager_unregister_alert")))
end

function var_0_0.clean_all_alert(arg_28_0)
	arg_28_0.alertsys = {}
end

function var_0_0:check_current_alert(arg_29_1)
	print(dump(self.alertsys))

	if not var_0_3[arg_29_1] then
		return
	end

	local var_29_0 = LayerManager:getActiveLayerObj()

	self:check_schoolArea_alert()

	if arg_29_1 == "FightLayer" then
		for iter_29_0, iter_29_1 in pairs(var_0_3[arg_29_1]) do
			local var_29_1 = self:get_alert_config(iter_29_1, arg_29_1)

			if not var_29_1 then
				break
			end

			local var_29_2 = var_0_6(var_29_0, var_29_1.showconfig[2])

			if var_29_2 then
				self:remove_all_alert(var_29_2)
			end
		end
	end

	for iter_29_2, iter_29_3 in pairs(var_0_3[arg_29_1]) do
		if self.alertsys[iter_29_3] then
			local var_29_3 = self:get_alert_config(iter_29_3, arg_29_1)

			if not var_29_3 then
				return
			end

			if not var_29_3.systemlayer or LayerManager:getLayerUnlockStat(var_29_3.systemlayer) then
				local var_29_4 = var_0_6(var_29_0, var_29_3.showconfig[2])

				if var_29_4 then
					self:add_alert_by_config(var_29_4, true, var_29_3.showconfig)
				end
			end
		end
	end

	if self.alertsys[ALERT_TOP_PLOT] then
		local var_29_5 = var_0_6(LayerManager:getUIElement("TopcostLayer"), var_0_2[ALERT_TOP_PLOT].showconfig[2])

		if var_29_5 then
			self:add_alert_by_config(var_29_5, true, var_0_2[ALERT_TOP_PLOT].showconfig)
		end
	else
		local var_29_6 = var_0_6(LayerManager:getUIElement("TopcostLayer"), var_0_2[ALERT_TOP_PLOT].showconfig[2])

		if var_29_6 then
			self:remove_all_alert(var_29_6)
		end
	end
end

function var_0_0:check_listbutton_alert(arg_30_1)
	if not var_0_4[arg_30_1] then
		for iter_30_0, iter_30_1 in pairs((LayerManager:getUIElement("ListButton"):getAlertNodes())) do
			self:remove_all_alert(iter_30_1)
		end
	else
		local var_30_0 = LayerManager:getUIElement("ListButton"):getAlertNodes()

		for iter_30_2, iter_30_3 in pairs(var_30_0) do
			self:remove_all_alert(iter_30_3)
		end

		for iter_30_4, iter_30_5 in pairs(var_0_4[arg_30_1]) do
			local var_30_1 = self:get_alert_config(iter_30_5, arg_30_1)

			if var_30_1 then
				if self.alertsys[iter_30_5] then
					if var_30_1.listbuttonswitchtag then
						if var_30_1.listbuttonswitchtag == LayerManager:getUIElement("ListButton"):getListButtonSwitchTag() then
							if LayerManager:getLayerUnlockStat(var_30_1.systemlayer) then
								self:add_alert_by_config(var_30_0[var_30_1.showconfig[2]], true, var_30_1.showconfig)

								goto label_30_0
							end
						end

						if LayerManager:getLayerUnlockStat(var_30_1.systemlayer) then
							self:add_alert_by_config(var_30_0[var_30_1.showconfig[2]], false, var_30_1.showconfig)
						end
					end
				end
			end

			::label_30_0::
		end
	end

	for iter_30_6, iter_30_7 in pairs(self.alertsys) do
		if var_0_2[iter_30_6].executelayer == "ListButtonLayer" then
			-- block empty
		end
	end
end

function var_0_0.get_alert_config(arg_31_0, arg_31_1, arg_31_2)
	if not var_0_2[arg_31_1] then
		return nil
	end

	if var_0_2[arg_31_1].unlocklevel then
		print(var_0_2[arg_31_1].unlocklevel)

		if not require("controller.level_manager"):isPlayerPassLevel(var_0_2[arg_31_1].unlocklevel) then
			return nil
		end
	end

	if type(var_0_2[arg_31_1].showlayer) ~= "table" then
		return var_0_2[arg_31_1]
	else
		for iter_31_0, iter_31_1 in pairs(var_0_2[arg_31_1].showlayer) do
			if iter_31_1 == arg_31_2 then
				return {
					showlayer = arg_31_2,
					systemlayer = var_0_2[arg_31_1].systemlayer,
					showconfig = var_0_2[arg_31_1].showconfig[iter_31_0],
					listbuttonswitchtag = var_0_2[arg_31_1].listbuttonswitchtag
				}
			end
		end
	end
end

function var_0_0:updataChangeBtnAlert()
	self:unregister_alert(ALERT_NEW_CHANGING)

	for iter_32_0, iter_32_1 in pairs((require("data.levelmode_data"))) do
		if iter_32_1.modetype == 2 and iter_32_1.trialtype == 1 then
			if not RoleDefault:getInstance():getBoolForKey("AdventureEnterAde" .. iter_32_1.trialtype, false) then
				if require("controller.level_manager"):isPlayerPassLevel(UNLOCK_AD) then
					self:register_alert(ALERT_NEW_CHANGING)
				end
			end
		end
	end

	if not RoleDefault:getInstance():getBoolForKey("ArenaLayerIsEnter", false) then
		self:register_alert(ALERT_NEW_CHANGEENTER_AREAN)
	else
		self:unregister_alert(ALERT_NEW_CHANGEENTER_AREAN)
	end

	if not RoleDefault:getInstance():getBoolForKey("ScoreArenaLayerIsEnter", false) then
		self:register_alert(ALERT_NEW_CHANGEENTER_SCROCE)
	else
		self:unregister_alert(ALERT_NEW_CHANGEENTER_SCROCE)
	end
end

function var_0_0:updataCommnityBtnAlert()
	local var_33_0, var_33_1 = LayerManager:getLayerUnlockStat("CommunityMainLayer")

	if not var_33_0 then
		self:unregister_alert(ALERT_RED_COMMITY, true)
	else
		local community_system_manager = require("controller.community_system_manager")

		if community_system_manager:getCurfamilyid() then
			community_system_manager:get_family_base_info(function(...)
				if community_system_manager:getApplyStatus() or community_system_manager:isHaveRewardget() or community_system_manager:getRecordRedStatus() or community_system_manager:haveCommpeletAwardTask() then
					self:register_alert(ALERT_RED_COMMITY)
				else
					self:unregister_alert(ALERT_RED_COMMITY, true)
				end

				community_system_manager:get_family_wish_record1()
				community_system_manager:get_family_wish_record2()
			end)
		else
			self:unregister_alert(ALERT_RED_COMMITY, true)
		end
	end
end

local var_0_8 = false
local var_0_9 = false
local var_0_10 = false
local var_0_11 = false

local function var_0_12()
	return var_0_8 or var_0_9 or var_0_10 or var_0_11
end

local function var_0_13()
	local servant_data = require("data.servant_data")
	local core_manager = require("controller.core_manager")
	local array_manager = require("controller.array_manager")

	for iter_36_0, iter_36_1 in pairs(require("model.playermodel").soulContract) do
		if servant_data[iter_36_0].classtype == 1 and iter_36_1 >= 0 and array_manager:isServantInHangup(iter_36_0) and core_manager:isTipsBreakOut(iter_36_0) then
			return true
		end
	end
end

function var_0_0:check_servant_breakout(arg_37_1)
	if arg_37_1 == nil then
		arg_37_1 = true
	end

	if var_0_11 == arg_37_1 then
		return
	end

	if var_0_13() then
		var_0_11 = true

		self:register_alert(ALERT_SERVANT_UPDATE)
	else
		var_0_11 = false

		if not var_0_12() then
			self:unregister_alert(ALERT_SERVANT_UPDATE)
		end
	end
end

local function var_0_14()
	local item_manager = require("controller.item_manager")
	local core_manager = require("controller.core_manager")
	local playermodel = require("model.playermodel")
	local servant_data = require("data.servant_data")

	for iter_38_0, iter_38_1 in pairs(playermodel.soulContract) do
		if servant_data[iter_38_0].classtype == 1 and iter_38_1 >= 0 and iter_38_1 < 5 then
			local var_38_4 = 0

			if core_manager:getUpgradeCostRoleCardNum(iter_38_0, iter_38_1 + 1) and playermodel.servantNum[iter_38_0] >= core_manager:getUpgradeCostRoleCardNum(iter_38_0, iter_38_1 + 1) then
				var_38_4 = core_manager:getUpgradeCostRoleCardNum(iter_38_0, iter_38_1 + 1) > 0 and 1 or 2
			end

			local var_38_6 = core_manager:getUpgradeCostMaterial(iter_38_0, iter_38_1 + 1)

			return var_38_4 == 1 or ((var_38_6 and core_manager:getUpgradeCostMaterialNum(iter_38_0, iter_38_1 + 1) <= item_manager:getItemNumber(var_38_6) or nil) and 1) == 1
		end
	end

	return false
end

function var_0_0:check_servant_update(arg_39_1)
	if arg_39_1 == nil then
		arg_39_1 = true
	end

	if var_0_8 == arg_39_1 then
		return
	end

	if var_0_14() then
		var_0_8 = true

		self:register_alert(ALERT_SERVANT_UPDATE)
	else
		var_0_8 = false

		if not var_0_12() then
			self:unregister_alert(ALERT_SERVANT_UPDATE)
		end
	end
end

local function var_0_15()
	local item_data = require("data.item_data")
	local var_40_1 = 0

	for iter_40_0, iter_40_1 in pairs(require("model.playermodel").items) do
		if iter_40_1.itemtype == kITEM_WEAPON and not iter_40_1.weapon_attr.use then
			var_40_1 = math.max(var_40_1, item_data[iter_40_1.itemid].equip_quality)
		end
	end

	return var_40_1
end

local function var_0_16(arg_41_0)
	local playermodel = require("model.playermodel")
	local servant_data = require("data.servant_data")
	local item_data = require("data.item_data")
	local weapon_manager = require("controller.weapon_manager")
	local array_manager = require("controller.array_manager")

	if var_0_15() == 0 then
		return false
	end

	for iter_41_0, iter_41_1 in pairs(playermodel.soulContract) do
		if servant_data[iter_41_0].classtype == 1 and iter_41_1 >= 0 and array_manager:isServantInArrayNow(iter_41_0) then
			if not playermodel.weaponId[iter_41_0] then
				for iter_41_2, iter_41_3 in pairs(playermodel.items) do
					if iter_41_3.itemtype == kITEM_WEAPON and not iter_41_3.weapon_attr.use then
						if item_data[iter_41_3.itemid].major then
							if item_data[iter_41_3.itemid].major == servant_data[iter_41_0].major then
								return true
							end
						else
							return true
						end
					end
				end
			else
				local item_manager = require("controller.item_manager")

				if weapon_manager:checkIsCanUpgrade(playermodel.weaponId[iter_41_0]) then
					return true
				end

				if weapon_manager:checkIsCanUpgrade(playermodel.weaponId[iter_41_0]) then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0:check_weapon_update(arg_42_1)
	if arg_42_1 == nil then
		arg_42_1 = true
	end

	if arg_42_1 and var_0_9 == arg_42_1 then
		return
	end

	if var_0_16(arg_42_1) then
		var_0_9 = true

		self:register_alert(ALERT_SERVANT_UPDATE)
	else
		var_0_9 = false

		if not var_0_12() then
			self:unregister_alert(ALERT_SERVANT_UPDATE)
		end
	end
end

local function var_0_19()
	return false
end

function var_0_0:check_component_update(arg_46_1)
	if arg_46_1 == nil then
		arg_46_1 = true
	end

	if arg_46_1 and var_0_10 == arg_46_1 then
		return
	end

	if var_0_19() then
		var_0_10 = true

		self:register_alert(ALERT_SERVANT_UPDATE)
	else
		var_0_10 = false

		if not var_0_12() then
			self:unregister_alert(ALERT_SERVANT_UPDATE)
		end
	end
end

local var_0_20 = false

local function var_0_21(arg_47_0)
	if not arg_47_0 then
		return false
	end

	local core_manager = require("controller.core_manager")

	if core_manager:StrengthenJudge(arg_47_0) == 1 and core_manager:getCoreLv(arg_47_0) < require("model.playermodel").grade then
		return core_manager:check_strengthen_point_by_grade(arg_47_0, 1) > 0
	end
end

local function var_0_22(arg_48_0)
	local core_manager = require("controller.core_manager")

	if core_manager:StrengthenJudge(arg_48_0) == 2 and core_manager:check_upgrade_conditions(arg_48_0) and require("controller.array_manager"):isServantInHangup(arg_48_0) then
		return true
	end
end

local function var_0_23(arg_49_0)
	for iter_49_0 = 1, 4 do
		if var_0_21(arg_49_0[iter_49_0].fight_girl) then
			return true
		end

		if var_0_22(arg_49_0[iter_49_0].fight_girl) then
			return true
		end
	end

	return false
end

local function var_0_24()
	local core_manager = require("controller.core_manager")
	local array_manager = require("controller.array_manager")

	for iter_50_0, iter_50_1 in pairs(require("model.playermodel").haveServant) do
		if iter_50_1 and array_manager:isServantInHangup(iter_50_0) and core_manager:StrengthenJudge(iter_50_0) == 5 and core_manager:check_upgrade_conditions(iter_50_0) then
			return true
		end
	end

	return false
end

function var_0_0:check_servant_strenghth(arg_51_1)
	if arg_51_1 == var_0_20 then
		return
	end

	local array_manager = require("controller.array_manager")
	local var_51_1 = array_manager:getBattleArrayData((array_manager:getLevelArray()))

	if not var_51_1 then
		return
	end

	if var_0_23(var_51_1) then
		var_0_20 = true

		self:register_alert(ALERT_STRENGTHEN)
	elseif var_0_24() then
		var_0_20 = true

		self:register_alert(ALERT_STRENGTHEN)
	else
		var_0_20 = false

		self:unregister_alert(ALERT_STRENGTHEN, true)
	end

	if FightLayer and FightLayer.getInstance() then
		FightLayer.getInstance():updateBtnStrength(var_0_20)
	end
end

local function var_0_25()
	for iter_52_0, iter_52_1 in pairs(require("model.playermodel").items) do
		if iter_52_1.itemtype == kITEM_HORCRUX and iter_52_1.new then
			return true
		end
	end

	return false
end

function var_0_0:check_new_horcrux(arg_53_1)
	if not require("controller.level_manager"):isPlayerPassLevel(UNLOCK_HORCRUX) then
		return false
	end

	arg_53_1 = arg_53_1 or var_0_25()

	if arg_53_1 then
		self:register_alert(ALERT_NEW_HORCRUX)
		self:unregister_alert(ALERT_BAG)

		return true
	elseif not var_0_25() then
		self:unregister_alert(ALERT_NEW_HORCRUX, true)

		return false
	end
end

local function var_0_26()
	for iter_54_0, iter_54_1 in pairs(require("model.playermodel").newservants) do
		if iter_54_1 then
			return true
		end
	end

	return false
end

function var_0_0:check_new_servant(arg_55_1)
	arg_55_1 = arg_55_1 or var_0_26()

	if arg_55_1 then
		self:register_alert(ALERT_NEW_SERVANT)
	elseif not var_0_26() then
		self:unregister_alert(ALERT_NEW_SERVANT, true)
	end
end

local var_0_27 = false

local function var_0_29(arg_57_0)
	if not arg_57_0 then
		return false
	end

	return require("controller.horcrux_manager"):horcruxCanBreakOut(arg_57_0)
end

local function var_0_30(arg_58_0)
	if not arg_58_0 then
		return false
	end

	return require("controller.horcrux_manager"):horcruxBagIsTipsHorcruxUpgrade(arg_58_0)
end

local function var_0_31(arg_59_0)
	if var_0_29(arg_59_0) then
		return true
	end

	if var_0_30(arg_59_0) then
		return true
	end

	return false
end

function var_0_0:check_horcrux_strenghth(arg_60_1)
	local var_60_1
	local horcrux_manager

	if arg_60_1 == var_0_27 then
		do return end

		horcrux_manager = require("controller.horcrux_manager")
	end

	for iter_60_0, iter_60_1 in pairs(require("model.playermodel").items) do
		if iter_60_1.itemtype == kITEM_HORCRUX and horcrux_manager:isTipsHorcruxUpgrade(iter_60_1.entityid) and var_0_31(iter_60_1.entityid) then
			var_0_27 = true

			self:register_alert(ALERT_STRENGTHEN_HORCRUX)

			var_60_1 = true

			break
		end
	end

	if not var_60_1 then
		var_0_27 = false

		self:unregister_alert(ALERT_STRENGTHEN_HORCRUX)
	end
end

function var_0_0:check_schoolArea_alert()
	if self.alertsys[ALERT_LAB] or self.alertsys[ALERT_TRAIN] or self.alertsys[ALERT_BOND] or self.alertsys[ALERT_SWIMMING] then
		self.alertsys[ALERT_SCHOOL] = true

		self:register_alert(ALERT_SCHOOL)
	else
		self.alertsys[ALERT_SCHOOL] = nil

		self:unregister_alert(ALERT_SCHOOL)
	end
end

function var_0_0.check_new_shop_from_twist(arg_62_0)
	return
end

function var_0_0:update_level_alert(arg_63_1)
	for iter_63_0, iter_63_1 in pairs(arg_63_1) do
		if not iter_63_1.redpoint then
			if RoleDefault:getInstance():getIntegerForKey("newJumpTower" .. iter_63_1.mode, 1) == 2 then
				RoleDefault:getInstance():setIntegerForKey("newJumpTower" .. iter_63_1.mode, 2)
				self:register_alert(E_ALTER_LEVEL_ADVENTURE)
			end
		end
	end
end

function var_0_0:checkAlertByID(arg_64_1)
	return self.alertsys[arg_64_1]
end

return var_0_0
