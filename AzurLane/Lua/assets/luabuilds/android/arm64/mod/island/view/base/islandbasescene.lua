class = var_0_10000

local var_0_0 = "IslandBaseScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.ON_SCENE_LOADED = "IslandBaseScene:ON_SCENE_LOADED"
var_0_1.LINK_CORE_EVENT = "IslandBaseScene:LINK_CORE_EVENT"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	IslandSceneMgr = var_1
	arg_1_0.sceneMgr = var_1.New(arg_1_0)
	arg_1_0.__callbacks__ = {}
	arg_1_0.showBalance = 1
	arg_1_0.cacheAbList = {
		"ui/islandui_atlas",
		"ui/islandcommonui_atlas",
		"island/IslandInteractionBtns"
	}

	return
end

function var_0_1.getDefaultUI(arg_2_0)
	return arg_2_0._container
end

function var_0_1.DontGC(arg_3_0)
	return true
end

function var_0_1.forceGC(arg_4_0)
	return false
end

function var_0_1.GCWhenAwake(arg_5_0)
	return false
end

function var_0_1.PlayBGM(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.BgmMgr.GetInstance()

	var_1.StopPlay(var_6_0)

	return
end

function var_0_1.preload(arg_7_0, arg_7_1)
	local var_7_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_7_0, function(arg_8_0)
		local var_8_0 = arg_7_0

		var_1.LoadUIContainer(var_8_0, arg_8_0)

		return
	end)

	table = var_3

	var_3.insert(var_7_0, function(arg_9_0)
		local var_9_0 = arg_7_0

		IslandPoolMgr = var_2_10002
		var_9_0.poolMgr = var_2_10002.New(arg_7_0.poolContainer)

		local var_9_1 = arg_7_0.poolMgr

		var_1.Init(var_9_1, arg_9_0)

		return
	end)

	ipairs = var_3

	for iter_7_0, iter_7_1 in var_3(arg_7_0.cacheAbList) do
		table = var_1_10008

		var_1_10008.insert(var_7_0, function(arg_10_0)
			AssetBundleHelper = var_2_10001

			var_2_10001.StoreAssetBundle(iter_7_1, true, false, function(arg_11_0)
				arg_10_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_7_0, arg_7_1)

	return
end

function var_0_1.LoadUIContainer(arg_12_0, arg_12_1)
	ResourceMgr = var_1_10002

	local var_12_0 = var_1_10002.Inst
	local var_12_1 = var_2.getAssetAsync
	local var_12_2 = "UI/UIIsland"
	local var_12_3 = ""

	typeof = var_1_10007
	GameObject = var_1_10009

	local var_12_4 = var_1_10007(var_1_10009)

	UnityEngine = var_1_10008

	var_12_1(var_12_0, var_12_2, var_12_3, var_12_4, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_13_0)
		IslandHelper = var_2_10001

		var_2_10001.InstantiateAsyncGameObject(arg_13_0, function(arg_14_0)
			arg_12_0._container = arg_14_0.transform

			local var_14_0 = arg_12_0

			GetOrAddComponent = var_2

			local var_14_1 = arg_12_0._container

			typeof = var_3_10005
			CanvasGroup = var_3_10007
			var_14_0.canvasGroup = var_2(var_14_1, var_3_10005(var_3_10007))

			local var_14_2 = arg_12_0
			local var_14_3 = arg_12_0._container

			var_14_2.uiLayer1 = var_2.Find(var_14_3, "layer1")

			local var_14_4 = arg_12_0
			local var_14_5 = arg_12_0._container

			var_14_4.uiLayer2 = var_2.Find(var_14_5, "layer2")

			local var_14_6 = arg_12_0
			local var_14_7 = arg_12_0._container

			var_14_6.uiContainer = var_2.Find(var_14_7, "layer1/ui")

			local var_14_8 = arg_12_0
			local var_14_9 = arg_12_0._container

			var_14_8.opContainer = var_2.Find(var_14_9, "layer1/op")

			local var_14_10 = arg_12_0
			local var_14_11 = arg_12_0._container

			var_14_10.pageContainer = var_2.Find(var_14_11, "layer1/page")

			local var_14_12 = arg_12_0
			local var_14_13 = arg_12_0._container

			var_14_12.poolContainer = var_2.Find(var_14_13, "_pool_")

			local var_14_14 = arg_12_0._container

			var_14_14.name = "UIIsland"
			setParent = var_14_14

			local var_14_15 = arg_12_0._container

			pg = var_14_13

			var_14_14(var_14_15, var_14_13.UIMgr.GetInstance().UICanvas)
			arg_12_1()

			return
		end)

		return
	end), true, true)

	return
end

function var_0_1.SetUIParent(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.transform

	var_2.SetParent(var_15_0, arg_15_0.uiContainer, false)

	return
end

function var_0_1.emit(arg_16_0, arg_16_1, ...)
	BaseUI = var_1_10002

	if arg_16_1 ~= var_1_10002.ON_HOME then
		IslandMediator = var_2

		if arg_16_1 == var_2.CHANGE_SCENE then
			ISLAND_PLAYER_TESTING = var_2

			if var_2 then
				pg = var_2

				local var_16_0 = var_2.TipsMgr.GetInstance()
				local var_16_1 = var_2.ShowTips

				i18n = var_1_10005

				var_16_1(var_16_0, var_1_10005("island_home_btn_cant_use"))

				return
			end

			arg_16_0:ExitProcess(arg_16_1, nil, ...)
		else
			var_0_1.super.emit(arg_16_0, arg_16_1, ...)
		end

		return
	end
end

function var_0_1.emitCoreController(arg_17_0, arg_17_1, ...)
	arg_17_0:emit(var_0_1.LINK_CORE_EVENT, arg_17_1, ...)

	return
end

function var_0_1.emitCore(arg_18_0, arg_18_1, ...)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.emit
	local var_18_2 = var_0_1.LINK_CORE_EVENT

	IslandProxy = var_1_10006

	var_18_1(var_18_0, var_18_2, var_1_10006.LINK_CORE, arg_18_1, ...)

	return
end

function var_0_1.ExitProcess(arg_19_0, arg_19_1, arg_19_2, ...)
	packEx = var_1_10003

	local var_19_0 = var_1_10003(...)
	local var_19_1 = arg_19_0:GetIsland()

	seriesAsync = var_5

	var_5({
		function(arg_20_0)
			local var_20_0 = arg_19_0
			local var_20_1 = var_1.emit

			IslandBaseMediator = var_2_10004

			var_20_1(var_20_0, var_2_10004.RECORD_PLAYER_POS)

			pg = var_20_1

			local var_20_2 = var_20_1.m02
			local var_20_3 = var_1.sendNotification

			GAME = var_4

			var_20_3(var_20_2, var_4.ISLAND_EXIT, {
				id = var_19_1.id,
				callback = arg_20_0
			})

			return
		end
	}, function()
		local var_21_0 = var_0_1.super.emit
		local var_21_1 = arg_19_0
		local var_21_2 = arg_19_1

		unpackEx = var_2_10004

		var_21_0(var_21_1, var_21_2, var_2_10004(var_19_0))

		if arg_19_2 then
			arg_19_2()
		end

		return
	end)

	return
end

function var_0_1.GetIsland(arg_22_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me !!!!")

	return
end

function var_0_1.onUILoaded(arg_23_0, arg_23_1)
	var_0_1.super.onUILoaded(arg_23_0, arg_23_1)

	local var_23_0 = {}

	IslandMsgBox = var_1_10003

	local var_23_1 = var_1_10003.New

	pg = var_5
	var_23_0[1] = var_23_1(var_5.UIMgr.GetInstance().OverlayMain, arg_23_0.event)
	IslandToast = var_3

	local var_23_2 = var_3.New

	pg = var_5
	var_23_0[2] = var_23_2(var_5.UIMgr.GetInstance().OverlayToast, arg_23_0.event)
	IslandStoryMgr = var_3

	local var_23_3 = var_3.New

	pg = var_5
	var_23_0[3] = var_23_3(var_5.UIMgr.GetInstance().OverlayToast, arg_23_0.event)
	IslandAwardDisplayPage = var_3

	local var_23_4 = var_3.New

	pg = var_5
	var_23_0[4] = var_23_4(var_5.UIMgr.GetInstance().OverlayToast, arg_23_0.event)
	IslandQueueUpMsgBox = var_3

	local var_23_5 = var_3.New

	pg = var_5
	var_23_0[5] = var_23_5(var_5.UIMgr.GetInstance().OverlayToast, arg_23_0.event)
	IslandTimelineMgr = var_3

	local var_23_6 = var_3.New
	local var_23_7 = arg_23_0:GetPoolMgr()

	pg = var_6
	var_23_0[6] = var_23_6(var_23_7, var_6.UIMgr.GetInstance().OverlayToast, arg_23_0.event)
	Island3dTaskAcceptPage = var_3

	local var_23_8 = var_3.New

	pg = var_23_7
	var_23_0[7] = var_23_8(var_23_7.UIMgr.GetInstance().OverlayToast, arg_23_0.event)
	IslandSystemUnlockPage = var_3

	local var_23_9 = var_3.New

	pg = var_5
	var_23_0[8] = var_23_9(var_5.UIMgr.GetInstance().OverlayToast, arg_23_0.event)
	arg_23_0.subViews = var_23_0

	local var_23_10 = {}

	IslandPlayerDataMonitor = var_3
	var_23_10[1] = var_3.New(arg_23_0:GetIsland())
	IslandSyncDataMonitor = var_3
	var_23_10[2] = var_3.New(arg_23_0:GetIsland())
	IslandCheaterTavernMonitor = var_3
	var_23_10[3] = var_3.New(arg_23_0:GetIsland())
	arg_23_0.monitors = var_23_10
	IslandPoppingQueue = var_23_10
	arg_23_0.poppingQueue = var_23_10.New(arg_23_0)

	arg_23_0:AddCommonListeners()
	arg_23_0:AddListeners()

	pairs = var_2

	for iter_23_0, iter_23_1 in var_2(arg_23_0.subViews) do
		iter_23_1:RegisterView(arg_23_0)
	end

	return
end

function var_0_1.AddCommonListeners(arg_24_0)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.AddListener

	ISLAND_EX_EVT = var_1_10004

	var_24_1(var_24_0, var_1_10004.EMIT, arg_24_0.OnEmit)

	local var_24_2 = arg_24_0
	local var_24_3 = arg_24_0.AddListener

	ISLAND_EX_EVT = var_4

	var_24_3(var_24_2, var_4.INIT_FINISH, arg_24_0.OnSceneLoaded)

	local var_24_4 = arg_24_0
	local var_24_5 = arg_24_0.AddListener

	ISLAND_EX_EVT = var_4

	var_24_5(var_24_4, var_4.SHOW_MSG, arg_24_0.OnShowMsgBox)

	local var_24_6 = arg_24_0
	local var_24_7 = arg_24_0.AddListener

	ISLAND_EX_EVT = var_4

	var_24_7(var_24_6, var_4.OPEN_PAGE, arg_24_0.OnOpenPage)

	local var_24_8 = arg_24_0
	local var_24_9 = arg_24_0.AddListener

	ISLAND_EX_EVT = var_4

	var_24_9(var_24_8, var_4.PLAY_TIMELINE, arg_24_0.OnPlayTimeline)
	arg_24_0:AddListener(var_0_1.LINK_CORE_EVENT, arg_24_0.OnLinkCoreEvent)

	local var_24_10 = arg_24_0
	local var_24_11 = arg_24_0.AddListener

	ISLAND_EX_EVT = var_4

	var_24_11(var_24_10, var_4.OPEN_ANIMATION_OP, arg_24_0.OnOpenAnimatonOpPage)

	local var_24_12 = arg_24_0
	local var_24_13 = arg_24_0.AddListener

	ISLAND_EX_EVT = var_4

	var_24_13(var_24_12, var_4.CLOSE_ANIMATION_OP, arg_24_0.OnCloseAnimatonOpPage)

	return
end

function var_0_1.GetSubView(arg_25_0, arg_25_1)
	ipairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0.subViews) do
		isa = var_1_10007

		if var_1_10007(iter_25_1, arg_25_1) then
			return iter_25_1
		end
	end

	return nil
end

function var_0_1.GetPoolMgr(arg_26_0)
	return arg_26_0.poolMgr
end

function var_0_1.OnOpenAnimatonOpPage(arg_27_0)
	return
end

function var_0_1.OnCloseAnimatonOpPage(arg_28_0)
	return
end

function var_0_1.OnLinkCoreEvent(arg_29_0, arg_29_1, ...)
	local var_29_0 = arg_29_0:GetIsland()

	var_2.DispatchEvent(var_29_0, arg_29_1, ...)

	return
end

function var_0_1.OnSetUpCore(arg_30_0, arg_30_1, arg_30_2)
	return
end

function var_0_1.OnOpenPage(arg_31_0, arg_31_1, ...)
	arg_31_0:OpenPage(arg_31_1, ...)

	return
end

function var_0_1.OnShowMsgBox(arg_32_0, arg_32_1)
	arg_32_0:ShowMsgbox(arg_32_1)

	return
end

function var_0_1.OnPlayTimeline(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_0:PlayTimeline(arg_33_1, arg_33_2, arg_33_3)

	return
end

function var_0_1.OnSceneLoaded(arg_34_0)
	arg_34_0:emit(var_0_1.ON_SCENE_LOADED)

	return
end

function var_0_1.OnEmit(arg_35_0, arg_35_1, ...)
	arg_35_0:emit(arg_35_1, ...)

	return
end

function var_0_1.StartCore(arg_36_0)
	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0.emit

	IslandBaseMediator = var_1_10004

	var_36_1(var_36_0, var_1_10004.SET_UP)

	return
end

function var_0_1.setVisible(arg_37_0, arg_37_1)
	GetOrAddComponent = var_1_10002

	local var_37_0 = arg_37_0._tf

	typeof = var_1_10005
	CanvasGroup = var_1_10007

	local var_37_1 = var_1_10002(var_37_0, var_1_10005(var_1_10007))

	var_37_1.alpha = arg_37_1 and 1 or 0
	var_37_1.blocksRaycasts = arg_37_1

	if arg_37_1 then
		arg_37_0:OnVisible()
	else
		arg_37_0:OnDisVisible()
	end

	return
end

function var_0_1.TryVisible(arg_38_0)
	arg_38_0.showBalance = arg_38_0.showBalance + 1

	if arg_38_0.showBalance == 1 then
		arg_38_0:setVisible(true)
	end

	return
end

function var_0_1.TryDisVisible(arg_39_0)
	arg_39_0.showBalance = arg_39_0.showBalance - 1

	if arg_39_0.showBalance == 0 then
		arg_39_0:setVisible(false)
	end

	return
end

function var_0_1.OpenPage(arg_40_0, arg_40_1, ...)
	IslandGuideChecker = var_1_10002

	var_1_10002.CheckOnOpenPage(arg_40_1.__cname)

	local var_40_0 = arg_40_0.sceneMgr

	return var_2.OpenPage(var_40_0, arg_40_0, arg_40_1, ...)
end

function var_0_1.ClosePage(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.sceneMgr

	var_2.ClosePage(var_41_0, arg_41_1)

	return
end

function var_0_1.GetPage(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.sceneMgr

	return var_2.GetPage(var_42_0, arg_42_1)
end

function var_0_1.GetSubPage(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0.sceneMgr

	return var_2.GetSubPage(var_43_0, arg_43_1)
end

function var_0_1.ShowToast(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0
	local var_44_1 = arg_44_0.GetSubView

	IslandToast = var_1_10005

	local var_44_2 = var_44_1(var_44_0, var_1_10005)

	var_2.ExecuteAction(var_44_2, "Show", arg_44_1)

	return
end

function var_0_1.DisplayAward(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0
	local var_45_1 = arg_45_0.GetSubView

	IslandAwardDisplayPage = var_1_10005

	local var_45_2 = var_45_1(var_45_0, var_1_10005)

	var_2.ExecuteAction(var_45_2, "Show", arg_45_1)

	return
end

function var_0_1.PlayTimeline(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = arg_46_0
	local var_46_1 = arg_46_0.GetSubView

	IslandTimelineMgr = var_1_10007

	local var_46_2 = var_46_1(var_46_0, var_1_10007)

	var_4.ExecuteAction(var_46_2, "Show", arg_46_1, arg_46_2, arg_46_3)

	return
end

function var_0_1.PlayGetShipTimeline(arg_47_0, arg_47_1, arg_47_2)
	arg_47_0:PlayTimeline(2, {
		arg_47_1
	}, arg_47_2)

	return
end

function var_0_1.PlayStory(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0.poppingQueue
	local var_48_1 = var_2.Enqueue

	IslandPoppingQueue = var_1_10005

	var_48_1(var_48_0, var_1_10005.STORY, arg_48_1)

	return
end

function var_0_1.ShowMsgbox(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0.poppingQueue
	local var_49_1 = var_2.Enqueue

	IslandPoppingQueue = var_1_10005

	var_49_1(var_49_0, var_1_10005.MSGBOX, arg_49_1)

	return
end

function var_0_1.PlayPerformance(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0.poppingQueue
	local var_50_1 = var_2.Enqueue

	IslandPoppingQueue = var_1_10005

	var_50_1(var_50_0, var_1_10005.PERFORMANCE, arg_50_1)

	return
end

function var_0_1.DisplaySystemUnlock(arg_51_0, arg_51_1, arg_51_2)
	if not arg_51_1 or #arg_51_1 <= 0 then
		arg_51_2()

		return
	end

	_ = var_1_10003

	if #var_1_10003.select(arg_51_1, function(arg_52_0)
		pg = var_2_10001

		return var_2_10001.island_ability_template[arg_52_0.id].show_pop == 1
	end) <= 0 then
		arg_51_2()

		return
	end

	local var_51_0 = {}

	ipairs = var_5

	for iter_51_0, iter_51_1 in var_5(var_3) do
		table = var_1_10010

		var_1_10010.insert(var_51_0, function(arg_53_0)
			local var_53_0 = arg_51_0
			local var_53_1 = var_1.GetSubView

			IslandSystemUnlockPage = var_2_10004

			local var_53_2 = var_53_1(var_53_0, var_2_10004)

			var_1.ExecuteAction(var_53_2, "Show", iter_51_1.id, function()
				onNextTick = var_3_10000

				var_3_10000(arg_53_0)

				return
			end)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_51_0, arg_51_2)

	return
end

function var_0_1.HandleAwardDisplay(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	local var_55_0 = {
		dropData = arg_55_1,
		callback = arg_55_2,
		displayType = arg_55_3
	}
	local var_55_1 = arg_55_0.poppingQueue
	local var_55_2 = var_5.Enqueue

	IslandPoppingQueue = var_1_10008

	var_55_2(var_55_1, var_1_10008.DISPLAY_AWARD, var_55_0)

	return
end

function var_0_1.ShowTaskAcceptPage(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0.poppingQueue
	local var_56_1 = var_2.Enqueue

	IslandPoppingQueue = var_1_10005

	var_56_1(var_56_0, var_1_10005.TASK_ACCEPT_PAGE, arg_56_1)

	return
end

function var_0_1.ShowQueueUpMsgBox(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = arg_57_0
	local var_57_1 = arg_57_0.GetSubView

	IslandQueueUpMsgBox = var_1_10006

	local var_57_2 = var_57_1(var_57_0, var_1_10006)

	var_3.ExecuteAction(var_57_2, "Show", arg_57_1, arg_57_2)

	return
end

function var_0_1.AddListener(arg_58_0, arg_58_1, arg_58_2)
	local function var_58_0(arg_59_0, ...)
		arg_58_2(arg_58_0, ...)

		return
	end

	local var_58_1 = arg_58_0:bind(arg_58_1, var_58_0)

	arg_58_0.__callbacks__[arg_58_1] = var_58_1

	local var_58_2 = arg_58_0:GetIsland()

	var_5.AddListener(var_58_2, arg_58_1, var_58_0)

	return
end

function var_0_1.RemoveListener(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_0.__callbacks__[arg_60_1] then
		local var_60_0 = arg_60_0.eventStore[var_3]
		local var_60_1 = arg_60_0:GetIsland()

		var_5.RemoveListener(var_60_1, arg_60_1, var_60_0.callback)
		arg_60_0:disconnect(var_3)

		arg_60_0.__callbacks__[arg_60_1] = nil
	end

	return
end

function var_0_1.onBackPressed(arg_61_0)
	local var_61_0 = arg_61_0
	local var_61_1 = arg_61_0.GetSubView

	IslandTimelineMgr = var_1_10004

	local var_61_2 = var_61_1(var_61_0, var_1_10004)

	if var_1.GetLoaded(var_61_2) and var_1:isShowing() then
		return
	end

	local var_61_3 = arg_61_0
	local var_61_4 = arg_61_0.GetSubView

	IslandStoryMgr = var_1_10005

	local var_61_5 = var_61_4(var_61_3, var_1_10005)

	if var_2.onBackPressed(var_61_5) then
		return
	end

	ipairs = var_3

	for iter_61_0, iter_61_1 in var_3(arg_61_0.subViews) do
		if iter_61_1:GetLoaded() and iter_61_1:isShowing() then
			isa = var_8

			local var_61_6 = iter_61_1

			IslandMsgBox = var_1_10011

			if var_8(var_61_6, var_1_10011) then
				iter_61_1:HideWindow()
			else
				iter_61_1:Hide()
			end

			return
		end
	end

	local var_61_7 = arg_61_0.sceneMgr

	if var_3.OnBackPressed(var_61_7) then
		return
	end

	var_0_1.super.onBackPressed(arg_61_0)

	return
end

function var_0_1.RemoveCommonListeners(arg_62_0)
	local var_62_0 = arg_62_0
	local var_62_1 = arg_62_0.RemoveListener

	ISLAND_EX_EVT = var_1_10004

	var_62_1(var_62_0, var_1_10004.EMIT, arg_62_0.OnEmit)

	local var_62_2 = arg_62_0
	local var_62_3 = arg_62_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_62_3(var_62_2, var_4.INIT_FINISH, arg_62_0.OnSceneLoaded)

	local var_62_4 = arg_62_0
	local var_62_5 = arg_62_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_62_5(var_62_4, var_4.SHOW_MSG, arg_62_0.OnShowMsgBox)

	local var_62_6 = arg_62_0
	local var_62_7 = arg_62_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_62_7(var_62_6, var_4.OPEN_PAGE, arg_62_0.OnOpenPage)

	local var_62_8 = arg_62_0
	local var_62_9 = arg_62_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_62_9(var_62_8, var_4.PLAY_TIMELINE, arg_62_0.OnPlayTimeline)
	arg_62_0:RemoveListener(var_0_1.LINK_CORE_EVENT, arg_62_0.OnLinkCoreEvent)

	local var_62_10 = arg_62_0
	local var_62_11 = arg_62_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_62_11(var_62_10, var_4.OPEN_ANIMATION_OP, arg_62_0.OnOpenAnimatonOpPage)

	local var_62_12 = arg_62_0
	local var_62_13 = arg_62_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_62_13(var_62_12, var_4.CLOSE_ANIMATION_OP, arg_62_0.OnCloseAnimatonOpPage)

	return
end

function var_0_1.exit(arg_63_0)
	arg_63_0:RemoveListeners()
	arg_63_0:RemoveCommonListeners()

	ipairs = var_1

	for iter_63_0, iter_63_1 in var_1(arg_63_0.cacheAbList) do
		AssetBundleHelper = var_1_10006

		var_1_10006.UnstoreAssetBundle(iter_63_1, true)
	end

	ipairs = var_1

	for iter_63_2, iter_63_3 in var_1(arg_63_0.subViews) do
		if iter_63_3:GetLoaded() then
			iter_63_3:Destroy()
		end
	end

	ipairs = var_1

	for iter_63_4, iter_63_5 in var_1(arg_63_0.monitors) do
		iter_63_5:Dispose()
	end

	local var_63_0 = arg_63_0:GetIsland()

	var_1.ClearListeners(var_63_0)

	local var_63_1 = arg_63_0.poolMgr

	var_1.Dispose(var_63_1)

	local var_63_2 = arg_63_0.poppingQueue

	var_1.Dispose(var_63_2)
	arg_63_0:disposeEvent()

	local var_63_3 = arg_63_0.sceneMgr

	var_1.Dispose(var_63_3)

	getProxy = var_1
	IslandProxy = var_63_3

	local var_63_4 = var_1(var_63_3)

	var_1.ClearAllPlayerDataCache(var_63_4)

	getProxy = var_1
	IslandProxy = var_63_4

	local var_63_5 = var_1(var_63_4)

	var_1.ClearAllGiftTagInfo(var_63_5)

	arg_63_0.subViews = nil
	arg_63_0.cacheAbList = nil
	arg_63_0.poppingQueue = nil
	arg_63_0.sceneMgr = nil
	arg_63_0.poolMgr = nil
	arg_63_0.monitors = nil
	arg_63_0.uiContainer = nil
	arg_63_0.opContainer = nil
	arg_63_0.pageContainer = nil
	IslandSceneLoader = var_1
	var_1.lastMapId = nil
	arg_63_0.contextData = {}
	GraphicsInterface = var_1

	local var_63_6 = var_1.Instance

	var_1.ReleaseAsyncLoadedResources(var_63_6)
	var_0_1.super.exit(arg_63_0)

	return
end

function var_0_1.detach(arg_64_0, arg_64_1)
	var_0_1.super.detach(arg_64_0, arg_64_1)

	IsNil = var_2

	if not var_2(arg_64_0._container) then
		Object = var_2

		var_2.Destroy(arg_64_0._container.gameObject)

		arg_64_0._container = nil
	end

	return
end

function var_0_1.AddListeners(arg_65_0)
	return
end

function var_0_1.RemoveListeners(arg_66_0)
	return
end

function var_0_1.OnUnloadScene(arg_67_0)
	return
end

return var_0_1
