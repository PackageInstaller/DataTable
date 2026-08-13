class = var_0_10000

local var_0_0 = "ActivityMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.EVENT_GO_SCENE = "event go scene"
var_0_1.EVENT_OPERATION = "event operation"
var_0_1.GO_SHOPS_LAYER = "event go shop layer"
var_0_1.GO_SHOPS_LAYER_STEEET = "event go shop layer in shopstreet"
var_0_1.BATTLE_OPERA = "event difficult sel"
var_0_1.GO_BACKYARD = "event go backyard"
var_0_1.GO_LOTTERY = "event go lottery"
var_0_1.EVENT_COLORING_ACHIEVE = "event coloring achieve"
var_0_1.ON_TASK_SUBMIT = "event on task submit"
var_0_1.ON_TASK_SUBMIT_ONESTEP = "event on task submit one step"
var_0_1.ON_TASK_GO = "event on task go"
var_0_1.OPEN_LAYER = "event OPEN_LAYER"
var_0_1.CLOSE_LAYER = "event CLOSE_LAYER"
var_0_1.EVENT_PT_OPERATION = "event pt op"
var_0_1.BLACKWHITEGRID = "black white grid"
var_0_1.MEMORYBOOK = "memory book"
var_0_1.RETURN_AWARD_OP = "event return award op"
var_0_1.SHOW_AWARD_WINDOW = "event show award window"
var_0_1.GO_DODGEM = "event go dodgem"
var_0_1.GO_SUBMARINE_RUN = "event go sumbarine run"
var_0_1.ON_SIMULATION_COMBAT = "event simulation combat"
var_0_1.ON_AIRFIGHT_COMBAT = "event perform airfight combat"
var_0_1.SPECIAL_BATTLE_OPERA = "special battle opera"
var_0_1.NEXT_DISPLAY_AWARD = "next display awards"
var_0_1.GO_PRAY_POOL = "go pray pool"
var_0_1.SELECT_ACTIVITY = "event select activity"
var_0_1.FETCH_INSTARGRAM = "fetch instagram"
var_0_1.MUSIC_GAME_OPERATOR = "get music game final prize"
var_0_1.SHOW_NEXT_ACTIVITY = "show next activity"
var_0_1.OPEN_RED_PACKET_LAYER = "ActivityMediator:OPEN_RED_PACKET_LAYER"
var_0_1.GO_MINI_GAME = "ActivityMediator.GO_MINI_GAME"
var_0_1.GO_DECODE_MINI_GAME = "ActivityMediator:GO_DECODE_MINI_GAME"
var_0_1.ON_BOBING_RESULT = "on bobing result"
var_0_1.ACTIVITY_PERMANENT = "ActivityMediator.ACTIVITY_PERMANENT"
var_0_1.FINISH_ACTIVITY_PERMANENT = "ActivityMediator.FINISH_ACTIVITY_PERMANENT"
var_0_1.ON_SHAKE_BEADS_RESULT = "on shake beads result"
var_0_1.GO_PERFORM_COMBAT = "ActivityMediator.GO_PERFORM_COMBAT"
var_0_1.ON_AWARD_WINDOW = "ActivityMediator:ON_AWARD_WINDOW"
var_0_1.GO_CARDPUZZLE_COMBAT = "ActivityMediator.GO_CARDPUZZLE_COMBAT"
var_0_1.CHARGE = "ActivityMediator.CHARGE"
var_0_1.BUY_ITEM = "ActivityMediator.BUY_ITEM"
var_0_1.OPEN_CHARGE_ITEM_PANEL = "ActivityMediator.OPEN_CHARGE_ITEM_PANEL"
var_0_1.OPEN_CHARGE_BIRTHDAY = "ActivityMediator.OPEN_CHARGE_BIRTHDAY"
var_0_1.STORE_DATE = "ActivityMediator.STORE_DATE"
var_0_1.ON_ACT_SHOPPING = "ActivityMediator.ON_ACT_SHOPPING"
var_0_1.GO_MONOPOLY2024 = "ActivityMediator:GO_MONOPOLY2024"
var_0_1.GO_MONOPOLY2026 = "ActivityMediator:GO_MONOPOLY2026"
var_0_1.ON_ACTIVITY_TASK_SUBMIT = "ActivityMediator.ON_ACTIVITY_TASK_SUBMIT"
var_0_1.ON_ACTIVITY_TASK_LIST_SUBMIT = "ActivityMediator.ON_ACTIVITY_TASK_LIST_SUBMIT"
var_0_1.GO_CHANGE_SHOP = "go Change shop"
var_0_1.GO_Activity_level = "go Activity level"
var_0_1.ON_ADD_SUBLAYER = "ActivityMediator.ON_ADD_SUBLAYER"
var_0_1.GO_SPECIAL_EXERCISE = "go Special exercise"
var_0_1.GO_SINGLE_PRECOMBAT = "ActivityMediator.GO_SINGLE_PRECOMBAT"
var_0_1.ON_BOSSRUSH_MAP = "ActivityMediator.ON_BOSSRUSH_MAP"
var_0_1.SKIP_ACTIVITY_MAP = "ActivityMediator.SKIP_ACTIVITY_MAP"
var_0_1.OPEN_MINI_PROGRAM = "ActivityMediator.OPEN_MINI_PROGRAM"
var_0_1.ON_COLLAB_BOSSRUSH_MAP = "ActivityMediator.ON_COLLAB_BOSSRUSH_MAP"
var_0_1.OPEN_CULTIVATING_PLANT = "ActivityMediator.OPEN_CULTIVATING_PLANT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_MONOPOLY2024, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_2_2 = var_2_10006.New
		local var_2_3 = {}

		MonopolyCar2024Mediator = var_2_10009
		var_2_3.mediator = var_2_10009
		MonopolyCar2024Scene = var_2_10009
		var_2_3.viewComponent = var_2_10009
		var_2_3.data = {
			actId = arg_2_1
		}
		var_2_3.onRemoved = arg_2_2

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.GO_MONOPOLY2026, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_3_2 = var_2_10006.New
		local var_3_3 = {}

		MonopolyCar2024Mediator = var_2_10009
		var_3_3.mediator = var_2_10009
		MonopolyCar2026Scene = var_2_10009
		var_3_3.viewComponent = var_2_10009
		var_3_3.data = {
			actId = arg_3_1
		}
		var_3_3.onRemoved = arg_3_2

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_AWARD_WINDOW, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = arg_1_0.viewComponent

		var_5.ShowAwardWindow(var_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)

		return
	end)
	arg_1_0:bind(var_0_1.GO_CHANGE_SHOP, function()
		local var_5_0 = arg_1_0
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_5_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_5_1(var_5_0, var_5_2, var_2_10004.SKINSHOP)

		return
	end)
	arg_1_0:bind(var_0_1.GO_Activity_level, function(arg_6_0)
		getProxy = var_2_10001
		ChapterProxy = var_2_10003

		local var_6_0 = var_2_10001(var_2_10003)
		local var_6_1, var_6_2 = var_1.getLastMapForActivity(var_6_0)

		if var_6_1 then
			var_2_10006 = var_1
			var_2_10006 = var_1.getMapById(var_2_10006, var_6_1)

			if not var_6_0.isUnlock(var_2_10006) then
				getProxy = var_6_0
				ChapterProxy = var_2_10006
				var_2_10007 = var_6_0(var_2_10006)

				if var_6_0.getActiveChapter(var_2_10007) then
					::label_6_0::

					var_2_10008 = var_5
					var_6_1 = var_5.getConfig(var_2_10008, "map")
				end

				if not var_5 then
					var_2_10008 = var_6_0
					var_6_1 = var_6_0.GetLastNormalMap(var_2_10008)
				end

				pg = var_2_10006
				var_2_10008 = var_2_10006.m02

				local var_6_3 = var_6.sendNotification

				GAME = var_2_10009

				local var_6_4 = var_2_10009.GO_SCENE

				SCENE = var_2_10010

				var_6_3(var_2_10008, var_6_4, var_2_10010.LEVEL, {
					chapterId = var_5 and var_5.id,
					mapIdx = var_6_1
				})
			else
				chapter = var_6_0

				if not var_6_0 then
					var_6_1 = var_1:GetLastNormalMap()
				end

				pg = var_6_0

				local var_6_5 = var_6_0.m02
				local var_6_6 = var_4.sendNotification

				GAME = var_2_10007

				local var_6_7 = var_2_10007.GO_SCENE

				SCENE = var_2_10008

				var_6_6(var_6_5, var_6_7, var_2_10008.LEVEL, {
					chapterId = var_6_2,
					mapIdx = var_6_1
				})
			end

			return
		end
	end)
	arg_1_0:bind(var_0_1.ON_COLLAB_BOSSRUSH_MAP, function()
		local var_7_0 = arg_1_0
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_7_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_7_1(var_7_0, var_7_2, var_2_10004.BOSSRUSH_DAL_COLLAB)

		return
	end)
	arg_1_0:bind(var_0_1.ON_BOSSRUSH_MAP, function()
		local var_8_0 = arg_1_0
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_8_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_8_1(var_8_0, var_8_2, var_2_10004.BOSSRUSH_MAIN)

		return
	end)
	arg_1_0:bind(var_0_1.GO_DECODE_MINI_GAME, function(arg_9_0)
		pg = var_2_10001

		local var_9_0 = var_2_10001.m02
		local var_9_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_9_2 = var_2_10004.REQUEST_MINI_GAME
		local var_9_3 = {}

		MiniGameRequestCommand = var_2_10006
		var_9_3.type = var_2_10006.REQUEST_HUB_DATA

		function var_9_3.callback()
			pg = var_3_10000

			local var_10_0 = var_3_10000.m02
			local var_10_1 = var_0.sendNotification

			GAME = var_3_10003

			var_10_1(var_10_0, var_3_10003.GO_MINI_GAME, 11)

			return
		end

		var_9_1(var_9_0, var_9_2, var_9_3)

		return
	end)
	arg_1_0:bind(var_0_1.GO_MINI_GAME, function(arg_11_0, arg_11_1)
		pg = var_2_10002

		local var_11_0 = var_2_10002.m02
		local var_11_1 = var_2.sendNotification

		GAME = var_2_10005

		var_11_1(var_11_0, var_2_10005.GO_MINI_GAME, arg_11_1)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SUBMARINE_RUN, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_1_0
		local var_12_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_12_2 = var_2_10005.BEGIN_STAGE
		local var_12_3 = {}

		SYSTEM_SUBMARINE_RUN = var_2_10007
		var_12_3.system = var_2_10007
		var_12_3.stageId = arg_12_1

		var_12_1(var_12_0, var_12_2, var_12_3)

		return
	end)
	arg_1_0:bind(var_0_1.GO_DODGEM, function(arg_13_0)
		ys = var_2_10001

		local var_13_0 = var_2_10001.Battle.BattleConfig.BATTLE_DODGEM_STAGES

		math = var_2_10002

		local var_13_1 = var_2_10002.random

		ys = var_2_10004

		local var_13_2 = var_13_0[var_13_1(#var_2_10004.Battle.BattleConfig.BATTLE_DODGEM_STAGES)]
		local var_13_3 = arg_1_0
		local var_13_4 = var_2.sendNotification

		GAME = var_2_10005

		local var_13_5 = var_2_10005.BEGIN_STAGE
		local var_13_6 = {}

		SYSTEM_DODGEM = var_2_10007
		var_13_6.system = var_2_10007
		var_13_6.stageId = var_13_2

		var_13_4(var_13_3, var_13_5, var_13_6)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SIMULATION_COMBAT, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_1_0
		local var_14_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_14_2 = var_2_10006.BEGIN_STAGE
		local var_14_3 = {}

		SYSTEM_SIMULATION = var_2_10008
		var_14_3.system = var_2_10008
		var_14_3.stageId = arg_14_1.stageId
		var_14_3.warnMsg = arg_14_1.warnMsg
		var_14_3.exitCallback = arg_14_2

		var_14_1(var_14_0, var_14_2, var_14_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_AIRFIGHT_COMBAT, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_1_0
		local var_15_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_15_2 = var_2_10006.BEGIN_STAGE
		local var_15_3 = {}

		SYSTEM_AIRFIGHT = var_2_10008
		var_15_3.system = var_2_10008
		var_15_3.stageId = arg_15_1.stageId
		var_15_3.exitCallback = arg_15_2

		var_15_1(var_15_0, var_15_2, var_15_3)

		return
	end)
	arg_1_0:bind(var_0_1.RETURN_AWARD_OP, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_1.cmd

		ActivityConst = var_2_10003

		if var_16_0 == var_2_10003.RETURN_AWARD_OP_SHOW_AWARD_OVERVIEW then
			local var_16_1 = arg_1_0.viewComponent
			local var_16_2 = var_2.ShowWindow

			ReturnerAwardWindow = var_2_10005

			var_16_2(var_16_1, var_2_10005, arg_16_1.arg1)
		else
			local var_16_3 = arg_16_1.cmd

			ActivityConst = var_3

			if var_16_3 == var_3.RETURN_AWARD_OP_SHOW_RETURNER_AWARD_OVERVIEW then
				local var_16_4 = arg_1_0.viewComponent
				local var_16_5 = var_2.ShowWindow

				TaskAwardWindow = var_2_10005

				var_16_5(var_16_4, var_2_10005, arg_16_1.arg1)
			else
				local var_16_6 = arg_1_0
				local var_16_7 = var_2.sendNotification

				GAME = var_2_10005

				var_16_7(var_16_6, var_2_10005.RETURN_AWARD_OP, arg_16_1)
			end
		end

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_AWARD_WINDOW, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_1_0.viewComponent

		var_3.ShowWindow(var_17_0, arg_17_1, arg_17_2)

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_PT_OPERATION, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_1_0
		local var_18_1 = var_2.sendNotification

		GAME = var_2_10005

		var_18_1(var_18_0, var_2_10005.ACT_NEW_PT, arg_18_1)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_LAYER, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_1_0

		var_2.addSubLayers(var_19_0, arg_19_1)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_RED_PACKET_LAYER, function(arg_20_0)
		local var_20_0 = arg_1_0
		local var_20_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_20_2 = var_2_10004.New
		local var_20_3 = {}

		RedPacketMediator = var_2_10007
		var_20_3.mediator = var_2_10007
		RedPacketLayer = var_2_10007
		var_20_3.viewComponent = var_2_10007

		var_20_1(var_20_0, var_20_2(var_20_3))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_LAYER, function(arg_21_0, arg_21_1)
		getProxy = var_2_10002
		ContextProxy = var_2_10004

		local var_21_0 = var_2_10002(var_2_10004)
		local var_21_1 = var_2.getCurrentContext(var_21_0)

		if var_3.getContextByMediator(var_21_1, arg_21_1) then
			local var_21_2 = arg_1_0
			local var_21_3 = var_5.sendNotification

			GAME = var_2_10008

			var_21_3(var_21_2, var_2_10008.REMOVE_LAYERS, {
				context = var_4
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_OPERATION, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_1_0
		local var_22_1 = var_2.sendNotification

		GAME = var_2_10005

		var_22_1(var_22_0, var_2_10005.ACTIVITY_OPERATION, arg_22_1)

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_GO_SCENE, function(arg_23_0, arg_23_1, arg_23_2)
		SCENE = var_2_10003

		if arg_23_1 == var_2_10003.SUMMER_FEAST then
			pg = var_3

			local var_23_0 = var_3.NewStoryMgr.GetInstance()

			var_3.Play(var_23_0, "TIANHOUYUYI1", function()
				local var_24_0 = arg_1_0
				local var_24_1 = var_0.sendNotification

				GAME = var_3_10003

				local var_24_2 = var_3_10003.GO_SCENE

				SCENE = var_3_10004

				var_24_1(var_24_0, var_24_2, var_3_10004.SUMMER_FEAST)

				return
			end)
		else
			local var_23_1 = arg_1_0
			local var_23_2 = var_3.sendNotification

			GAME = var_2_10006

			var_23_2(var_23_1, var_2_10006.GO_SCENE, arg_23_1, arg_23_2)
		end

		return
	end)
	arg_1_0:bind(var_0_1.BLACKWHITEGRID, function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_25_0 = var_2_10000(var_2_10002)
		local var_25_1 = var_0.getActivityByType

		ActivityConst = var_2_10003

		if not var_25_1(var_25_0, var_2_10003.ACTIVITY_TYPE_BLACKWHITE) then
			pg = var_2_10001

			local var_25_2 = var_2_10001.TipsMgr.GetInstance()
			local var_25_3 = var_1.ShowTips

			i18n = var_2_10004

			var_25_3(var_25_2, var_2_10004("common_activity_end"))

			return
		end

		local var_25_4 = arg_1_0
		local var_25_5 = var_1.addSubLayers

		Context = var_2_10004

		local var_25_6 = var_2_10004.New
		local var_25_7 = {}

		BlackWhiteGridLayer = var_2_10007
		var_25_7.viewComponent = var_2_10007
		BlackWhiteGridMediator = var_2_10007
		var_25_7.mediator = var_2_10007

		var_25_5(var_25_4, var_25_6(var_25_7))

		return
	end)
	arg_1_0:bind(var_0_1.MEMORYBOOK, function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_26_0 = var_2_10000(var_2_10002)
		local var_26_1 = var_0.getActivityByType

		ActivityConst = var_2_10003

		if not var_26_1(var_26_0, var_2_10003.ACTIVITY_TYPE_PUZZLA) then
			pg = var_2_10001

			local var_26_2 = var_2_10001.TipsMgr.GetInstance()
			local var_26_3 = var_1.ShowTips

			i18n = var_2_10004

			var_26_3(var_26_2, var_2_10004("common_activity_end"))

			return
		end

		local var_26_4 = arg_1_0
		local var_26_5 = var_1.addSubLayers

		Context = var_2_10004

		local var_26_6 = var_2_10004.New
		local var_26_7 = {}

		MemoryBookLayer = var_2_10007
		var_26_7.viewComponent = var_2_10007
		MemoryBookMediator = var_2_10007
		var_26_7.mediator = var_2_10007

		var_26_5(var_26_4, var_26_6(var_26_7))

		return
	end)
	arg_1_0:bind(var_0_1.GO_SHOPS_LAYER, function(arg_27_0, arg_27_1)
		getProxy = var_2_10002
		ActivityProxy = var_2_10004

		local var_27_0 = var_2_10002(var_2_10004)

		if not var_2.getActivityById(var_27_0, arg_27_1.actId) then
			pg = var_2_10003

			local var_27_1 = var_2_10003.TipsMgr.GetInstance()
			local var_27_2 = var_3.ShowTips

			i18n = var_2_10006

			var_27_2(var_27_1, var_2_10006("common_activity_end"))

			return
		end

		local var_27_3 = arg_1_0
		local var_27_4 = var_3.sendNotification

		GAME = var_2_10006

		local var_27_5 = var_2_10006.GO_SCENE

		SCENE = var_2_10007

		local var_27_6 = var_2_10007.SHOP

		if not arg_27_1 then
			::label_27_0::

			var_2_10008 = {}
			NewShopsScene = var_2_10009
			var_2_10008.warp = var_2_10009.TYPE_ACTIVITY
		end

		var_27_4(var_27_3, var_27_5, var_27_6, var_2_10008)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SHOPS_LAYER_STEEET, function(arg_28_0, arg_28_1)
		local var_28_0 = arg_1_0
		local var_28_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_28_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		local var_28_3 = var_2_10006.SHOP

		if not arg_28_1 then
			::label_28_0::

			var_2_10007 = {}
			NewShopsScene = var_2_10008
			var_2_10007.warp = var_2_10008.TYPE_SHOP_STREET
		end

		var_28_1(var_28_0, var_28_2, var_28_3, var_2_10007)

		return
	end)
	arg_1_0:bind(var_0_1.BATTLE_OPERA, function()
		getProxy = var_2_10000
		ChapterProxy = var_2_10002

		local var_29_0 = var_2_10000(var_2_10002)
		local var_29_1, var_29_2 = var_0.getLastMapForActivity(var_29_0)

		if var_29_1 then
			local var_29_3 = var_0:getMapById(var_29_1)

			if not var_29_0.isUnlock(var_29_3) then
				pg = var_29_0

				local var_29_4 = var_29_0.TipsMgr.GetInstance()

				var_29_0 = var_29_0.ShowTips
				i18n = var_2_10006

				var_29_0(var_29_4, var_2_10006("common_activity_end"))
			else
				pg = var_29_0

				local var_29_5 = var_29_0.m02
				local var_29_6 = var_3.sendNotification

				GAME = var_2_10006

				local var_29_7 = var_2_10006.GO_SCENE

				SCENE = var_2_10007

				var_29_6(var_29_5, var_29_7, var_2_10007.LEVEL, {
					chapterId = var_29_2,
					mapIdx = var_29_1
				})
			end

			return
		end
	end)
	arg_1_0:bind(var_0_1.SKIP_ACTIVITY_MAP, function(arg_30_0, arg_30_1)
		getProxy = var_2_10002
		ChapterProxy = var_2_10004

		local var_30_0 = var_2_10002(var_2_10004)
		local var_30_1, var_30_2 = var_2.getLastMapForActivity(var_30_0, arg_30_1)

		if var_30_1 then
			local var_30_3 = var_2:getMapById(var_30_1)

			if not var_30_0.isUnlock(var_30_3) then
				pg = var_30_0

				local var_30_4 = var_30_0.TipsMgr.GetInstance()
				local var_30_5 = var_5.ShowTips

				i18n = var_2_10008

				var_30_5(var_30_4, var_2_10008("common_activity_end"))
			else
				local var_30_6 = arg_1_0
				local var_30_7 = var_5.sendNotification

				GAME = var_2_10008

				local var_30_8 = var_2_10008.GO_SCENE

				SCENE = var_2_10009

				var_30_7(var_30_6, var_30_8, var_2_10009.LEVEL, {
					chapterId = var_30_2,
					mapIdx = var_30_1
				})
			end

			return
		end
	end)
	arg_1_0:bind(var_0_1.OPEN_MINI_PROGRAM, function(arg_31_0)
		pg = var_2_10001

		local var_31_0 = var_2_10001.SdkMgr.GetInstance()

		var_1.OpenMiniProgram(var_31_0)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CULTIVATING_PLANT, function(arg_32_0)
		local var_32_0 = arg_1_0
		local var_32_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_32_2 = var_2_10004.New
		local var_32_3 = {}

		CultivatingPlantMediator = var_2_10007
		var_32_3.mediator = var_2_10007
		CultivatingPlantScene = var_2_10007
		var_32_3.viewComponent = var_2_10007

		var_32_1(var_32_0, var_32_2(var_32_3))

		return
	end)
	arg_1_0:bind(var_0_1.GO_SPECIAL_EXERCISE, function()
		pg = var_2_10000

		local var_33_0 = var_2_10000.m02
		local var_33_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_33_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_33_1(var_33_0, var_33_2, var_2_10004.ACT_BOSS_BATTLE)

		return
	end)
	arg_1_0:bind(var_0_1.SPECIAL_BATTLE_OPERA, function()
		getProxy = var_2_10000
		ChapterProxy = var_2_10002

		local var_34_0 = var_2_10000(var_2_10002)
		local var_34_1, var_34_2 = var_0.getLastMapForActivity(var_34_0)

		if var_34_1 then
			var_2_10005 = var_0
			var_2_10005 = var_0.getMapById(var_2_10005, var_34_1)

			if not var_34_0.isUnlock(var_2_10005) then
				getProxy = var_34_0
				ChapterProxy = var_2_10005
				var_2_10006 = var_34_0(var_2_10005)

				if var_34_0.getActiveChapter(var_2_10006) then
					::label_34_0::

					var_2_10007 = var_4
					var_34_1 = var_4.getConfig(var_2_10007, "map")
				end

				if not var_4 then
					var_2_10007 = var_34_0
					var_34_1 = var_34_0.GetLastNormalMap(var_2_10007)
				end

				pg = var_2_10005
				var_2_10007 = var_2_10005.m02

				local var_34_3 = var_5.sendNotification

				GAME = var_2_10008

				local var_34_4 = var_2_10008.GO_SCENE

				SCENE = var_2_10009

				var_34_3(var_2_10007, var_34_4, var_2_10009.LEVEL, {
					chapterId = var_4 and var_4.id,
					mapIdx = var_34_1
				})
			else
				pg = var_34_0

				local var_34_5 = var_34_0.m02
				local var_34_6 = var_3.sendNotification

				GAME = var_2_10006

				local var_34_7 = var_2_10006.GO_SCENE

				SCENE = var_2_10007

				var_34_6(var_34_5, var_34_7, var_2_10007.LEVEL, {
					chapterId = var_34_2,
					mapIdx = var_34_1
				})
			end

			return
		end
	end)
	arg_1_0:bind(var_0_1.ON_ADD_SUBLAYER, function(arg_35_0, arg_35_1)
		local var_35_0 = arg_1_0

		var_2.addSubLayers(var_35_0, arg_35_1)

		return
	end)
	arg_1_0:bind(var_0_1.GO_LOTTERY, function(arg_36_0)
		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_36_0 = var_2_10001(var_2_10003)
		local var_36_1 = var_1.getActivityByType

		ActivityConst = var_2_10004

		local var_36_2 = var_36_1(var_36_0, var_2_10004.ACTIVITY_TYPE_LOTTERY)
		local var_36_3 = arg_1_0
		local var_36_4 = var_2.addSubLayers

		Context = var_2_10005

		local var_36_5 = var_2_10005.New
		local var_36_6 = {}

		LotteryMediator = var_2_10008
		var_36_6.mediator = var_2_10008
		LotteryLayer = var_2_10008
		var_36_6.viewComponent = var_2_10008
		var_36_6.data = {
			activityId = var_36_2.id
		}

		var_36_4(var_36_3, var_36_5(var_36_6))

		return
	end)
	arg_1_0:bind(var_0_1.GO_BACKYARD, function(arg_37_0)
		local var_37_0 = arg_1_0
		local var_37_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_37_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_37_1(var_37_0, var_37_2, var_2_10005.COURTYARD)

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_COLORING_ACHIEVE, function(arg_38_0, arg_38_1)
		local var_38_0 = arg_1_0
		local var_38_1 = var_2.sendNotification

		GAME = var_2_10005

		var_38_1(var_38_0, var_2_10005.COLORING_ACHIEVE, arg_38_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_39_0, arg_39_1, arg_39_2)
		local var_39_0 = arg_1_0
		local var_39_1 = var_3.sendNotification

		GAME = var_2_10006

		var_39_1(var_39_0, var_2_10006.SUBMIT_TASK, arg_39_1.id, arg_39_2)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT_ONESTEP, function(arg_40_0, arg_40_1)
		local var_40_0 = arg_1_0
		local var_40_1 = var_2.sendNotification

		GAME = var_2_10005

		var_40_1(var_40_0, var_2_10005.SUBMIT_TASK_ONESTEP, {
			resultList = arg_40_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_GO, function(arg_41_0, arg_41_1)
		local var_41_0 = arg_1_0
		local var_41_1 = var_2.sendNotification

		GAME = var_2_10005

		var_41_1(var_41_0, var_2_10005.TASK_GO, {
			taskVO = arg_41_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_PRAY_POOL, function(arg_42_0)
		local var_42_0 = arg_1_0
		local var_42_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_42_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_42_1(var_42_0, var_42_2, var_2_10005.GETBOAT, {
			goToPray = true
		})

		return
	end)
	arg_1_0:bind(var_0_1.FETCH_INSTARGRAM, function(arg_43_0, ...)
		local var_43_0 = arg_1_0
		local var_43_1 = var_1.sendNotification

		GAME = var_2_10004

		var_43_1(var_43_0, var_2_10004.ACT_INSTAGRAM_FETCH, ...)

		return
	end)
	arg_1_0:bind(var_0_1.MUSIC_GAME_OPERATOR, function(arg_44_0, ...)
		local var_44_0 = arg_1_0
		local var_44_1 = var_1.sendNotification

		GAME = var_2_10004

		var_44_1(var_44_0, var_2_10004.SEND_MINI_GAME_OP, ...)

		return
	end)
	arg_1_0:bind(var_0_1.SELECT_ACTIVITY, function(arg_45_0, arg_45_1)
		local var_45_0 = arg_1_0.viewComponent

		var_2.verifyTabs(var_45_0, arg_45_1)

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_NEXT_ACTIVITY, function(arg_46_0, arg_46_1)
		local var_46_0 = arg_1_0

		var_2.showNextActivity(var_46_0, arg_46_1)

		return
	end)
	arg_1_0:bind(var_0_1.ACTIVITY_PERMANENT, function(arg_47_0, arg_47_1)
		PlayerPrefs = var_2_10002

		local var_47_0 = var_2_10002.GetString("permanent_time", "")

		pg = var_2_10003

		local var_47_1

		if var_47_0 ~= var_2_10003.gameset.permanent_mark.description then
			PlayerPrefs = var_47_0
			var_47_0 = var_47_0.SetString
			var_47_1 = "permanent_time"
			pg = var_5

			var_47_0(var_47_1, var_5.gameset.permanent_mark.description)

			var_47_1 = arg_1_0.viewComponent

			var_47_0.updateEntrances(var_47_1)
		end

		getProxy = var_47_0
		ActivityPermanentProxy = var_47_1

		local var_47_2 = var_47_0(var_47_1)
		local var_47_3 = var_2.getDoingActivity

		ActivityPermanentProxy = var_5

		if var_47_3(var_47_2, var_5.TYPE_NORMAL_ACTIVITY) then
			pg = var_3

			local var_47_4 = var_3.TipsMgr.GetInstance()
			local var_47_5 = var_3.ShowTips

			i18n = var_2_10006

			var_47_5(var_47_4, var_2_10006("activity_permanent_tips3"))

			local var_47_6 = arg_1_0.viewComponent

			var_3.verifyTabs(var_47_6, var_2.id)
		else
			local var_47_7 = arg_1_0
			local var_47_8 = var_3.addSubLayers

			Context = var_2_10006

			local var_47_9 = var_2_10006.New
			local var_47_10 = {}

			ActivityPermanentMediator = var_2_10009
			var_47_10.mediator = var_2_10009
			ActivityPermanentLayer = var_2_10009
			var_47_10.viewComponent = var_2_10009
			var_47_10.data = {
				finishId = arg_47_1
			}

			var_47_8(var_47_7, var_47_9(var_47_10))
		end

		return
	end)
	arg_1_0:bind(var_0_1.FINISH_ACTIVITY_PERMANENT, function(arg_48_0)
		getProxy = var_2_10001
		ActivityPermanentProxy = var_2_10003

		local var_48_0 = var_2_10001(var_2_10003)
		local var_48_1 = var_1.getDoingActivity

		ActivityPermanentProxy = var_2_10004

		local var_48_2 = var_48_1(var_48_0, var_2_10004.TYPE_NORMAL_ACTIVITY)

		assert = var_2_10002

		var_2_10002(var_48_2:canPermanentFinish(), "error permanent activity finish")

		local var_48_3 = arg_1_0
		local var_48_4 = var_2.sendNotification

		GAME = var_5

		var_48_4(var_48_3, var_5.ACTIVITY_PERMANENT_FINISH, {
			activity_id = var_48_2.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_PERFORM_COMBAT, function(arg_49_0, arg_49_1, arg_49_2)
		local var_49_0 = arg_1_0
		local var_49_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_49_2 = var_2_10006.BEGIN_STAGE
		local var_49_3 = {}

		SYSTEM_PERFORM = var_2_10008
		var_49_3.system = var_2_10008
		var_49_3.stageId = arg_49_1.stageId
		var_49_3.memory = arg_49_1.memory

		var_49_1(var_49_0, var_49_2, var_49_3)

		return
	end)
	arg_1_0:bind(var_0_1.NEXT_DISPLAY_AWARD, function(arg_50_0, arg_50_1, arg_50_2)
		arg_1_0.nextDisplayAwards = arg_50_1

		return
	end)
	arg_1_0:bind(var_0_1.GO_CARDPUZZLE_COMBAT, function(arg_51_0, arg_51_1)
		local var_51_0 = arg_1_0
		local var_51_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_51_2 = var_2_10005.BEGIN_STAGE
		local var_51_3 = {}

		SYSTEM_CARDPUZZLE = var_2_10007
		var_51_3.system = var_2_10007
		var_51_3.combatID = arg_51_1

		var_51_1(var_51_0, var_51_2, var_51_3)

		return
	end)
	arg_1_0:bind(var_0_1.CHARGE, function(arg_52_0, arg_52_1)
		local var_52_0 = arg_1_0
		local var_52_1 = var_2.sendNotification

		GAME = var_2_10005

		var_52_1(var_52_0, var_2_10005.CHARGE_OPERATION, {
			shopId = arg_52_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.BUY_ITEM, function(arg_53_0, arg_53_1, arg_53_2)
		local var_53_0 = arg_1_0
		local var_53_1 = var_3.sendNotification

		GAME = var_2_10006

		var_53_1(var_53_0, var_2_10006.SHOPPING, {
			id = arg_53_1,
			count = arg_53_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_ITEM_PANEL, function(arg_54_0, arg_54_1)
		local var_54_0 = arg_1_0
		local var_54_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_54_2 = var_2_10005.New
		local var_54_3 = {}

		ChargeItemPanelMediator = var_2_10008
		var_54_3.mediator = var_2_10008
		ChargeItemPanelLayer = var_2_10008
		var_54_3.viewComponent = var_2_10008
		var_54_3.data = {
			panelConfig = arg_54_1
		}

		var_54_1(var_54_0, var_54_2(var_54_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_BIRTHDAY, function(arg_55_0, arg_55_1)
		local var_55_0 = arg_1_0
		local var_55_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_55_2 = var_2_10005.New
		local var_55_3 = {}

		ChargeBirthdayMediator = var_2_10008
		var_55_3.mediator = var_2_10008
		ChargeBirthdayLayer = var_2_10008
		var_55_3.viewComponent = var_2_10008
		var_55_3.data = {}

		var_55_1(var_55_0, var_55_2(var_55_3))

		return
	end)
	arg_1_0:bind(var_0_1.STORE_DATE, function(arg_56_0, arg_56_1)
		local var_56_0 = arg_1_0
		local var_56_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_56_2 = var_2_10005.ACTIVITY_STORE_DATE
		local var_56_3 = {
			activity_id = arg_56_1.actId
		}
		local var_56_4

		if not arg_56_1.intValue then
			var_56_4 = 0
		end

		var_56_3.intValue = var_56_4

		local var_56_5

		if not arg_56_1.strValue then
			var_56_5 = ""
		end

		var_56_3.strValue = var_56_5
		var_56_3.callback = arg_56_1.callback

		var_56_1(var_56_0, var_56_2, var_56_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACT_SHOPPING, function(arg_57_0, arg_57_1, arg_57_2, arg_57_3, arg_57_4, arg_57_5)
		local var_57_0 = arg_1_0
		local var_57_1 = var_6.sendNotification

		GAME = var_2_10009

		var_57_1(var_57_0, var_2_10009.ACTIVITY_OPERATION, {
			activity_id = arg_57_1,
			cmd = arg_57_2,
			arg1 = arg_57_3,
			arg2 = arg_57_4,
			callback = arg_57_5
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACTIVITY_TASK_SUBMIT, function(arg_58_0, arg_58_1)
		local var_58_0 = arg_1_0
		local var_58_1 = var_2.sendNotification

		GAME = var_2_10005

		var_58_1(var_58_0, var_2_10005.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_58_1.activityId,
			task_ids = {
				arg_58_1.id
			}
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACTIVITY_TASK_LIST_SUBMIT, function(arg_59_0, arg_59_1)
		local var_59_0 = arg_1_0
		local var_59_1 = var_2.sendNotification

		GAME = var_2_10005

		var_59_1(var_59_0, var_2_10005.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_59_1.activityId,
			task_ids = arg_59_1.ids
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_SINGLE_PRECOMBAT, function(arg_60_0, arg_60_1)
		local var_60_0 = arg_1_0
		local var_60_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_60_2 = var_2_10005.New
		local var_60_3 = {}

		BossSinglePreCombatLiteMediator = var_2_10008
		var_60_3.mediator = var_2_10008
		BossSinglePreCombatLiteLayer = var_2_10008
		var_60_3.viewComponent = var_2_10008
		var_60_3.data = {
			system = arg_60_1.system,
			stageId = arg_60_1.stageId,
			actId = arg_60_1.activityID,
			fleets = arg_60_1.fleets
		}

		var_60_1(var_60_0, var_60_2(var_60_3))

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.setActivities(var_1_0, arg_1_0:getDisplayActivity())

	getProxy = var_1
	PlayerProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getRawData(var_1_1)
	local var_1_3 = arg_1_0.viewComponent

	var_3.setPlayer(var_1_3, var_1_2)

	getProxy = var_3
	BayProxy = var_1_3

	local var_1_4 = var_3(var_1_3)
	local var_1_5 = var_3.getShipById(var_1_4, var_1_2.character)
	local var_1_6 = arg_1_0.viewComponent

	var_5.setFlagShip(var_1_6, var_1_5)

	return
end

function var_0_1.getDisplayActivity(arg_61_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_61_0 = var_1_10001(var_1_10003)

	return var_1.getPanelActivities(var_61_0)
end

function var_0_1.initNotificationHandleDic(arg_62_0)
	local var_62_0 = {}

	GAME = var_1_10002
	var_62_0[var_1_10002.SURVEY_DONE] = function(arg_63_0, arg_63_1)
		local var_63_0 = arg_63_1:getBody()
		local var_63_1 = arg_63_0.viewComponent

		var_3.removeActivity(var_63_1, var_63_0.id)

		return
	end
	ActivityProxy = var_2
	var_62_0[var_2.ACTIVITY_ADDED] = function(arg_64_0, arg_64_1)
		local var_64_0 = arg_64_1
		local var_64_1 = arg_64_1.getBody(var_64_0)
		local var_64_2 = var_2.getConfig(var_64_1, "type")

		ActivityConst = var_64_0

		if var_64_2 == var_64_0.ACTIVITY_TYPE_LOTTERY then
			return
		end

		local var_64_3 = arg_64_0.viewComponent

		var_3.updateActivity(var_64_3, var_2)

		ActivityConst = var_3

		if var_3.AOERLIANG_TASK_ID == var_2.id then
			local var_64_4 = arg_64_0.viewComponent

			var_3.update_task_list_auto_aoerliang(var_64_4, var_2)
		end

		return
	end
	ActivityProxy = var_2
	var_62_0[var_2.ACTIVITY_UPDATED] = function(...)
		local var_65_0 = arg_62_0.handleDic

		ActivityProxy = var_2_10001

		var_65_0[var_2_10001.ACTIVITY_ADDED](...)

		return
	end
	ActivityProxy = var_2
	var_62_0[var_2.ACTIVITY_DELETED] = function(arg_66_0, arg_66_1)
		local var_66_0 = arg_66_1:getBody()
		local var_66_1 = arg_66_0.viewComponent

		var_3.removeActivity(var_66_1, var_66_0)

		return
	end
	ActivityProxy = var_2
	var_62_0[var_2.ACTIVITY_OPERATION_DONE] = function(arg_67_0, arg_67_1)
		local var_67_0 = arg_67_1:getBody()

		getProxy = var_2_10003
		ActivityProxy = var_2_10005

		local var_67_1 = var_2_10003(var_2_10005)
		local var_67_2 = var_3.getActivityById(var_67_1, var_67_0)
		local var_67_3 = var_3.getConfig(var_67_2, "type")

		ActivityConst = var_67_1

		if var_67_3 == var_67_1.ACTIVITY_TYPE_HOTSPRING_2 then
			local var_67_4 = arg_67_0.viewComponent

			var_67_3.updateActivity(var_67_4)
		end

		MonthSignPage = var_67_3

		if var_67_3.ShouldPlaySpEffect(var_3) and arg_67_0.viewComponent.pageDic[var_3.id] then
			var_4:ActionInvoke("TryShowSpEffect", function()
				local var_68_0 = arg_67_0
				local var_68_1 = var_0.showNextActivity
				local var_68_2 = var_0

				var_68_1(var_68_0, var_3.getConfig(var_68_2, "page_core"))

				return
			end)

			return
		end

		ActivityConst = var_4

		if var_4.AOERLIANG_TASK_ID == var_67_0 then
			return
		end

		arg_67_0:showNextActivity(var_3:getConfig("page_core"))

		return
	end
	ActivityProxy = var_2
	var_62_0[var_2.ACTIVITY_SHOW_AWARDS] = function(arg_69_0, arg_69_1)
		local var_69_0 = arg_69_1:getBody().awards

		if arg_69_0.nextDisplayAwards and #arg_69_0.nextDisplayAwards > 0 then
			for iter_69_0 = 1, #arg_69_0.nextDisplayAwards do
				table = var_2_10008

				var_2_10008.insert(var_69_0, arg_69_0.nextDisplayAwards[iter_69_0])
			end
		end

		arg_69_0.nextDisplayAwards = {}

		local var_69_1 = arg_69_0.viewComponent
		local var_69_2 = var_4.emit

		BaseUI = iter_69_0

		var_69_2(var_69_1, iter_69_0.ON_ACHIEVE, var_69_0, var_2.callback)

		return
	end
	ActivityProxy = var_2
	var_62_0[var_2.ACTIVITY_SHOW_BB_RESULT] = function(arg_70_0, arg_70_1)
		local var_70_0 = arg_70_1:getBody()
		local var_70_1 = arg_70_0.viewComponent
		local var_70_2 = var_3.emit

		ActivityMediator = var_2_10006

		var_70_2(var_70_1, var_2_10006.ON_BOBING_RESULT, var_70_0)

		return
	end
	ActivityProxy = var_2
	var_62_0[var_2.ACTIVITY_SHOW_LOTTERY_AWARD_RESULT] = function(arg_71_0, arg_71_1)
		local var_71_0 = arg_71_1:getBody().activityID
		local var_71_1 = arg_71_0.viewComponent.pageDic[var_71_0]

		var_4.showLotteryAwardResult(var_71_1, var_2.awards, var_2.number, var_2.callback)

		return
	end
	ActivityProxy = var_2
	var_62_0[var_2.ACTIVITY_SHOW_SHAKE_BEADS_RESULT] = function(arg_72_0, arg_72_1)
		local var_72_0 = arg_72_1:getBody()
		local var_72_1 = arg_72_0.viewComponent
		local var_72_2 = var_3.emit

		ActivityMediator = var_2_10006

		var_72_2(var_72_1, var_2_10006.ON_SHAKE_BEADS_RESULT, var_72_0)

		return
	end
	GAME = var_2
	var_62_0[var_2.SUBMIT_TASK_DONE] = function(arg_73_0, arg_73_1)
		local var_73_0 = arg_73_1:getBody()
		local var_73_1 = arg_73_0.viewComponent
		local var_73_2 = var_3.emit

		BaseUI = var_2_10006

		var_73_2(var_73_1, var_2_10006.ON_ACHIEVE, var_73_0, function()
			local var_74_0 = arg_73_0.viewComponent

			var_0.updateTaskLayers(var_74_0)

			return
		end)

		return
	end
	GAME = var_2
	var_62_0[var_2.SUBMIT_ACTIVITY_TASK_DONE] = function(arg_75_0, arg_75_1)
		local var_75_0 = arg_75_1:getBody()
		local var_75_1 = arg_75_0.viewComponent
		local var_75_2 = var_3.emit

		BaseUI = var_2_10006

		var_75_2(var_75_1, var_2_10006.ON_ACHIEVE, var_75_0.awards, function()
			local var_76_0 = arg_75_0.viewComponent

			var_0.checkAutoHideActivity(var_76_0)

			local var_76_1 = arg_75_0.viewComponent

			var_0.updateTaskLayers(var_76_1)

			existCall = var_0

			var_0(var_75_0.callback)

			return
		end)

		return
	end
	GAME = var_2
	var_62_0[var_2.ACT_NEW_PT_DONE] = function(arg_77_0, arg_77_1)
		local var_77_0 = arg_77_1:getBody()
		local var_77_1 = arg_77_0.viewComponent
		local var_77_2 = var_3.emit

		BaseUI = var_2_10006

		var_77_2(var_77_1, var_2_10006.ON_ACHIEVE, var_77_0.awards, function()
			local var_78_0 = arg_77_0.viewComponent

			var_0.updateTaskLayers(var_78_0)

			existCall = var_0

			var_0(var_77_0.callback)

			return
		end)

		return
	end
	GAME = var_2
	var_62_0[var_2.BEGIN_STAGE_DONE] = function(arg_79_0, arg_79_1)
		local var_79_0 = arg_79_1:getBody()
		local var_79_1 = arg_79_0
		local var_79_2 = arg_79_0.sendNotification

		GAME = var_2_10006

		local var_79_3 = var_2_10006.GO_SCENE

		SCENE = var_2_10007

		var_79_2(var_79_1, var_79_3, var_2_10007.COMBATLOAD, var_79_0)

		return
	end
	GAME = var_2
	var_62_0[var_2.RETURN_AWARD_OP_DONE] = function(arg_80_0, arg_80_1)
		local var_80_0 = arg_80_1:getBody()
		local var_80_1 = arg_80_0.viewComponent
		local var_80_2 = var_3.emit

		BaseUI = var_2_10006

		var_80_2(var_80_1, var_2_10006.ON_ACHIEVE, var_80_0.awards)

		return
	end
	VoteProxy = var_2
	var_62_0[var_2.VOTE_ORDER_BOOK_DELETE] = function(arg_81_0, arg_81_1)
		return
	end
	VoteProxy = var_2
	var_62_0[var_2.VOTE_ORDER_BOOK_UPDATE] = function(...)
		local var_82_0 = arg_62_0.handleDic

		VoteProxy = var_2_10001

		var_82_0[var_2_10001.VOTE_ORDER_BOOK_DELETE](...)

		return
	end
	GAME = var_2
	var_62_0[var_2.REMOVE_LAYERS] = function(arg_83_0, arg_83_1)
		local var_83_0 = arg_83_1
		local var_83_1 = arg_83_1.getBody(var_83_0).context.mediator

		VoteFameHallMediator = var_83_0

		if var_83_1 == var_83_0 then
			local var_83_2 = arg_83_0.viewComponent

			var_3.updateEntrances(var_83_2)
		end

		return
	end
	GAME = var_2
	var_62_0[var_2.MONOPOLY_AWARD_DONE] = function(arg_84_0, arg_84_1)
		local var_84_0 = arg_84_1:getBody()

		if arg_84_0.viewComponent.pageDic[arg_84_0.viewComponent.activity.id] then
			local var_84_1 = var_3.activity
			local var_84_2 = var_4.getConfig(var_84_1, "type")

			ActivityConst = var_2_10005

			if var_84_2 == var_2_10005.ACTIVITY_TYPE_MONOPOLY and var_3.onAward then
				var_3:onAward(var_84_0.awards, var_84_0.callback)

				goto label_84_0
			end
		end

		if var_84_0.autoFlag then
			local var_84_3 = arg_84_0.viewComponent
			local var_84_4 = var_4.emit

			BaseUI = var_2_10007

			var_84_4(var_84_3, var_2_10007.ON_ACHIEVE_AUTO, var_84_0.awards, 1, var_84_0.callback)
		else
			local var_84_5 = arg_84_0.viewComponent
			local var_84_6 = var_4.emit

			BaseUI = var_2_10007

			var_84_6(var_84_5, var_2_10007.ON_ACHIEVE, var_84_0.awards, var_84_0.callback)
		end

		::label_84_0::

		return
	end
	GAME = var_2
	var_62_0[var_2.SEND_MINI_GAME_OP_DONE] = function(arg_85_0, arg_85_1)
		local var_85_0 = arg_85_1:getBody()
		local var_85_1 = {
			function(arg_86_0)
				if #var_85_0.awards > 0 then
					if arg_85_0.viewComponent then
						local var_86_0 = arg_85_0.viewComponent
						local var_86_1 = var_2.emit

						BaseUI = var_3_10005

						var_86_1(var_86_0, var_3_10005.ON_ACHIEVE, var_1, arg_86_0)
					else
						local var_86_2 = arg_85_0
						local var_86_3 = var_2.emit

						BaseUI = var_3_10005

						var_86_3(var_86_2, var_3_10005.ON_ACHIEVE, var_1, arg_86_0)
					end
				else
					arg_86_0()
				end

				return
			end
		}

		seriesAsync = var_4

		var_4(var_85_1, function()
			local var_87_0 = arg_85_0.viewComponent

			var_0.updateTaskLayers(var_87_0)

			return
		end)

		return
	end
	GAME = var_2
	var_62_0[var_2.ACTIVITY_PERMANENT_START_DONE] = function(arg_88_0, arg_88_1)
		local var_88_0 = arg_88_1:getBody()

		getProxy = var_2_10003
		ActivityPermanentProxy = var_2_10005

		local var_88_1 = var_2_10003(var_2_10005)

		if not var_3.IsNormalActivityId(var_88_1, var_88_0.id) then
			return
		end

		local var_88_2 = arg_88_0.viewComponent

		var_3.verifyTabs(var_88_2, var_88_0.id)

		return
	end
	GAME = var_2
	var_62_0[var_2.ACTIVITY_PERMANENT_FINISH_DONE] = function(arg_89_0, arg_89_1)
		local var_89_0 = arg_89_1:getBody()

		getProxy = var_2_10003
		ActivityPermanentProxy = var_2_10005

		local var_89_1 = var_2_10003(var_2_10005)

		if not var_3.IsNormalActivityId(var_89_1, var_89_0.activity_id) then
			return
		end

		local var_89_2 = arg_89_0.viewComponent
		local var_89_3 = var_3.emit

		ActivityMediator = var_6

		var_89_3(var_89_2, var_6.ACTIVITY_PERMANENT, var_89_0.activity_id)

		return
	end
	GAME = var_2
	var_62_0[var_2.MEMORYBOOK_UNLOCK_AWARD_DONE] = function(arg_90_0, arg_90_1)
		local var_90_0 = arg_90_1:getBody()
		local var_90_1 = arg_90_0.viewComponent
		local var_90_2 = var_3.emit

		BaseUI = var_2_10006

		var_90_2(var_90_1, var_2_10006.ON_ACHIEVE, var_90_0.awards)

		return
	end
	GAME = var_2
	var_62_0[var_2.CHARGE_SUCCESS] = function(arg_91_0, arg_91_1)
		local var_91_0 = arg_91_1:getBody()
		local var_91_1 = arg_91_0.viewComponent

		var_3.updateTaskLayers(var_91_1)

		Goods = var_3

		local var_91_2 = var_3.Create
		local var_91_3 = {
			shop_id = var_91_0.shopId
		}

		Goods = var_6

		local var_91_4 = var_91_2(var_91_3, var_6.TYPE_CHARGE)
		local var_91_5 = arg_91_0.viewComponent

		var_4.OnChargeSuccess(var_91_5, var_91_4)

		return
	end
	GAME = var_2
	var_62_0[var_2.SHOPPING_DONE] = function(arg_92_0, arg_92_1)
		local var_92_0 = arg_92_1:getBody()

		warning = var_2_10003

		var_2_10003("yzh")

		local var_92_1 = arg_92_0.viewComponent
		local var_92_2 = var_3.emit

		BaseUI = var_2_10006

		var_92_2(var_92_1, var_2_10006.ON_ACHIEVE, var_92_0.awards, function()
			local var_93_0 = arg_92_0.viewComponent

			var_0.updateTaskLayers(var_93_0)

			return
		end)

		return
	end
	GAME = var_2
	var_62_0[var_2.ACT_MANUAL_SIGN_DONE] = function(arg_94_0, arg_94_1)
		local var_94_0 = arg_94_1:getBody()
		local var_94_1 = arg_94_0.viewComponent
		local var_94_2 = var_3.emit

		BaseUI = var_2_10006

		var_94_2(var_94_1, var_2_10006.ON_ACHIEVE, var_94_0.awards)

		return
	end
	ActivityProxy = var_2
	var_62_0[var_2.ACTIVITY_SHOP_SHOW_AWARDS] = function(arg_95_0, arg_95_1)
		local var_95_0 = arg_95_1:getBody()
		local var_95_1 = arg_95_0.viewComponent
		local var_95_2 = var_3.emit

		BaseUI = var_2_10006

		var_95_2(var_95_1, var_2_10006.ON_ACHIEVE, var_95_0.awards, function()
			getProxy = var_3_10000
			ActivityProxy = var_3_10002

			local var_96_0 = var_3_10000(var_3_10002)
			local var_96_1 = var_0.getActivityByType

			ActivityConst = var_3_10003

			if var_96_1(var_96_0, var_3_10003.ACTIVITY_TYPE_UR_EXCHANGE) and not var_0:isShow() and var_0:isCorePage(arg_95_0.contextData.coreName) then
				local var_96_2 = arg_95_0.viewComponent

				var_1.removeActivity(var_96_2, var_0.id)
			end

			local var_96_3 = arg_95_0.viewComponent

			var_1.updateTaskLayers(var_96_3)

			existCall = var_1

			var_1(var_95_0.callback)

			return
		end)

		return
	end
	arg_62_0.handleDic = var_62_0

	return
end

function var_0_1.showNextActivity(arg_97_0, arg_97_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	if not var_1_10002(var_1_10004) then
		return
	end

	local var_97_0 = var_2

	if var_2.findNextAutoActivity(var_97_0, arg_97_1) then
		local var_97_1 = var_3.id

		ActivityConst = var_97_0

		if var_97_1 == var_97_0.BLACK_FRIDAY_SIGNIN_ACT_ID then
			arg_97_0.contextData.showByNextAct = true

			local var_97_2 = arg_97_0.viewComponent
			local var_97_3 = var_4.verifyTabs

			ActivityConst = var_1_10007

			var_97_3(var_97_2, var_1_10007.BLACK_FRIDAY_ACT_ID)
		else
			local var_97_4 = arg_97_0.viewComponent

			var_4.verifyTabs(var_97_4, var_3.id)
		end

		local var_97_5 = var_3
		local var_97_6 = var_3.getConfig(var_97_5, "type")

		ActivityConst = var_5

		local var_97_7

		if var_97_6 == var_5.ACTIVITY_TYPE_7DAYSLOGIN then
			var_1_10007 = arg_97_0
			var_97_7 = arg_97_0.sendNotification
			GAME = var_1_10008

			var_97_7(var_1_10007, var_1_10008.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = var_3.id
			})
		else
			ActivityConst = var_97_7

			local var_97_8

			if var_97_6 == var_97_7.ACTIVITY_TYPE_MONTHSIGN then
				var_1_10007 = var_3
				var_97_8 = var_3.getSpecialData(var_1_10007, "reMonthSignDay") ~= nil and 3 or 1
				var_1_10008 = arg_97_0
				var_97_5 = arg_97_0.sendNotification
				GAME = var_1_10009

				var_97_5(var_1_10008, var_1_10009.ACTIVITY_OPERATION, {
					activity_id = var_3.id,
					cmd = var_97_8,
					arg1 = var_3:getSpecialData("reMonthSignDay")
				})
			else
				ActivityConst = var_97_8

				if var_97_6 == var_97_8.ACTIVITY_TYPE_PROGRESSLOGIN then
					var_1_10007 = arg_97_0

					local var_97_9 = arg_97_0.sendNotification

					GAME = var_1_10008

					var_97_9(var_1_10007, var_1_10008.ACTIVITY_OPERATION, {
						activity_id = var_3.id,
						cmd = var_3.data1 < 7 and 1 or 2
					})
				else
					local var_97_10 = var_3.id

					ActivityConst = var_97_5

					if var_97_10 == var_97_5.SHADOW_PLAY_ID then
						var_3.clientData1 = 1
						var_1_10007 = arg_97_0

						arg_97_0.showNextActivity(var_1_10007, arg_97_1)
					end
				end
			end
		end

		goto label_97_0
	end

	if not arg_97_0.viewComponent.activity then
		local var_97_11 = arg_97_0:getDisplayActivity()

		if not arg_97_0.contextData.id then
			if arg_97_0.contextData.type then
				checkExist = var_97_12
				_ = var_1_10007

				do
					local var_97_12

					if not var_97_12(var_1_10007.detect(var_97_11, function(arg_98_0)
						return arg_98_0:getConfig("type") == arg_97_0.contextData.type
					end), {
						"id"
					}) then
						var_97_12 = 0
					end

					local var_97_13 = arg_97_0.viewComponent

					var_6.verifyTabs(var_97_13, var_97_12)
				end

				::label_97_0::

				return
			end
		end
	end
end

return var_0_1
