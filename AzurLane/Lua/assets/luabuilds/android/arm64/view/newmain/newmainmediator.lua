class = var_0_10000

local var_0_0 = "NewMainMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.GO_SCENE = "NewMainMediator.GO_SCENE"
var_0_1.OPEN_MAIL = "NewMainMediator.OPEN_MAIL"
var_0_1.OPEN_NOTICE = "NewMainMediator.OPEN_NOTICE"
var_0_1.GO_SNAPSHOT = "NewMainMediator.GO_SNAPSHOT"
var_0_1.OPEN_COMMISION = "NewMainMediator.OPEN_COMMISION"
var_0_1.OPEN_CHATVIEW = "NewMainMediator.OPEN_CHATVIEW"
var_0_1.SKIP_SCENE = "NewMainMediator.SKIP_SCENE"
var_0_1.SKIP_ACTIVITY = "NewMainMediator.SKIP_ACTIVITY"
var_0_1.SKIP_CORE_ACTIVITY = "NewMainMediator.SKIP_CORE_ACTIVITY"
var_0_1.SKIP_SHOP = "NewMainMediator.SKIP_SHOP"
var_0_1.GO_MINI_GAME = "NewMainMediator.GO_MINI_GAME"
var_0_1.SKIP_ACTIVITY_MAP = "NewMainMediator.SKIP_ACTIVITY_MAP"
var_0_1.SKIP_ESCORT = "NewMainMediator.SKIP_ESCORT"
var_0_1.SKIP_INS = "NewMainMediator.SKIP_INS"
var_0_1.SKIP_LOTTERY = "NewMainMediator.SKIP_LOTTERY"
var_0_1.GO_SINGLE_ACTIVITY = "NewMainMediator.GO_SINGLE_ACTIVITY"
var_0_1.REFRESH_VIEW = "NewMainMediator.REFRESH_VIEW"
var_0_1.OPEN_KINK_BUTTON_LAYER = "NewMainMediator.OPEN_KINK_BUTTON_LAYER"
var_0_1.OPEN_Compensate = "NewMainMediator.OPEN_Compensate"
var_0_1.ON_DROP = "NewMainMediator.ON_DROP"
var_0_1.ON_AWRADS = "NewMainMediator.ON_AWRADS"
var_0_1.CHANGE_SKIN_TOGGLE = "NewMainMediator.CHANGE_SKIN_TOGGLE"
var_0_1.FOLD_PANEL = "NewMainMediator.FOLD_PANEL"
var_0_1.HIDE_PANEL = "NewMainMediator.HIDE_PANEL"
var_0_1.REMOVE_LAYERS = "NewMainMediator.REMOVE_LAYERS"
var_0_1.DEBUG_BATTLE_LOOP = "NewMainMediator.DEBUG_BATTLE_LOOP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SKIP_LOTTERY, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_2_2 = var_2_10005.New
		local var_2_3 = {}

		LotteryLayer = var_2_10008
		var_2_3.viewComponent = var_2_10008
		LotteryMediator = var_2_10008
		var_2_3.mediator = var_2_10008
		var_2_3.data = {
			activityId = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.SKIP_INS, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_3_2 = var_2_10004.New
		local var_3_3 = {}

		InstagramMainUI = var_2_10007
		var_3_3.viewComponent = var_2_10007
		InstagramMainMediator = var_2_10007
		var_3_3.mediator = var_2_10007

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.SKIP_ESCORT, function(arg_4_0)
		getProxy = var_2_10001
		ChapterProxy = var_2_10003

		local var_4_0 = var_2_10001(var_2_10003)
		local var_4_1 = var_1.getMapsByType

		Map = var_2_10005

		local var_4_2 = var_4_1(var_4_0, var_2_10005.ESCORT)[1]
		local var_4_3 = var_1:getActiveChapter()

		pg = var_4_0

		local var_4_4 = var_4_0.m02
		local var_4_5 = var_4.sendNotification

		GAME = var_2_10007

		local var_4_6 = var_2_10007.GO_SCENE

		SCENE = var_2_10008

		local var_4_7 = var_2_10008.LEVEL
		local var_4_8 = {}
		local var_4_9

		if not var_4_3 or var_4_3:getConfig("map") ~= var_4_2.id or not var_4_3.id then
			var_4_9 = nil
		end

		var_4_8.chapterId = var_4_9
		var_4_8.mapIdx = var_4_2.id

		var_4_5(var_4_4, var_4_6, var_4_7, var_4_8)

		return
	end)
	arg_1_0:bind(var_0_1.SKIP_ACTIVITY_MAP, function(arg_5_0, arg_5_1)
		getProxy = var_2_10002
		ChapterProxy = var_2_10004

		local var_5_0 = var_2_10002(var_2_10004)
		local var_5_1, var_5_2 = var_2.getLastMapForActivity(var_5_0, arg_5_1)

		if var_5_1 then
			local var_5_3 = var_2:getMapById(var_5_1)

			if not var_5_0.isUnlock(var_5_3) then
				pg = var_5_0

				local var_5_4 = var_5_0.TipsMgr.GetInstance()
				local var_5_5 = var_5.ShowTips

				i18n = var_2_10008

				var_5_5(var_5_4, var_2_10008("common_activity_end"))
			else
				local var_5_6 = arg_1_0
				local var_5_7 = var_5.sendNotification

				GAME = var_2_10008

				local var_5_8 = var_2_10008.GO_SCENE

				SCENE = var_2_10009

				var_5_7(var_5_6, var_5_8, var_2_10009.LEVEL, {
					chapterId = var_5_2,
					mapIdx = var_5_1
				})
			end

			return
		end
	end)
	arg_1_0:bind(var_0_1.SKIP_SHOP, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_6_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		local var_6_3 = var_2_10006.SHOP
		local var_6_4 = {}

		if not arg_6_1 then
			::label_6_0::

			NewShopsScene = var_2_10008
			var_2_10008 = var_2_10008.TYPE_ACTIVITY
		end

		var_6_4.warp = var_2_10008

		var_6_1(var_6_0, var_6_2, var_6_3, var_6_4)

		return
	end)
	arg_1_0:bind(var_0_1.SKIP_ACTIVITY, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_7_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_7_1(var_7_0, var_7_2, var_2_10006.ACTIVITY, {
			id = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.SKIP_CORE_ACTIVITY, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_8_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_8_1(var_8_0, var_8_2, var_2_10006.CORE_ACTIVITY, {
			coreName = arg_8_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.SKIP_SCENE, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10005

		var_9_1(var_9_0, var_2_10005.GO_SCENE, arg_9_1[1], arg_9_1[2])

		return
	end)
	arg_1_0:bind(var_0_1.GO_MINI_GAME, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.sendNotification

		GAME = var_2_10005

		var_10_1(var_10_0, var_2_10005.GO_MINI_GAME, arg_10_1)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = arg_1_0
		local var_11_1 = var_3.sendNotification

		GAME = var_2_10006

		var_11_1(var_11_0, var_2_10006.GO_SCENE, arg_11_1, arg_11_2)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SNAPSHOT, function(arg_12_0)
		local var_12_0 = arg_1_0.viewComponent.bgView.ship
		local var_12_1 = var_1.getSkinId(var_12_0)
		local var_12_2 = arg_1_0.viewComponent.paintingView
		local var_12_3 = var_3.IsLive2DState(var_12_2)
		local var_12_4

		isa = var_12_2

		local var_12_5 = var_1

		VirtualEducateCharShip = var_2_10008

		if var_12_2(var_12_5, var_2_10008) then
			var_12_4 = var_1.educateCharId
			var_12_3 = false
		end

		local var_12_6 = arg_1_0
		local var_12_7 = var_5.sendNotification

		GAME = var_2_10008

		local var_12_8 = var_2_10008.GO_SCENE

		SCENE = var_2_10009

		var_12_7(var_12_6, var_12_8, var_2_10009.SNAPSHOT, {
			skinId = var_12_1,
			live2d = var_12_3,
			tbId = var_12_4,
			propose = var_1.propose
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_MAIL, function(arg_13_0)
		BATTLE_DEBUG = var_2_10001

		if var_2_10001 then
			local var_13_0 = arg_1_0
			local var_13_1 = var_1.sendNotification

			GAME = var_2_10004
			var_2_10004 = var_2_10004.BEGIN_STAGE
			var_2_10005 = {}
			SYSTEM_DEBUG = var_2_10006
			var_2_10005.system = var_2_10006

			var_13_1(var_13_0, var_2_10004, var_2_10005)
		else
			local var_13_2 = arg_1_0
			local var_13_3 = var_1.sendNotification

			GAME = var_2_10004

			local var_13_4 = var_2_10004.GO_SCENE

			SCENE = var_2_10005

			var_13_3(var_13_2, var_13_4, var_2_10005.MAIL)
		end

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_Compensate, function(arg_14_0)
		local var_14_0 = arg_1_0
		local var_14_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_14_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_14_1(var_14_0, var_14_2, var_2_10005.Compensate)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_NOTICE, function(arg_15_0)
		local var_15_0 = arg_1_0
		local var_15_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_15_2 = var_2_10004.New
		local var_15_3 = {}

		NewBulletinBoardMediator = var_2_10007
		var_15_3.mediator = var_2_10007
		NewBulletinBoardLayer = var_2_10007
		var_15_3.viewComponent = var_2_10007

		var_15_1(var_15_0, var_15_2(var_15_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_COMMISION, function(arg_16_0)
		local var_16_0 = arg_1_0
		local var_16_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_16_2 = var_2_10004.New
		local var_16_3 = {}

		CommissionInfoLayer = var_2_10007
		var_16_3.viewComponent = var_2_10007
		CommissionInfoMediator = var_2_10007
		var_16_3.mediator = var_2_10007

		var_16_1(var_16_0, var_16_2(var_16_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHATVIEW, function(arg_17_0)
		local var_17_0 = arg_1_0
		local var_17_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_17_2 = var_2_10004.New
		local var_17_3 = {}

		NotificationLayer = var_2_10007
		var_17_3.viewComponent = var_2_10007
		NotificationMediator = var_2_10007
		var_17_3.mediator = var_2_10007

		local var_17_4 = {}

		NotificationLayer = var_2_10008
		var_17_4.form = var_2_10008.FORM_MAIN
		var_17_3.data = var_17_4

		var_17_1(var_17_0, var_17_2(var_17_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_KINK_BUTTON_LAYER, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_1_0

		var_2.addSubLayers(var_18_0, arg_18_1)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_SKIN_TOGGLE, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_1_0
		local var_19_1 = var_2.sendNotification

		GAME = var_2_10005

		var_19_1(var_19_0, var_2_10005.CHANGE_SKIN_AB, arg_19_1)

		return
	end)
	arg_1_0:bind(var_0_1.DEBUG_BATTLE_LOOP, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_1_0
		local var_20_1 = var_2.sendNotification

		GAME = var_2_10005

		var_20_1(var_20_0, var_2_10005.SEND_CMD, {
			cmd = "into",
			arg1 = arg_20_1
		})

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_21_0)
	local var_21_0 = {}

	GAME = var_1_10002
	var_21_0[var_1_10002.ON_OPEN_INS_LAYER] = function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0.viewComponent

		var_2.emit(var_22_0, var_0_1.SKIP_INS)

		return
	end
	NotificationProxy = var_2
	var_21_0[var_2.FRIEND_REQUEST_ADDED] = function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_0.viewComponent
		local var_23_1 = var_2.emit

		GAME = var_2_10005

		var_23_1(var_23_0, var_2_10005.ANY_CHAT_MSG_UPDATE)

		return
	end
	NotificationProxy = var_2

	local var_21_1 = var_2.FRIEND_REQUEST_REMOVED

	NotificationProxy = var_3
	var_21_0[var_21_1] = var_3.FRIEND_REQUEST_ADDED
	FriendProxy = var_21_1

	local var_21_2 = var_21_1.FRIEND_NEW_MSG

	NotificationProxy = var_3
	var_21_0[var_21_2] = var_3.FRIEND_REQUEST_ADDED
	FriendProxy = var_21_2

	local var_21_3 = var_21_2.FRIEND_UPDATED

	NotificationProxy = var_3
	var_21_0[var_21_3] = var_3.FRIEND_REQUEST_ADDED
	ChatProxy = var_21_3

	local var_21_4 = var_21_3.NEW_MSG

	NotificationProxy = var_3
	var_21_0[var_21_4] = var_3.FRIEND_REQUEST_ADDED
	GuildProxy = var_21_4

	local var_21_5 = var_21_4.NEW_MSG_ADDED

	NotificationProxy = var_3
	var_21_0[var_21_5] = var_3.FRIEND_REQUEST_ADDED
	GAME = var_21_5

	local var_21_6 = var_21_5.GET_GUILD_INFO_DONE

	NotificationProxy = var_3
	var_21_0[var_21_6] = var_3.FRIEND_REQUEST_ADDED
	GAME = var_21_6

	local var_21_7 = var_21_6.GET_GUILD_CHAT_LIST_DONE

	NotificationProxy = var_3
	var_21_0[var_21_7] = var_3.FRIEND_REQUEST_ADDED
	GAME = var_21_7
	var_21_0[var_21_7.BEGIN_STAGE_DONE] = function(arg_24_0, arg_24_1)
		local var_24_0 = arg_24_0
		local var_24_1 = arg_24_0.sendNotification

		GAME = var_2_10005

		local var_24_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_24_1(var_24_0, var_24_2, var_2_10006.COMBATLOAD, arg_24_1:getBody())

		return
	end
	ChapterProxy = var_2
	var_21_0[var_2.CHAPTER_TIMESUP] = function(arg_25_0, arg_25_1)
		MainChapterTimeUpSequence = var_2_10002

		local var_25_0 = var_2_10002.New()

		var_2.Execute(var_25_0)

		return
	end
	TechnologyConst = var_2
	var_21_0[var_2.UPDATE_REDPOINT_ON_TOP] = function(arg_26_0, arg_26_1)
		MainTechnologySequence = var_2_10002

		local var_26_0 = var_2_10002.New()

		var_2.Execute(var_26_0, function()
			return
		end)

		return
	end
	GAME = var_2
	var_21_0[var_2.FETCH_NPC_SHIP_DONE] = function(arg_28_0, arg_28_1)
		local var_28_0 = arg_28_1:getBody()
		local var_28_1 = arg_28_0.viewComponent
		local var_28_2 = var_3.emit

		BaseUI = var_2_10006

		var_28_2(var_28_1, var_2_10006.ON_ACHIEVE, var_28_0.items, var_28_0.callback)

		return
	end
	GAME = var_2

	local var_21_8 = var_2.FETCH_NPC_SHIP_ACTIVITY_DONE

	GAME = var_3
	var_21_0[var_21_8] = var_3.FETCH_NPC_SHIP_DONE
	var_21_0[var_0_1.REFRESH_VIEW] = function(arg_29_0, arg_29_1)
		local var_29_0 = arg_29_0.viewComponent

		var_2.setVisible(var_29_0, false)

		local var_29_1 = arg_29_0.viewComponent

		var_2.setVisible(var_29_1, true)

		return
	end
	GAME = var_2
	var_21_0[var_2.CONFIRM_GET_SHIP] = function(arg_30_0, arg_30_1)
		local var_30_0 = arg_30_1:getBody()
		local var_30_1 = arg_30_0
		local var_30_2 = arg_30_0.addSubLayers

		Context = var_2_10006

		local var_30_3 = var_2_10006.New
		local var_30_4 = {}

		BuildShipRemindMediator = var_2_10009
		var_30_4.mediator = var_2_10009
		BuildShipRemindLayer = var_2_10009
		var_30_4.viewComponent = var_2_10009
		var_30_4.data = {
			ships = var_30_0.ships
		}
		var_30_4.onRemoved = var_30_0.callback

		var_30_2(var_30_1, var_30_3(var_30_4))

		return
	end
	GAME = var_2
	var_21_0[var_2.CHANGE_LIVINGAREA_COVER_DONE] = function(arg_31_0, arg_31_1)
		local var_31_0 = arg_31_0.viewComponent
		local var_31_1 = var_2.emit

		NewMainScene = var_2_10005

		var_31_1(var_31_0, var_2_10005.UPDATE_COVER)

		return
	end
	GAME = var_2
	var_21_0[var_2.ACT_INSTAGRAM_CHAT_DONE] = function(arg_32_0, arg_32_1)
		local var_32_0 = arg_32_1
		local var_32_1 = arg_32_1.getBody(var_32_0).operation

		ActivityConst = var_32_0

		if var_32_1 == var_32_0.INSTAGRAM_CHAT_ACTIVATE_TOPIC then
			local var_32_2 = arg_32_0.viewComponent
			local var_32_3 = var_3.GetFlagShip(var_32_2)

			if arg_32_0.viewComponent.theme then
				local var_32_4 = arg_32_0.viewComponent.theme

				var_4.Refresh(var_32_4, var_32_3)
			end
		end

		return
	end
	NewMainMediator = var_2
	var_21_0[var_2.ON_DROP] = function(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_0.viewComponent
		local var_33_1 = var_2.emit

		BaseUI = var_2_10005

		var_33_1(var_33_0, var_2_10005.ON_DROP, arg_33_1:getBody())

		return
	end
	NewMainMediator = var_2
	var_21_0[var_2.ON_AWRADS] = function(arg_34_0, arg_34_1)
		local var_34_0 = arg_34_1:getBody()
		local var_34_1 = arg_34_0.viewComponent
		local var_34_2 = var_3.emit

		BaseUI = var_2_10006

		var_34_2(var_34_1, var_2_10006.ON_ACHIEVE, var_34_0.items, var_34_0.callback)

		return
	end
	GAME = var_2
	var_21_0[var_2.PLAY_CHANGE_SKIN_OUT] = function(arg_35_0, arg_35_1)
		local var_35_0 = arg_35_0.viewComponent

		var_2.SetEffectPanelVisible(var_35_0, false)

		local var_35_1 = arg_35_0.viewComponent

		var_2.HidePanel(var_35_1, true)

		local var_35_2 = arg_35_0.viewComponent

		var_2.PlayChangeSkinActionOut(var_35_2, arg_35_1:getBody())

		return
	end
	GAME = var_2
	var_21_0[var_2.PLAY_CHANGE_SKIN_IN] = function(arg_36_0, arg_36_1)
		local var_36_0 = arg_36_0.viewComponent

		var_2.PlayChangeSkinActionIn(var_36_0, arg_36_1:getBody())

		return
	end
	GAME = var_2
	var_21_0[var_2.PLAY_CHANGE_SKIN_FINISH] = function(arg_37_0, arg_37_1)
		local var_37_0 = arg_37_0.viewComponent

		var_2.SetEffectPanelVisible(var_37_0, true)

		local var_37_1 = arg_37_0.viewComponent

		var_2.HidePanel(var_37_1, false)

		return
	end
	GAME = var_2
	var_21_0[var_2.CHANGE_SKIN_EXCHANGE] = function(arg_38_0, arg_38_1)
		local var_38_0 = arg_38_1:getBody().asmr and true or false
		local var_38_1 = arg_38_0.viewComponent
		local var_38_2 = var_4.GetFlagShip(var_38_1)

		if arg_38_0.viewComponent then
			local var_38_3 = arg_38_0.viewComponent

			var_5.UpdateFlagShip(var_38_3, var_38_2, var_2)
		end

		local var_38_4 = arg_38_0.viewComponent

		var_5.AsmrTurning(var_38_4, var_38_0)

		return
	end
	MusicPlayer = var_2
	var_21_0[var_2.NO_PLAY_MUSIC_NOTIFICATION] = function(arg_39_0, arg_39_1)
		local var_39_0 = arg_39_0.viewComponent

		var_2.CheckAndReplayBgm(var_39_0)

		return
	end
	NewMainMediator = var_2
	var_21_0[var_2.FOLD_PANEL] = function(arg_40_0, arg_40_1)
		local var_40_0 = arg_40_0.viewComponent

		var_2.FoldPanels(var_40_0, arg_40_1:getBody())

		return
	end
	NewMainMediator = var_2
	var_21_0[var_2.HIDE_PANEL] = function(arg_41_0, arg_41_1)
		local var_41_0 = arg_41_0.viewComponent

		var_2.HidePanel(var_41_0, arg_41_1:getBody())

		return
	end
	GAME = var_2
	var_21_0[var_2.SERIES_GUIDE_END] = function(arg_42_0, arg_42_1)
		MainAwakeGuideSequence = var_2_10002

		local var_42_0 = var_2_10002.New()

		var_2.Execute(var_42_0, function()
			return
		end)

		return
	end
	var_21_0[var_0_1.DEBUG_BATTLE_LOOP] = function(arg_44_0, arg_44_1)
		local var_44_0 = arg_44_1:getBody()

		arg_44_0:BuildDebugBattleLoop(var_44_0)

		return
	end
	GAME = var_2
	var_21_0[var_2.REMOVE_LAYERS] = function(arg_45_0, arg_45_1)
		local var_45_0 = arg_45_1:getBody().context
		local var_45_1 = arg_45_0.viewComponent
		local var_45_2 = var_3.emit

		NewMainMediator = var_2_10006

		var_45_2(var_45_1, var_2_10006.REMOVE_LAYERS, arg_45_1:getBody())

		return
	end
	PlayerProxy = var_2
	var_21_0[var_2.UPDATED] = function(arg_46_0, arg_46_1)
		local var_46_0 = arg_46_0.viewComponent

		var_2.OnPlayerUpdated(var_46_0)

		return
	end
	ActivityProxy = var_2
	var_21_0[var_2.UPDATED_TIP] = function(arg_47_0, arg_47_1)
		local var_47_0 = arg_47_0.viewComponent
		local var_47_1 = var_2.emit

		MainBaseActivityBtn = var_2_10005

		var_47_1(var_47_0, var_2_10005.UPDATED_TIP)

		return
	end
	arg_21_0.handleDic = var_21_0

	return
end

function var_0_1.BuildDebugBattleLoop(arg_48_0, arg_48_1)
	IsUnityEditor = var_1_10002

	if not var_1_10002 then
		return
	end

	local var_48_0 = {}

	for iter_48_0, iter_48_1 in arg_48_1:gmatch("%s+(%S+)") do
		table = var_1_10008

		var_1_10008.insert(var_48_0, iter_48_0)
	end

	local var_48_1 = {}

	tonumber = var_4
	var_48_1.loopCount = var_4(var_48_0[2])
	underscore = var_4
	var_48_1.loopStages = var_4.rest(var_48_0, 3)
	var_48_1.tempList = {}
	_G = var_4
	var_4.InDebugBattleLoop = var_48_1

	local var_48_2 = arg_48_0.viewComponent

	var_4.CheckDebugBattleLoop(var_48_2)

	return
end

return var_0_1
