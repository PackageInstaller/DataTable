local var_0_0 = {
	[4] = {
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		enteanceId = 101,
		name = L_ACTIVITYINFO_NAME[4],
		mainLayerPoint = cc.p(356, -69),
		mainLayerAlertPos = {
			x = 110,
			y = 110
		},
		mainLayerImage = {
			"mainScenebg/activity/branch4/activity_entrance.png",
			"mainScenebg/activity/branch4/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivitySignLayer_4_1"
		},
		effect = function()
			return
		end
	},
	[2] = {
		autoPopOrder = 1,
		canCloseDirectly = true,
		mainLayerParentName = "panel_thirdlist",
		name = L_ACTIVITYINFO_NAME[2],
		mainLayerPoint = cc.p(-65, -694),
		mainLayerAlertPos = {
			x = 92,
			y = 170
		},
		mainLayerImage = {
			"mainScenebg/activity/branch4/activity_explore_entrance.png",
			"mainScenebg/activity/branch4/activity_explore_entrance.png"
		},
		jumptoConfig = {
			type = "SwitchLayer",
			systemid = 1200
		},
		Effect = function()
			return
		end,
		autoPopLayerFunc = function(...)
			require("view.Layer.ActivityMenuLayer")

			local activity_manager = require("controller.activity_manager")
			local var_3_1 = ActivityMenuLayer:getAutoPopLayerConfig({
				activityID = 2
			})

			function var_3_1.callback()
				activity_manager:autoPopActivity()
			end

			ActivityMenuLayer:pushInLayer(var_3_1)
		end
	},
	[5] = {
		autoPopOrder = 2,
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		name = L_ACTIVITYINFO_NAME[5],
		mainLayerAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch4/activity_entrance.png",
			"mainScenebg/activity/branch4/activity_entrance.png"
		},
		jumptoConfig = {
			jumpbackID = 1200,
			type = "PopLayer",
			id = "5-1",
			activity_type = "sign_id1",
			createLayer = function(...)
				require("controller.sign_manager"):createActivitySignLayer(...)
			end
		},
		Effect = function()
			return
		end,
		autoPopLayerFunc = function(...)
			require("controller.sign_manager"):createActivitySignLayer(...)
		end
	},
	[9] = {
		name = "彼岸花活动",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		enteanceId = 8001,
		mainLayerPoint = cc.p(356, 55),
		mainLayerAlertPos = {
			x = 115,
			y = 113
		},
		mainLayerImage = {
			"mainScenebg/activity/branch9/activity_entrance.png",
			"mainScenebg/activity/branch9/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityLayer_bianhua_Main"
		},
		effect = function()
			return
		end
	},
	[11] = {
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		enteanceId = 8010,
		name = L_ACTIVITYINFO_NAME[11],
		mainLayerPoint = cc.p(356, -75),
		mainLayerAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch11/activity_entrance.png",
			"mainScenebg/activity/branch11/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityNinifaLayer"
		},
		effect = function()
			return
		end
	},
	[12] = {
		name = "双旦活动",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		enteanceId = 3001,
		mainLayerPoint = cc.p(356, -95),
		mainLayerAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch12/activity_entrance.png",
			"mainScenebg/activity/branch12/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "DoubleHoliday_WoldCityLayer"
		},
		effect = function()
			return
		end
	},
	[13] = {
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		name = "双蛋活动预热",
		mainLayerPoint = cc.p(356, 55),
		mainLayerImage = {
			"mainScenebg/activity/branch13/activity_entrance.png",
			"mainScenebg/activity/branch13/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityPreheatPoint"
		},
		effect = function()
			return
		end
	},
	[14] = {
		name = "双旦活动",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		enteanceId = 3005,
		mainLayerPoint = cc.p(356, -95),
		mainLayerAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch12/activity_entrance.png",
			"mainScenebg/activity/branch12/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "DoubleHoliday_WoldCityLayer_2"
		},
		effect = function()
			return
		end
	},
	[16] = {
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		enteanceId = 3010,
		name = L_ACTIVITYINFO_NAME[16],
		mainLayerPoint = cc.p(356, -95),
		mainLayerAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch16/activity_entrance.png",
			"mainScenebg/activity/branch16/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityLayer_Valentine_Day"
		},
		effect = function()
			return
		end
	},
	[17] = {
		name = "女生节",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		enteanceId = 3012,
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch17/activity_entrance.png",
			"mainScenebg/activity/branch17/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "PopActivityLayerGirlsDay"
		},
		effect = function()
			return
		end
	},
	[18] = {
		name = "问答pt活动",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		enteanceId = 3013,
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch18/activity_entrance.png",
			"mainScenebg/activity/branch18/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityQuestionPtLayer"
		}
	},
	[100] = {
		name = "春节活动",
		autoPopOrder = 1,
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		enteanceId = 3006,
		mainLayerPoint = cc.p(356, -69),
		mainLayerAlertPos = {
			x = 155,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch100/activity_entrance.png",
			"mainScenebg/activity/branch100/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityLayer_SpringFestival"
		},
		effect = function()
			return
		end,
		autoPopLayerFunc = function()
			local activity_manager = require("controller.activity_manager")

			require("controller.spring_manager"):check_red_packet(function(arg_17_0, arg_17_1)
				if arg_17_0 == 1 and arg_17_1 == 1 then
					LayerManager:pushInLayer("PopBachelorWelfareLayer", {
						callback = function()
							activity_manager:autoPopActivity()
						end
					})
				else
					activity_manager:autoPopActivity()
				end
			end)
		end
	},
	[107] = {
		canCloseDirectly = true,
		name = "誓约活动",
		mainLayerParentName = "panel_sencondlist",
		enteanceId = 3013,
		mainLayerPoint = cc.p(356, -95),
		mainLayerImage = {
			"mainScenebg/activity/branch107/activity_entrance.png",
			"mainScenebg/activity/branch107/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityMarryMainLayer"
		},
		effect = function()
			return
		end
	},
	[108] = {
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		name = "19年愚人节",
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch108/activity_entrance.png",
			"mainScenebg/activity/branch108/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityStupidLayer"
		},
		effect = function()
			return
		end
	},
	[109] = {
		mainLayerParentName = "panel_sencondlist",
		name = "全面觉醒活动",
		canCloseDirectly = true,
		mainLayerPoint = cc.p(356, -69),
		mainLayerAlertPos = {
			x = 155,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch109/activity_entrance.png",
			"mainScenebg/activity/branch109/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityWideWakeLayer"
		},
		effect = function()
			return
		end
	},
	[110] = {
		name = "五一签到",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		mainLayerPoint = cc.p(356, -69),
		mainLayerImage = {
			"mainScenebg/activity/branch110/activity_entrance.png",
			"mainScenebg/activity/branch110/activity_entrance.png"
		},
		jumptoConfig = {
			id = "110-1",
			type = "PopLayer",
			activityID = 110,
			activity_type = "sign_id1",
			createLayer = function(...)
				require("controller.sign_manager"):createActivitySignLayer(...)
			end
		},
		Effect = function()
			return
		end
	},
	[111] = {
		name = "五一商城",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		mainLayerPoint = cc.p(356, -15),
		mainLayerImage = {
			"mainScenebg/activity/branch111/activity_entrance.png",
			"mainScenebg/activity/branch111/activity_entrance.png"
		},
		jumptoConfig = {
			systemid = 1510
		},
		Effect = function()
			return
		end
	},
	[117] = {
		name = "常规bp一期",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		isHasBattlePass = true,
		enteanceId = 8450,
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 115,
			y = 135
		},
		mainLayerNewAlertPos = {
			x = 130,
			y = 150
		},
		mainLayerImage = {
			"mainScenebg/activity/branch117/activity_entrance.png",
			"mainScenebg/activity/branch117/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityRoutineBPLayer"
		}
	},
	[118] = {
		mainLayerParentName = "panel_sencondlist",
		name = "五一翻牌",
		isHasFlop = true,
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 115,
			y = 135
		},
		mainLayerNewAlertPos = {
			x = 130,
			y = 150
		},
		mainLayerImage = {
			"mainScenebg/activity/branch118/activity_entrance.png",
			"mainScenebg/activity/branch118/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityFlopDuanWuLayer"
		}
	},
	[-1] = {
		name = "回流活动",
		autoPopOrder = 2,
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		mainLayerAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch108/activity_entrance.png",
			"mainScenebg/activity/branch108/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "PopActivityLayerGirlsDay"
		},
		effect = function()
			return
		end
	},
	[618] = {
		name = "618商城",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		mainLayerPoint = cc.p(356, -15),
		mainLayerImage = {
			"mainScenebg/activity/branch618/activity_entrance.png",
			"mainScenebg/activity/branch618/activity_entrance.png"
		},
		jumptoConfig = {
			systemid = 1510
		},
		Effect = function()
			return
		end
	},
	[120] = {
		name = "生日会",
		mainLayerParentName = "panel_sencondlist",
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerNewAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch120/activity_entrance.png",
			"mainScenebg/activity/branch120/activity_entrance.png"
		},
		jumptoConfig = {
			type = "SwitchLayer",
			systemid = 1500510
		},
		effect = function()
			return
		end
	},
	[121] = {
		name = "七夕签到",
		mainLayerParentName = "panel_sencondlist",
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 115,
			y = 130
		},
		mainLayerNewAlertPos = {
			x = 110,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch121/activity_entrance.png",
			"mainScenebg/activity/branch121/activity_entrance.png"
		},
		jumptoConfig = {
			id = "121-1",
			type = "PopLayer",
			activityID = 121,
			activity_type = "sign_id1",
			createLayer = function(...)
				require("controller.sign_manager"):createActivitySignLayer(...)
			end
		},
		effect = function()
			return
		end
	},
	[123] = {
		name = "夏日祭預熱翻牌",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		isHasFlop = true,
		isMainLayerhide = true,
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 115,
			y = 135
		},
		mainLayerNewAlertPos = {
			x = 130,
			y = 150
		},
		mainLayerImage = {
			"mainScenebg/activity/branch123/activity_entrance.png",
			"mainScenebg/activity/branch123/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityFlopSummerLayer"
		}
	},
	[119] = {
		name = "普通翻牌",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		isHasWordCollect = true,
		enteanceId = 8001,
		mainLayerPoint = cc.p(356, 55),
		mainLayerAlertPos = {
			x = 100,
			y = 115
		},
		mainLayerNewAlertPos = {
			x = 110,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch119/activity_entrance.png",
			"mainScenebg/activity/branch119/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityWordCollectionLayer"
		}
	},
	[129] = {
		canCloseDirectly = true,
		name = "台服30日",
		mainLayerParentName = "panel_sencondlist",
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 110,
			y = 110
		},
		mainLayerNewAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch129/activity_entrance.png",
			"mainScenebg/activity/branch129/activity_entrance.png"
		},
		jumptoConfig = {
			createLayer = function(arg_30_0)
				arg_30_0.activityid = 129
				arg_30_0.activityUIObjName = "ActivitySignTemplateLayer"

				local sign_manager = require("controller.sign_manager")

				LayerManager:pushInLayer("ActivitySignBaseLayer", arg_30_0)
			end
		},
		effect = function()
			return
		end
	},
	[128] = {
		name = "夏活主界面",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		isHasBattlePass = true,
		isHasFlop = true,
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 115,
			y = 113
		},
		mainLayerNewAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch128/activity_entrance.png",
			"mainScenebg/activity/branch128/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivitySummerMainLayer"
		},
		effect = function()
			return
		end
	},
	[131] = {
		name = "普通翻牌",
		isHasWordCollect = true,
		enteanceId = 8001,
		canCloseDirectly = true,
		jumptoConfig = {
			jumpToLayer = "ActivityWordCollectionLayer_131"
		}
	},
	[133] = {
		name = "七夕活动",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		isHasBattlePass = true,
		isHasFlop = true,
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 115,
			y = 113
		},
		mainLayerNewAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch133/activity_entrance.png",
			"mainScenebg/activity/branch133/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityQixiBPLayer"
		},
		effect = function()
			return
		end
	},
	[12301] = {
		mainLayerParentName = "panel_sencondlist",
		name = "夏日祭预热pt",
		canCloseDirectly = true,
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 115,
			y = 135
		},
		mainLayerNewAlertPos = {
			x = 130,
			y = 150
		},
		mainLayerImage = {
			"mainScenebg/activity/branch12301/activity_entrance.png",
			"mainScenebg/activity/branch12301/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityPreSummerPTLayer"
		}
	},
	[134] = {
		name = "教师节活动",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 115,
			y = 113
		},
		mainLayerNewAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch134/activity_entrance.png",
			"mainScenebg/activity/branch134/activity_entrance.png"
		},
		jumptoConfig = {
			createLayer = function(arg_34_0)
				LayerManager:pushInLayer("PopAnswerQuestionLayer", {
					activityid = 134
				})
			end
		},
		effect = function()
			return
		end
	},
	[136] = {
		name = "辛西娅bp",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		isHasBattlePass = true,
		mainLayerAlertPos = {
			x = 88,
			y = 90
		},
		mainLayerNewAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch136/activity_entrance.png",
			"mainScenebg/activity/branch136/activity_entrance.png"
		},
		jumptoConfig = {
			createLayer = function(arg_36_0)
				LayerManager:switchShowLayer("NoviceSummaryLayer", {
					isHideOther = true,
					layerName = "ActivityXinxiYaBPLayer"
				})
			end
		},
		effect = function()
			return
		end
	},
	[132] = {
		name = "一周年",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		isHasArt = true,
		isHasBattlePass = true,
		isHasRoulette = true,
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 115,
			y = 113
		},
		mainLayerNewAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch132/activity_entrance.png",
			"mainScenebg/activity/branch132/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityAnniversaryMainLayer"
		},
		effect = function()
			return
		end
	},
	[138] = {
		name = "夏日祭預熱翻牌",
		isHasFlop = true,
		enteanceId = 8450,
		canCloseDirectly = true,
		jumptoConfig = {
			jumpToLayer = "ActivityFlopLayer_138"
		}
	},
	[140] = {
		name = "七夕活动",
		canCloseDirectly = true,
		mainLayerParentName = "panel_sencondlist",
		isHasBattlePass = true,
		mainLayerPoint = cc.p(356, 0),
		mainLayerAlertPos = {
			x = 115,
			y = 113
		},
		mainLayerNewAlertPos = {
			x = 130,
			y = 130
		},
		mainLayerImage = {
			"mainScenebg/activity/branch140/activity_entrance.png",
			"mainScenebg/activity/branch140/activity_entrance.png"
		},
		jumptoConfig = {
			jumpToLayer = "ActivityBattlePassLayer_140"
		},
		effect = function()
			return
		end
	}
}

function var_0_0.query(arg_40_0, arg_40_1, arg_40_2)
	if not arg_40_2 then
		return var_0_0[arg_40_1]
	end

	if var_0_0[arg_40_1] then
		return var_0_0[arg_40_1][arg_40_2]
	end
end

return var_0_0
