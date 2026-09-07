local IslandBaseScene = class("IslandBaseScene", import("view.base.BaseUI"))

IslandBaseScene.ON_SCENE_LOADED = "IslandBaseScene:ON_SCENE_LOADED"
IslandBaseScene.LINK_CORE_EVENT = "IslandBaseScene:LINK_CORE_EVENT"

function IslandBaseScene:Ctor()
	IslandBaseScene.super.Ctor(self)

	self.sceneMgr = IslandSceneMgr.New(self)
	self.__callbacks__ = {}
	self.showBalance = 1
	self.cacheAbList = {
		"ui/islandui_atlas",
		"ui/islandcommonui_atlas",
		"island/IslandInteractionBtns"
	}

	return
end

function IslandBaseScene:getDefaultUI()
	return self._container
end

function IslandBaseScene:DontGC()
	return true
end

function IslandBaseScene:forceGC()
	return false
end

function IslandBaseScene:GCWhenAwake()
	return false
end

function IslandBaseScene:PlayBGM()
	pg.BgmMgr.GetInstance():StopPlay()

	return
end

function IslandBaseScene:preload(arg_7_1)
	local var_7_0 = {}

	table.insert(var_7_0, function(arg_8_0)
		self:LoadUIContainer(arg_8_0)

		return
	end)
	table.insert(var_7_0, function(arg_9_0)
		self.poolMgr = IslandPoolMgr.New(self.poolContainer)

		self.poolMgr:Init(arg_9_0)

		return
	end)

	for iter_7_0, iter_7_1 in ipairs(self.cacheAbList) do
		table.insert(var_7_0, function(arg_10_0)
			AssetBundleHelper.StoreAssetBundle(iter_7_1, true, false, function(arg_11_0)
				arg_10_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_7_0, arg_7_1)

	return
end

function IslandBaseScene:LoadUIContainer(arg_12_1)
	ResourceMgr.Inst:getAssetAsync("UI/UIIsland", "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_13_0)
		IslandHelper.InstantiateAsyncGameObject(arg_13_0, function(arg_14_0)
			self._container = arg_14_0.transform
			self.canvasGroup = GetOrAddComponent(self._container, typeof(CanvasGroup))
			self.uiLayer1 = self._container:Find("layer1")
			self.uiLayer2 = self._container:Find("layer2")
			self.uiContainer = self._container:Find("layer1/ui")
			self.opContainer = self._container:Find("layer1/op")
			self.pageContainer = self._container:Find("layer1/page")
			self.poolContainer = self._container:Find("_pool_")
			self._container.name = "UIIsland"

			setParent(self._container, pg.UIMgr.GetInstance().UICanvas)
			arg_12_1()

			return
		end)

		return
	end), true, true)

	return
end

function IslandBaseScene:SetUIParent(arg_15_1)
	arg_15_1.transform:SetParent(self.uiContainer, false)

	return
end

function IslandBaseScene:emit(arg_16_1, ...)
	if arg_16_1 == BaseUI.ON_HOME or arg_16_1 == IslandMediator.CHANGE_SCENE then
		if ISLAND_PLAYER_TESTING then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_home_btn_cant_use"))

			return
		end

		self:ExitProcess(arg_16_1, nil, ...)
	else
		IslandBaseScene.super.emit(self, arg_16_1, ...)
	end

	return
end

function IslandBaseScene:emitCoreController(arg_17_1, ...)
	self:emit(IslandBaseScene.LINK_CORE_EVENT, arg_17_1, ...)

	return
end

function IslandBaseScene:emitCore(arg_18_1, ...)
	self:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.LINK_CORE, arg_18_1, ...)

	return
end

function IslandBaseScene:ExitProcess(arg_19_1, arg_19_2, ...)
	local var_19_0 = packEx(...)
	local var_19_1 = self:GetIsland()

	seriesAsync({
		function(arg_20_0)
			self:emit(IslandBaseMediator.RECORD_PLAYER_POS)
			pg.m02:sendNotification(GAME.ISLAND_EXIT, {
				id = var_19_1.id,
				callback = arg_20_0
			})

			return
		end
	}, function()
		IslandBaseScene.super.emit(self, arg_19_1, unpackEx(var_19_0))

		if arg_19_2 then
			arg_19_2()
		end

		return
	end)

	return
end

function IslandBaseScene:GetIsland()
	assert(false, "overwrite me !!!!")

	return
end

function IslandBaseScene:onUILoaded(arg_23_1)
	IslandBaseScene.super.onUILoaded(self, arg_23_1)

	self.subViews = {
		IslandMsgBox.New(pg.UIMgr.GetInstance().OverlayMain, self.event),
		IslandToast.New(pg.UIMgr.GetInstance().OverlayToast, self.event),
		IslandStoryMgr.New(pg.UIMgr.GetInstance().OverlayToast, self.event),
		IslandAwardDisplayPage.New(pg.UIMgr.GetInstance().OverlayToast, self.event),
		IslandQueueUpMsgBox.New(pg.UIMgr.GetInstance().OverlayToast, self.event),
		IslandTimelineMgr.New(self:GetPoolMgr(), pg.UIMgr.GetInstance().OverlayToast, self.event),
		Island3dTaskAcceptPage.New(pg.UIMgr.GetInstance().OverlayToast, self.event),
		IslandSystemUnlockPage.New(pg.UIMgr.GetInstance().OverlayToast, self.event)
	}
	self.monitors = {
		IslandPlayerDataMonitor.New(self:GetIsland()),
		IslandSyncDataMonitor.New(self:GetIsland()),
		IslandCheaterTavernMonitor.New(self:GetIsland())
	}
	self.poppingQueue = IslandPoppingQueue.New(self)

	self:AddCommonListeners()
	self:AddListeners()

	for iter_23_0, iter_23_1 in pairs(self.subViews) do
		iter_23_1:RegisterView(self)
	end

	return
end

function IslandBaseScene:AddCommonListeners()
	self:AddListener(ISLAND_EX_EVT.EMIT, self.OnEmit)
	self:AddListener(ISLAND_EX_EVT.INIT_FINISH, self.OnSceneLoaded)
	self:AddListener(ISLAND_EX_EVT.SHOW_MSG, self.OnShowMsgBox)
	self:AddListener(ISLAND_EX_EVT.OPEN_PAGE, self.OnOpenPage)
	self:AddListener(ISLAND_EX_EVT.PLAY_TIMELINE, self.OnPlayTimeline)
	self:AddListener(IslandBaseScene.LINK_CORE_EVENT, self.OnLinkCoreEvent)
	self:AddListener(ISLAND_EX_EVT.OPEN_ANIMATION_OP, self.OnOpenAnimatonOpPage)
	self:AddListener(ISLAND_EX_EVT.CLOSE_ANIMATION_OP, self.OnCloseAnimatonOpPage)

	return
end

function IslandBaseScene:GetSubView(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(self.subViews) do
		if isa(iter_25_1, arg_25_1) then
			return iter_25_1
		end
	end

	return nil
end

function IslandBaseScene:GetPoolMgr()
	return self.poolMgr
end

function IslandBaseScene:OnOpenAnimatonOpPage()
	return
end

function IslandBaseScene:OnCloseAnimatonOpPage()
	return
end

function IslandBaseScene:OnLinkCoreEvent(arg_29_1, ...)
	self:GetIsland():DispatchEvent(arg_29_1, ...)

	return
end

function IslandBaseScene:OnSetUpCore(arg_30_1, arg_30_2)
	return
end

function IslandBaseScene:OnOpenPage(arg_31_1, ...)
	self:OpenPage(arg_31_1, ...)

	return
end

function IslandBaseScene:OnShowMsgBox(arg_32_1)
	self:ShowMsgbox(arg_32_1)

	return
end

function IslandBaseScene:OnPlayTimeline(arg_33_1, arg_33_2, arg_33_3)
	self:PlayTimeline(arg_33_1, arg_33_2, arg_33_3)

	return
end

function IslandBaseScene:OnSceneLoaded()
	self:emit(IslandBaseScene.ON_SCENE_LOADED)

	return
end

function IslandBaseScene:OnEmit(arg_35_1, ...)
	self:emit(arg_35_1, ...)

	return
end

function IslandBaseScene:StartCore()
	self:emit(IslandBaseMediator.SET_UP)

	return
end

function IslandBaseScene:setVisible(arg_37_1)
	local var_37_0 = GetOrAddComponent(self._tf, typeof(CanvasGroup))

	var_37_0.alpha = arg_37_1 and 1 or 0
	var_37_0.blocksRaycasts = arg_37_1

	if arg_37_1 then
		self:OnVisible()
	else
		self:OnDisVisible()
	end

	return
end

function IslandBaseScene:TryVisible()
	self.showBalance = self.showBalance + 1

	if self.showBalance == 1 then
		self:setVisible(true)
	end

	return
end

function IslandBaseScene:TryDisVisible()
	self.showBalance = self.showBalance - 1

	if self.showBalance == 0 then
		self:setVisible(false)
	end

	return
end

function IslandBaseScene:OpenPage(arg_40_1, ...)
	IslandGuideChecker.CheckOnOpenPage(arg_40_1.__cname)

	return self.sceneMgr:OpenPage(self, arg_40_1, ...)
end

function IslandBaseScene:ClosePage(arg_41_1)
	self.sceneMgr:ClosePage(arg_41_1)

	return
end

function IslandBaseScene:GetPage(arg_42_1)
	return self.sceneMgr:GetPage(arg_42_1)
end

function IslandBaseScene:GetSubPage(arg_43_1)
	return self.sceneMgr:GetSubPage(arg_43_1)
end

function IslandBaseScene:ShowToast(arg_44_1)
	self:GetSubView(IslandToast):ExecuteAction("Show", arg_44_1)

	return
end

function IslandBaseScene:DisplayAward(arg_45_1)
	self:GetSubView(IslandAwardDisplayPage):ExecuteAction("Show", arg_45_1)

	return
end

function IslandBaseScene:PlayTimeline(arg_46_1, arg_46_2, arg_46_3)
	self:GetSubView(IslandTimelineMgr):ExecuteAction("Show", arg_46_1, arg_46_2, arg_46_3)

	return
end

function IslandBaseScene:PlayGetShipTimeline(arg_47_1, arg_47_2)
	self:PlayTimeline(2, {
		arg_47_1
	}, arg_47_2)

	return
end

function IslandBaseScene:PlayStory(arg_48_1)
	self.poppingQueue:Enqueue(IslandPoppingQueue.STORY, arg_48_1)

	return
end

function IslandBaseScene:ShowMsgbox(arg_49_1)
	self.poppingQueue:Enqueue(IslandPoppingQueue.MSGBOX, arg_49_1)

	return
end

function IslandBaseScene:PlayPerformance(arg_50_1)
	self.poppingQueue:Enqueue(IslandPoppingQueue.PERFORMANCE, arg_50_1)

	return
end

function IslandBaseScene:DisplaySystemUnlock(arg_51_1, arg_51_2)
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
			self:GetSubView(IslandSystemUnlockPage):ExecuteAction("Show", iter_51_1.id, function()
				onNextTick(arg_53_0)

				return
			end)

			return
		end)
	end

	seriesAsync(var_51_1, arg_51_2)

	return
end

function IslandBaseScene:HandleAwardDisplay(arg_55_1, arg_55_2, arg_55_3)
	self.poppingQueue:Enqueue(IslandPoppingQueue.DISPLAY_AWARD, {
		dropData = arg_55_1,
		callback = arg_55_2,
		displayType = arg_55_3
	})

	return
end

function IslandBaseScene:ShowTaskAcceptPage(arg_56_1)
	self.poppingQueue:Enqueue(IslandPoppingQueue.TASK_ACCEPT_PAGE, arg_56_1)

	return
end

function IslandBaseScene:ShowQueueUpMsgBox(arg_57_1, arg_57_2)
	self:GetSubView(IslandQueueUpMsgBox):ExecuteAction("Show", arg_57_1, arg_57_2)

	return
end

function IslandBaseScene:AddListener(arg_58_1, arg_58_2)
	local function var_58_0(arg_59_0, ...)
		arg_58_2(self, ...)

		return
	end

	self.__callbacks__[arg_58_1] = self:bind(arg_58_1, var_58_0)

	self:GetIsland():AddListener(arg_58_1, var_58_0)

	return
end

function IslandBaseScene:RemoveListener(arg_60_1, arg_60_2)
	if self.__callbacks__[arg_60_1] then
		self:GetIsland():RemoveListener(arg_60_1, self.eventStore[self.__callbacks__[arg_60_1]].callback)
		self:disconnect(self.__callbacks__[arg_60_1])

		self.__callbacks__[arg_60_1] = nil
	end

	return
end

function IslandBaseScene:onBackPressed()
	local var_61_0 = self:GetSubView(IslandTimelineMgr)

	if var_61_0:GetLoaded() and var_61_0:isShowing() then
		return
	end

	if self:GetSubView(IslandStoryMgr):onBackPressed() then
		return
	end

	for iter_61_0, iter_61_1 in ipairs(self.subViews) do
		if iter_61_1:GetLoaded() and iter_61_1:isShowing() then
			if isa(iter_61_1, IslandMsgBox) then
				iter_61_1:HideWindow()
			else
				iter_61_1:Hide()
			end

			return
		end
	end

	if self.sceneMgr:OnBackPressed() then
		return
	end

	IslandBaseScene.super.onBackPressed(self)

	return
end

function IslandBaseScene:RemoveCommonListeners()
	self:RemoveListener(ISLAND_EX_EVT.EMIT, self.OnEmit)
	self:RemoveListener(ISLAND_EX_EVT.INIT_FINISH, self.OnSceneLoaded)
	self:RemoveListener(ISLAND_EX_EVT.SHOW_MSG, self.OnShowMsgBox)
	self:RemoveListener(ISLAND_EX_EVT.OPEN_PAGE, self.OnOpenPage)
	self:RemoveListener(ISLAND_EX_EVT.PLAY_TIMELINE, self.OnPlayTimeline)
	self:RemoveListener(IslandBaseScene.LINK_CORE_EVENT, self.OnLinkCoreEvent)
	self:RemoveListener(ISLAND_EX_EVT.OPEN_ANIMATION_OP, self.OnOpenAnimatonOpPage)
	self:RemoveListener(ISLAND_EX_EVT.CLOSE_ANIMATION_OP, self.OnCloseAnimatonOpPage)

	return
end

function IslandBaseScene:exit()
	self:RemoveListeners()
	self:RemoveCommonListeners()

	for iter_63_0, iter_63_1 in ipairs(self.cacheAbList) do
		AssetBundleHelper.UnstoreAssetBundle(iter_63_1, true)
	end

	for iter_63_2, iter_63_3 in ipairs(self.subViews) do
		if iter_63_3:GetLoaded() then
			iter_63_3:Destroy()
		end
	end

	for iter_63_4, iter_63_5 in ipairs(self.monitors) do
		iter_63_5:Dispose()
	end

	self:GetIsland():ClearListeners()
	self.poolMgr:Dispose()
	self.poppingQueue:Dispose()
	self:disposeEvent()
	self.sceneMgr:Dispose()
	getProxy(IslandProxy):ClearAllPlayerDataCache()
	getProxy(IslandProxy):ClearAllGiftTagInfo()

	self.subViews = nil
	self.cacheAbList = nil
	self.poppingQueue = nil
	self.sceneMgr = nil
	self.poolMgr = nil
	self.monitors = nil
	self.uiContainer = nil
	self.opContainer = nil
	self.pageContainer = nil
	IslandSceneLoader.lastMapId = nil
	self.contextData = {}

	GraphicsInterface.Instance:ReleaseAsyncLoadedResources()
	IslandBaseScene.super.exit(self)

	return
end

function IslandBaseScene:detach(arg_64_1)
	IslandBaseScene.super.detach(self, arg_64_1)

	if not IsNil(self._container) then
		Object.Destroy(self._container.gameObject)

		self._container = nil
	end

	return
end

function IslandBaseScene:AddListeners()
	return
end

function IslandBaseScene:RemoveListeners()
	return
end

function IslandBaseScene:OnUnloadScene()
	return
end

return IslandBaseScene
