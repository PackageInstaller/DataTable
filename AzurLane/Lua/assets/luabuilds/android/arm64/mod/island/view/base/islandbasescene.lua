local var_0_0 = class("IslandBaseScene", import("view.base.BaseUI"))

var_0_0.ON_SCENE_LOADED = "IslandBaseScene:ON_SCENE_LOADED"
var_0_0.LINK_CORE_EVENT = "IslandBaseScene:LINK_CORE_EVENT"

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.sceneMgr = IslandSceneMgr.New(arg_1_0)
	arg_1_0.__callbacks__ = {}
	arg_1_0.showBalance = 1
	arg_1_0.cacheAbList = {
		"ui/islandui_atlas",
		"ui/islandcommonui_atlas",
		"island/IslandInteractionBtns"
	}

	return
end

function var_0_0.getDefaultUI(arg_2_0)
	return arg_2_0._container
end

function var_0_0.DontGC(arg_3_0)
	return true
end

function var_0_0.forceGC(arg_4_0)
	return false
end

function var_0_0.GCWhenAwake(arg_5_0)
	return false
end

function var_0_0.PlayBGM(arg_6_0)
	pg.BgmMgr.GetInstance():StopPlay()

	return
end

function var_0_0.preload(arg_7_0, arg_7_1)
	table.insert({}, function(arg_8_0)
		arg_7_0:LoadUIContainer(arg_8_0)

		return
	end)
	table.insert({}, function(arg_9_0)
		arg_7_0.poolMgr = IslandPoolMgr.New(arg_7_0.poolContainer)

		arg_7_0.poolMgr:Init(arg_9_0)

		return
	end)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.cacheAbList) do
		table.insert({}, function(arg_10_0)
			AssetBundleHelper.StoreAssetBundle(iter_7_1, true, false, function(arg_11_0)
				arg_10_0()

				return
			end)

			return
		end)
	end

	seriesAsync({}, arg_7_1)

	return
end

function var_0_0.LoadUIContainer(arg_12_0, arg_12_1)
	ResourceMgr.Inst:getAssetAsync("UI/UIIsland", "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_13_0)
		IslandHelper.InstantiateAsyncGameObject(arg_13_0, function(arg_14_0)
			arg_12_0._container = arg_14_0.transform
			arg_12_0.canvasGroup = GetOrAddComponent(arg_12_0._container, typeof(CanvasGroup))
			arg_12_0.uiLayer1 = arg_12_0._container:Find("layer1")
			arg_12_0.uiLayer2 = arg_12_0._container:Find("layer2")
			arg_12_0.uiContainer = arg_12_0._container:Find("layer1/ui")
			arg_12_0.opContainer = arg_12_0._container:Find("layer1/op")
			arg_12_0.pageContainer = arg_12_0._container:Find("layer1/page")
			arg_12_0.poolContainer = arg_12_0._container:Find("_pool_")
			arg_12_0._container.name = "UIIsland"

			setParent(arg_12_0._container, pg.UIMgr.GetInstance().UICanvas)
			arg_12_1()

			return
		end)

		return
	end), true, true)

	return
end

function var_0_0.SetUIParent(arg_15_0, arg_15_1)
	arg_15_1.transform:SetParent(arg_15_0.uiContainer, false)

	return
end

function var_0_0.emit(arg_16_0, arg_16_1, ...)
	if arg_16_1 == BaseUI.ON_HOME or arg_16_1 == IslandMediator.CHANGE_SCENE then
		if ISLAND_PLAYER_TESTING then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_home_btn_cant_use"))

			return
		end

		arg_16_0:ExitProcess(arg_16_1, nil, ...)
	else
		var_0_0.super.emit(arg_16_0, arg_16_1, ...)
	end

	return
end

function var_0_0.emitCoreController(arg_17_0, arg_17_1, ...)
	arg_17_0:emit(var_0_0.LINK_CORE_EVENT, arg_17_1, ...)

	return
end

function var_0_0.emitCore(arg_18_0, arg_18_1, ...)
	arg_18_0:emit(var_0_0.LINK_CORE_EVENT, IslandProxy.LINK_CORE, arg_18_1, ...)

	return
end

function var_0_0.ExitProcess(arg_19_0, arg_19_1, arg_19_2, ...)
	local var_19_0 = packEx(...)
	local var_19_1 = arg_19_0:GetIsland()

	seriesAsync({
		function(arg_20_0)
			arg_19_0:emit(IslandBaseMediator.RECORD_PLAYER_POS)
			pg.m02:sendNotification(GAME.ISLAND_EXIT, {
				id = var_19_1.id,
				callback = arg_20_0
			})

			return
		end
	}, function()
		var_0_0.super.emit(arg_19_0, arg_19_1, unpackEx(var_19_0))

		if arg_19_2 then
			arg_19_2()
		end

		return
	end)

	return
end

function var_0_0.GetIsland(arg_22_0)
	assert(false, "overwrite me !!!!")

	return
end

function var_0_0.onUILoaded(arg_23_0, arg_23_1)
	var_0_0.super.onUILoaded(arg_23_0, arg_23_1)

	arg_23_0.subViews = {
		IslandMsgBox.New(pg.UIMgr.GetInstance().OverlayMain, arg_23_0.event),
		IslandToast.New(pg.UIMgr.GetInstance().OverlayToast, arg_23_0.event),
		IslandStoryMgr.New(pg.UIMgr.GetInstance().OverlayToast, arg_23_0.event),
		IslandAwardDisplayPage.New(pg.UIMgr.GetInstance().OverlayToast, arg_23_0.event),
		IslandQueueUpMsgBox.New(pg.UIMgr.GetInstance().OverlayToast, arg_23_0.event),
		IslandTimelineMgr.New(arg_23_0:GetPoolMgr(), pg.UIMgr.GetInstance().OverlayToast, arg_23_0.event),
		Island3dTaskAcceptPage.New(pg.UIMgr.GetInstance().OverlayToast, arg_23_0.event),
		IslandSystemUnlockPage.New(pg.UIMgr.GetInstance().OverlayToast, arg_23_0.event)
	}
	arg_23_0.monitors = {
		IslandPlayerDataMonitor.New(arg_23_0:GetIsland()),
		IslandSyncDataMonitor.New(arg_23_0:GetIsland()),
		IslandCheaterTavernMonitor.New(arg_23_0:GetIsland())
	}
	arg_23_0.poppingQueue = IslandPoppingQueue.New(arg_23_0)

	arg_23_0:AddCommonListeners()
	arg_23_0:AddListeners()

	for iter_23_0, iter_23_1 in pairs(arg_23_0.subViews) do
		iter_23_1:RegisterView(arg_23_0)
	end

	return
end

function var_0_0.AddCommonListeners(arg_24_0)
	arg_24_0:AddListener(ISLAND_EX_EVT.EMIT, arg_24_0.OnEmit)
	arg_24_0:AddListener(ISLAND_EX_EVT.INIT_FINISH, arg_24_0.OnSceneLoaded)
	arg_24_0:AddListener(ISLAND_EX_EVT.SHOW_MSG, arg_24_0.OnShowMsgBox)
	arg_24_0:AddListener(ISLAND_EX_EVT.OPEN_PAGE, arg_24_0.OnOpenPage)
	arg_24_0:AddListener(ISLAND_EX_EVT.PLAY_TIMELINE, arg_24_0.OnPlayTimeline)
	arg_24_0:AddListener(var_0_0.LINK_CORE_EVENT, arg_24_0.OnLinkCoreEvent)
	arg_24_0:AddListener(ISLAND_EX_EVT.OPEN_ANIMATION_OP, arg_24_0.OnOpenAnimatonOpPage)
	arg_24_0:AddListener(ISLAND_EX_EVT.CLOSE_ANIMATION_OP, arg_24_0.OnCloseAnimatonOpPage)

	return
end

function var_0_0.GetSubView(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.subViews) do
		if isa(iter_25_1, arg_25_1) then
			return iter_25_1
		end
	end

	return nil
end

function var_0_0.GetPoolMgr(arg_26_0)
	return arg_26_0.poolMgr
end

function var_0_0.OnOpenAnimatonOpPage(arg_27_0)
	return
end

function var_0_0.OnCloseAnimatonOpPage(arg_28_0)
	return
end

function var_0_0.OnLinkCoreEvent(arg_29_0, arg_29_1, ...)
	arg_29_0:GetIsland():DispatchEvent(arg_29_1, ...)

	return
end

function var_0_0.OnSetUpCore(arg_30_0, arg_30_1, arg_30_2)
	return
end

function var_0_0.OnOpenPage(arg_31_0, arg_31_1, ...)
	arg_31_0:OpenPage(arg_31_1, ...)

	return
end

function var_0_0.OnShowMsgBox(arg_32_0, arg_32_1)
	arg_32_0:ShowMsgbox(arg_32_1)

	return
end

function var_0_0.OnPlayTimeline(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_0:PlayTimeline(arg_33_1, arg_33_2, arg_33_3)

	return
end

function var_0_0.OnSceneLoaded(arg_34_0)
	arg_34_0:emit(var_0_0.ON_SCENE_LOADED)

	return
end

function var_0_0.OnEmit(arg_35_0, arg_35_1, ...)
	arg_35_0:emit(arg_35_1, ...)

	return
end

function var_0_0.StartCore(arg_36_0)
	arg_36_0:emit(IslandBaseMediator.SET_UP)

	return
end

function var_0_0.setVisible(arg_37_0, arg_37_1)
	local var_37_0 = GetOrAddComponent(arg_37_0._tf, typeof(CanvasGroup))

	var_37_0.alpha = arg_37_1 and 1 or 0
	var_37_0.blocksRaycasts = arg_37_1

	if arg_37_1 then
		arg_37_0:OnVisible()
	else
		arg_37_0:OnDisVisible()
	end

	return
end

function var_0_0.TryVisible(arg_38_0)
	arg_38_0.showBalance = arg_38_0.showBalance + 1

	if arg_38_0.showBalance == 1 then
		arg_38_0:setVisible(true)
	end

	return
end

function var_0_0.TryDisVisible(arg_39_0)
	arg_39_0.showBalance = arg_39_0.showBalance - 1

	if arg_39_0.showBalance == 0 then
		arg_39_0:setVisible(false)
	end

	return
end

function var_0_0.OpenPage(arg_40_0, arg_40_1, ...)
	IslandGuideChecker.CheckOnOpenPage(arg_40_1.__cname)

	return arg_40_0.sceneMgr:OpenPage(arg_40_0, arg_40_1, ...)
end

function var_0_0.ClosePage(arg_41_0, arg_41_1)
	arg_41_0.sceneMgr:ClosePage(arg_41_1)

	return
end

function var_0_0.GetPage(arg_42_0, arg_42_1)
	return arg_42_0.sceneMgr:GetPage(arg_42_1)
end

function var_0_0.GetSubPage(arg_43_0, arg_43_1)
	return arg_43_0.sceneMgr:GetSubPage(arg_43_1)
end

function var_0_0.ShowToast(arg_44_0, arg_44_1)
	arg_44_0:GetSubView(IslandToast):ExecuteAction("Show", arg_44_1)

	return
end

function var_0_0.DisplayAward(arg_45_0, arg_45_1)
	arg_45_0:GetSubView(IslandAwardDisplayPage):ExecuteAction("Show", arg_45_1)

	return
end

function var_0_0.PlayTimeline(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	arg_46_0:GetSubView(IslandTimelineMgr):ExecuteAction("Show", arg_46_1, arg_46_2, arg_46_3)

	return
end

function var_0_0.PlayGetShipTimeline(arg_47_0, arg_47_1, arg_47_2)
	arg_47_0:PlayTimeline(2, {
		arg_47_1
	}, arg_47_2)

	return
end

function var_0_0.PlayStory(arg_48_0, arg_48_1)
	arg_48_0.poppingQueue:Enqueue(IslandPoppingQueue.STORY, arg_48_1)

	return
end

function var_0_0.ShowMsgbox(arg_49_0, arg_49_1)
	arg_49_0.poppingQueue:Enqueue(IslandPoppingQueue.MSGBOX, arg_49_1)

	return
end

function var_0_0.PlayPerformance(arg_50_0, arg_50_1)
	arg_50_0.poppingQueue:Enqueue(IslandPoppingQueue.PERFORMANCE, arg_50_1)

	return
end

function var_0_0.DisplaySystemUnlock(arg_51_0, arg_51_1, arg_51_2)
	if not arg_51_1 or #arg_51_1 <= 0 then
		arg_51_2()

		return
	end

	local var_51_0 = _.select(arg_51_1, function(arg_52_0)
		return pg.island_ability_template[arg_52_0.id].show_pop == 1
	end)

	if #var_51_0 <= 0 then
		arg_51_2()

		return
	end

	local var_51_1 = {}

	for iter_51_0, iter_51_1 in ipairs(var_51_0) do
		table.insert(var_51_1, function(arg_53_0)
			arg_51_0:GetSubView(IslandSystemUnlockPage):ExecuteAction("Show", iter_51_1.id, function()
				onNextTick(arg_53_0)

				return
			end)

			return
		end)
	end

	seriesAsync(var_51_1, arg_51_2)

	return
end

function var_0_0.HandleAwardDisplay(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	arg_55_0.poppingQueue:Enqueue(IslandPoppingQueue.DISPLAY_AWARD, {
		dropData = arg_55_1,
		callback = arg_55_2,
		displayType = arg_55_3
	})

	return
end

function var_0_0.ShowTaskAcceptPage(arg_56_0, arg_56_1)
	arg_56_0.poppingQueue:Enqueue(IslandPoppingQueue.TASK_ACCEPT_PAGE, arg_56_1)

	return
end

function var_0_0.ShowQueueUpMsgBox(arg_57_0, arg_57_1, arg_57_2)
	arg_57_0:GetSubView(IslandQueueUpMsgBox):ExecuteAction("Show", arg_57_1, arg_57_2)

	return
end

function var_0_0.AddListener(arg_58_0, arg_58_1, arg_58_2)
	arg_58_0.__callbacks__[arg_58_1] = arg_58_0:bind(arg_58_1, function(arg_59_0, ...)
		arg_58_2(arg_58_0, ...)

		return
	end)

	arg_58_0:GetIsland():AddListener(arg_58_1, function(arg_59_0, ...)
		arg_58_2(arg_58_0, ...)

		return
	end)

	return
end

function var_0_0.RemoveListener(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_0.__callbacks__[arg_60_1] then
		arg_60_0:GetIsland():RemoveListener(arg_60_1, arg_60_0.eventStore[arg_60_0.__callbacks__[arg_60_1]].callback)
		arg_60_0:disconnect(arg_60_0.__callbacks__[arg_60_1])

		arg_60_0.__callbacks__[arg_60_1] = nil
	end

	return
end

function var_0_0.onBackPressed(arg_61_0)
	local var_61_0 = arg_61_0:GetSubView(IslandTimelineMgr)

	if var_61_0:GetLoaded() and var_61_0:isShowing() then
		return
	end

	local var_61_1 = arg_61_0:GetSubView(IslandStoryMgr)

	if var_61_1:onBackPressed() then
		return
	end

	for iter_61_0, iter_61_1 in ipairs(arg_61_0.subViews) do
		if iter_61_1:GetLoaded() and iter_61_1:isShowing() then
			if isa(iter_61_1, IslandMsgBox) then
				iter_61_1:HideWindow()
			else
				iter_61_1:Hide()
			end

			return
		end
	end

	if arg_61_0.sceneMgr:OnBackPressed() then
		return
	end

	var_0_0.super.onBackPressed(arg_61_0)

	return
end

function var_0_0.RemoveCommonListeners(arg_62_0)
	arg_62_0:RemoveListener(ISLAND_EX_EVT.EMIT, arg_62_0.OnEmit)
	arg_62_0:RemoveListener(ISLAND_EX_EVT.INIT_FINISH, arg_62_0.OnSceneLoaded)
	arg_62_0:RemoveListener(ISLAND_EX_EVT.SHOW_MSG, arg_62_0.OnShowMsgBox)
	arg_62_0:RemoveListener(ISLAND_EX_EVT.OPEN_PAGE, arg_62_0.OnOpenPage)
	arg_62_0:RemoveListener(ISLAND_EX_EVT.PLAY_TIMELINE, arg_62_0.OnPlayTimeline)
	arg_62_0:RemoveListener(var_0_0.LINK_CORE_EVENT, arg_62_0.OnLinkCoreEvent)
	arg_62_0:RemoveListener(ISLAND_EX_EVT.OPEN_ANIMATION_OP, arg_62_0.OnOpenAnimatonOpPage)
	arg_62_0:RemoveListener(ISLAND_EX_EVT.CLOSE_ANIMATION_OP, arg_62_0.OnCloseAnimatonOpPage)

	return
end

function var_0_0.exit(arg_63_0)
	arg_63_0:RemoveListeners()
	arg_63_0:RemoveCommonListeners()

	for iter_63_0, iter_63_1 in ipairs(arg_63_0.cacheAbList) do
		AssetBundleHelper.UnstoreAssetBundle(iter_63_1, true)
	end

	for iter_63_2, iter_63_3 in ipairs(arg_63_0.subViews) do
		if iter_63_3:GetLoaded() then
			iter_63_3:Destroy()
		end
	end

	for iter_63_4, iter_63_5 in ipairs(arg_63_0.monitors) do
		iter_63_5:Dispose()
	end

	arg_63_0:GetIsland():ClearListeners()
	arg_63_0.poolMgr:Dispose()
	arg_63_0.poppingQueue:Dispose()
	arg_63_0:disposeEvent()
	arg_63_0.sceneMgr:Dispose()
	getProxy(IslandProxy):ClearAllPlayerDataCache()
	getProxy(IslandProxy):ClearAllGiftTagInfo()

	arg_63_0.subViews = nil
	arg_63_0.cacheAbList = nil
	arg_63_0.poppingQueue = nil
	arg_63_0.sceneMgr = nil
	arg_63_0.poolMgr = nil
	arg_63_0.monitors = nil
	arg_63_0.uiContainer = nil
	arg_63_0.opContainer = nil
	arg_63_0.pageContainer = nil
	IslandSceneLoader.lastMapId = nil
	arg_63_0.contextData = {}

	GraphicsInterface.Instance:ReleaseAsyncLoadedResources()
	var_0_0.super.exit(arg_63_0)

	return
end

function var_0_0.detach(arg_64_0, arg_64_1)
	var_0_0.super.detach(arg_64_0, arg_64_1)

	if not IsNil(arg_64_0._container) then
		Object.Destroy(arg_64_0._container.gameObject)

		arg_64_0._container = nil
	end

	return
end

function var_0_0.AddListeners(arg_65_0)
	return
end

function var_0_0.RemoveListeners(arg_66_0)
	return
end

function var_0_0.OnUnloadScene(arg_67_0)
	return
end

return var_0_0
