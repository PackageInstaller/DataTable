local WorldPortLayer = class("WorldPortLayer", import("..base.BaseUI"))

WorldPortLayer.Listeners = {
	onUpdateNGoods = "OnUpdateNGoods",
	onUpdateMoneyCount = "OnUpdateMoneyCount",
	onUpdateTasks = "OnUpdateTasks",
	onUpdateGoods = "OnUpdateGoods"
}
WorldPortLayer.TitleName = {
	"text_gangkou",
	"text_operation",
	"text_supply"
}
WorldPortLayer.PageMain = 0
WorldPortLayer.PageTask = 1
WorldPortLayer.PageShop = 2
WorldPortLayer.PageDockyard = 3
WorldPortLayer.PageNShop = 4
WorldPortLayer.BlurPages = {
	[WorldPortLayer.PageTask] = true,
	[WorldPortLayer.PageShop] = true,
	[WorldPortLayer.PageNShop] = true
}
WorldPortLayer.optionsPath = {
	"blur_panel/adapt/top/title/option"
}

function WorldPortLayer:getUIName()
	return "WorldPortUI"
end

function WorldPortLayer:init()
	for iter_2_0, iter_2_1 in pairs(WorldPortLayer.Listeners) do
		self[iter_2_0] = function(...)
			WorldPortLayer[iter_2_1](self, ...)

			return
		end
	end

	self.rtBg = self._tf:Find("bg")
	self.rtEnterIcon = self.rtBg:Find("enter_icon")
	self.rtBgNShop = self._tf:Find("bg_2")
	self.rtBlurPanel = self._tf:Find("blur_panel")
	self.rtTasks = self.rtBlurPanel:Find("adapt/tasks")
	self.rtShop = self.rtBlurPanel:Find("adapt/shop")
	self.rtPainting = self.rtShop:Find("paint")
	self.btnPainting = self.rtShop:Find("paint_touch")

	setActive(self.btnPainting, false)

	self.rtChat = self.rtShop:Find("chat")

	setActive(self.rtChat, false)

	self.rtNShop = self.rtBlurPanel:Find("adapt/new_shop")
	self.containerPort = self.rtNShop:Find("frame/content/left")
	self.tplPort = self.containerPort:Find("port_tpl")
	self.poolTplPort = {
		self.tplPort
	}
	self.rtNGoodsContainer = self.rtNShop:Find("frame/content/right/page/view/content")
	self.rtNShopRes = self.rtNShop:Find("frame/content/right/page/title/res")

	local var_2_0 = Drop.New({
		type = DROP_TYPE_WORLD_ITEM,
		id = WorldItem.PortMoneyId
	})

	GetImageSpriteFromAtlasAsync(var_2_0:getIcon(), "", self.rtNShopRes:Find("icon/Image"), false)
	setText(self.rtNShopRes:Find("icon/name"), var_2_0:getName())

	self.rtTop = self.rtBlurPanel:Find("adapt/top")
	self.btnBack = self.rtTop:Find("title/back_button")
	self.rtTopTitle = self.rtTop:Find("title")
	self.rtImageTitle = self.rtTopTitle:Find("print/title")
	self.rtImageTitleTask = self.rtTopTitle:Find("print/title_task")
	self.rtImageTitleShop = self.rtTopTitle:Find("print/title_shop")
	self.rtTopLeft = self.rtTop:Find("left_stage")
	self.rtTopRight = self.rtTop:Find("right_stage")
	self.wsWorldInfo = WSWorldInfo.New()
	self.wsWorldInfo.transform = self.rtTopRight:Find("display_panel/world_info")

	self.wsWorldInfo:Setup()
	setText(self.rtTopRight:Find("display_panel/title/title"), i18n("world_map_title_tips"))
	setText(self.rtTopRight:Find("display_panel/title/title_en"), i18n("world_map_title_tips_en"))
	setText(self.wsWorldInfo.transform:Find("power/bg/Word"), i18n("world_total_power"))
	setText(self.wsWorldInfo.transform:Find("explore/mileage/Text"), i18n("world_mileage"))
	setText(self.wsWorldInfo.transform:Find("explore/pressing/Text"), i18n("world_pressing"))

	self.rtTopBottom = self.rtTop:Find("bottom_stage")
	self.btnOperation = self.rtTopBottom:Find("btn/operation")
	self.btnSupply = self.rtTopBottom:Find("btn/supply")
	self.btnDockyard = self.rtTopBottom:Find("btn/dockyard")
	self.resPanel = WorldResource.New()

	self.resPanel._tf:SetParent(self.rtTop:Find("title/resources"), false)

	self.rtTaskWindow = self._tf:Find("task_window")
	self.wsTasks = {}
	self.wsGoods = {}
	self.page = -1
	self.dirtyFlags = {}
	self.cdTF = self.rtShop:Find("timer_bg")
	self.emptyTF = self.rtShop:Find("frame/scrollview/empty")
	self.refreshBtn = self.rtShop:Find("refresh_btn")

	setActive(self.refreshBtn, false)

	self.glitchArtMaterial = self._tf:Find("resource/material1"):GetComponent(typeof(Image)).material
	self.singleWindow = OriginShopSingleWindow.New(self._tf, self.event)
	self.multiWindow = OriginShopMultiWindow.New(self._tf, self.event)

	return
end

function WorldPortLayer:didEnter()
	self:BlurPanel(self._tf)
	onButton(self, self.btnBack, function()
		if self.isTweening then
			return
		end

		if self.port:IsTempPort() or self.page == WorldPortLayer.PageMain then
			self:EaseOutUI(function()
				self:closeView()

				return
			end)
		else
			self:SetPage(WorldPortLayer.PageMain)
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.btnOperation, function()
		self:SetPage(WorldPortLayer.PageTask)

		return
	end, SFX_PANEL)
	onButton(self, self.btnSupply, function()
		if nowWorld():UsePortNShop() then
			self:SetPage(WorldPortLayer.PageNShop)
		else
			self:SetPage(WorldPortLayer.PageShop)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.btnDockyard, function()
		self:emit(WorldPortMediator.OnOpenBay)

		return
	end, SFX_PANEL)
	self:UpdatePainting(self:GetPaintingInfo())
	self:UpdateTaskTip()
	self:UpdateCDTip()
	self:UpdateNShopTip()

	if self.port:IsTempPort() then
		self.contextData.page = WorldPortLayer.PageShop
	elseif self.contextData.page == WorldPortLayer.PageDockyard then
		self.contextData.page = nil
	end

	self:SetPage(self.contextData.page or WorldPortLayer.PageMain)
	self:EaseInUI()

	return
end

function WorldPortLayer:onBackPressed()
	triggerButton(self.btnBack)

	return
end

function WorldPortLayer:willExit()
	self:UnOverlayPanel(self._tf)
	self:RecyclePainting(self.rtPainting)
	self.singleWindow:Destroy()
	self.multiWindow:Destroy()

	self.contextData.isEnter = true

	if WorldPortLayer.BlurPages[self.page] then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.rtBlurPanel, self._tf)
	end

	self:CancelUITween()
	self:DisposeTopUI()
	self:DisposeTasks()
	self:DisposeGoods()
	self.atlas:RemoveListener(WorldAtlas.EventUpdateNGoodsCount, self.onUpdateNGoods)

	self.atlas = nil

	self.port:RemoveListener(WorldMapPort.EventUpdateTaskIds, self.onUpdateTasks)
	self.port:RemoveListener(WorldMapPort.EventUpdateGoods, self.onUpdateGoods)

	self.port = nil

	self.resPanel:exit()

	self.resPanel = nil

	self.refreshTimer:Stop()

	self.refreshTimer = nil

	self.inventory:RemoveListener(WorldInventoryProxy.EventUpdateItem, self.onUpdateMoneyCount)

	self.inventory = nil

	self.taskProxy:RemoveListener(WorldTaskProxy.EventUpdateTask, self.onUpdateTasks)

	self.taskProxy = nil

	self.wsWorldInfo:Dispose()

	self.wsWorldInfo = nil

	return
end

function WorldPortLayer:GetPaintingInfo()
	if self.port:IsTempPort() then
		return "mingshi", false
	else
		return "tbniang", true
	end

	return
end

function WorldPortLayer:UpdatePainting(arg_13_1, arg_13_2)
	self.paintingName = arg_13_1

	setPaintingPrefab(self.rtPainting, arg_13_1, "chuanwu")

	if arg_13_2 then
		self:AddGlitchArtEffectForPating(self.rtPainting)
	end

	return
end

function WorldPortLayer:AddGlitchArtEffectForPating(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs((arg_14_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
		iter_14_1.material = self.glitchArtMaterial
	end

	return
end

function WorldPortLayer:RecyclePainting(arg_15_1)
	if arg_15_1:Find("fitter").childCount > 0 then
		for iter_15_0, iter_15_1 in ipairs((arg_15_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
			if iter_15_1.material ~= iter_15_1.defaultGraphicMaterial then
				iter_15_1.material = iter_15_1.defaultGraphicMaterial

				iter_15_1.material:SetColor("_Color", Color.white)
			end
		end

		setGray(arg_15_1, false, true)

		local var_15_0 = arg_15_1:Find("fitter"):GetChild(0)

		retPaintingPrefab(arg_15_1, var_15_0.name)

		local var_15_1 = var_15_0:Find("temp_mask")

		if var_15_1 then
			Destroy(var_15_1)
		end
	end

	return
end

function WorldPortLayer:DisplayTopUI(arg_16_1)
	setActive(self.rtImageTitle, arg_16_1 == WorldPortLayer.PageMain)
	setActive(self.rtImageTitleTask, arg_16_1 == WorldPortLayer.PageTask)
	setActive(self.rtImageTitleShop, arg_16_1 == WorldPortLayer.PageShop or arg_16_1 == WorldPortLayer.PageNShop)
	setActive(self.rtTopLeft, arg_16_1 ~= WorldPortLayer.PageNShop)
	setActive(self.rtTopRight, arg_16_1 == WorldPortLayer.PageMain)
	setActive(self.rtTopBottom, arg_16_1 == WorldPortLayer.PageMain)
	setActive(self.rtBg, arg_16_1 ~= WorldPortLayer.PageNShop)
	setActive(self.rtBgNShop, arg_16_1 == WorldPortLayer.PageNShop)

	return
end

function WorldPortLayer:DisposeTopUI()
	self.wsPortLeft:Dispose()

	return
end

function WorldPortLayer:NewPortLeft()
	local var_18_0 = WSPortLeft.New()

	var_18_0.transform = self.rtTopLeft

	var_18_0:Setup()
	var_18_0:UpdateMap(nowWorld():GetActiveMap())

	return var_18_0
end

function WorldPortLayer:EnterPortAnim(arg_19_1)
	local var_19_0 = self.rtEnterIcon:GetComponent(typeof(DftAniEvent))

	if var_19_0 then
		var_19_0:SetTriggerEvent(function(arg_20_0)
			arg_19_1()

			return
		end)
		var_19_0:SetEndEvent(function(arg_21_0)
			setActive(self.rtEnterIcon, false)

			return
		end)
	end

	setActive(self.rtEnterIcon, true)

	return
end

function WorldPortLayer:EaseInUI(arg_22_1)
	self.isTweening = true

	local var_22_0 = {}

	self:CancelUITween()

	if #self.enterIcon > 0 and not self.contextData.isEnter then
		table.insert(var_22_0, function(arg_23_0)
			setActive(self.rtTop, false)
			self:EnterPortAnim(function()
				setActive(self.rtTop, true)

				return arg_23_0()
			end)

			return
		end)
	else
		setActive(self.rtEnterIcon, false)
	end

	seriesAsync(var_22_0, function()
		setAnchoredPosition(self.rtTopLeft, {
			x = -self.rtTopLeft.rect.width
		})
		setAnchoredPosition(self.rtTopRight, {
			x = self.rtTopRight.rect.width
		})
		setAnchoredPosition(self.rtTopTitle, {
			y = self.rtTopTitle.rect.height
		})
		setAnchoredPosition(self.rtTopBottom, {
			y = -self.rtTopRight.rect.height
		})
		LeanTween.moveX(self.rtTopLeft, 0, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine)
		LeanTween.moveX(self.rtTopRight, 0, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine)
		LeanTween.moveY(self.rtTopTitle, 0, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine)
		LeanTween.moveY(self.rtTopBottom, 0, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(function()
			self.isTweening = false

			return existCall(arg_22_1)
		end))

		return
	end)

	return
end

function WorldPortLayer:EaseOutUI(arg_27_1)
	self:CancelUITween()
	LeanTween.moveX(self.rtTopLeft, -self.rtTopLeft.rect.width, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine)
	LeanTween.moveX(self.rtTopRight, self.rtTopRight.rect.width, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine)
	LeanTween.moveY(self.rtTopTitle, self.rtTopTitle.rect.height, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine)
	LeanTween.moveY(self.rtTopBottom, -self.rtTopRight.rect.height, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(function()
		self.isTweening = false

		return existCall(arg_27_1)
	end))

	return
end

function WorldPortLayer:CancelUITween()
	LeanTween.cancel(go(self.rtTopTitle))
	LeanTween.cancel(go(self.rtTopLeft))
	LeanTween.cancel(go(self.rtTopRight))
	LeanTween.cancel(go(self.rtTopBottom))

	return
end

function WorldPortLayer:SetPlayer(arg_30_1)
	self.player = arg_30_1

	self.resPanel:setPlayer(arg_30_1)

	return
end

function WorldPortLayer:SetAtlas(arg_31_1)
	self.atlas = arg_31_1

	self.atlas:AddListener(WorldAtlas.EventUpdateNGoodsCount, self.onUpdateNGoods)

	self.nGoodsDic = {}
	self.nGoodsPortDic = {}

	for iter_31_0, iter_31_1 in pairs(arg_31_1.nShopGoodsDic) do
		self.nGoodsDic[iter_31_0] = Goods.Create({
			id = iter_31_0,
			count = iter_31_1
		}, Goods.TYPE_WORLD_NSHOP)

		local var_31_0 = self.nGoodsDic[iter_31_0]:getConfig("port_id")

		self.nGoodsPortDic[var_31_0] = self.nGoodsPortDic[var_31_0] or {}

		table.insert(self.nGoodsPortDic[var_31_0], self.nGoodsDic[iter_31_0])
	end

	for iter_31_2, iter_31_3 in pairs(self.nGoodsPortDic) do
		table.sort(iter_31_3, CompareFuncs({
			function(arg_32_0)
				return -arg_32_0:getConfig("priority")
			end,
			function(arg_33_0)
				return arg_33_0.id
			end
		}))
	end

	return
end

function WorldPortLayer:SetPort(arg_34_1)
	local var_34_0 = nowWorld()

	self.port = arg_34_1

	self.port:AddListener(WorldMapPort.EventUpdateTaskIds, self.onUpdateTasks)
	self.port:AddListener(WorldMapPort.EventUpdateGoods, self.onUpdateGoods)
	self:SetBg(self.port.id)

	self.refreshTimer = Timer.New(function()
		if self.port:IsValid() then
			self:UpdateRefreshTime(self.port.expiredTime - pg.TimeMgr.GetInstance():GetServerTime())
		else
			self:emit(WorldPortMediator.OnReqPort, var_34_0:GetActiveMap().id)
		end

		return
	end, 1, -1)

	self.refreshTimer:Start()
	self.refreshTimer.func()

	local var_34_1 = var_34_0:GetActiveMap():GetFleet()

	self.wsPortLeft = self:NewPortLeft()

	local var_34_2 = self.port:GetRealm()

	setActive(self.btnOperation, var_34_2 == 0 or var_34_2 == var_34_0:GetRealm())
	setActive(self.btnDockyard, var_34_2 == 0 or var_34_2 == var_34_0:GetRealm())
	setActive(self.btnSupply, self.nGoodsPortDic[arg_34_1.id])
	setActive(self.resPanel._tf, var_34_0:IsSystemOpen(WorldConst.SystemResource))

	self.inventory = var_34_0:GetInventoryProxy()

	self.inventory:AddListener(WorldInventoryProxy.EventUpdateItem, self.onUpdateMoneyCount)
	self:OnUpdateMoneyCount()

	self.taskProxy = var_34_0:GetTaskProxy()

	self.taskProxy:AddListener(WorldTaskProxy.EventUpdateTask, self.onUpdateTasks)

	return
end

function WorldPortLayer:SetBg(arg_36_1)
	self.portBg = pg.world_port_data[arg_36_1].port_bg

	setImageAlpha(self.rtBg, #self.portBg > 0 and 1 or 0)

	if #self.portBg > 0 then
		GetImageSpriteFromAtlasAsync("world/port/" .. self.portBg, "", self.rtBg)
	end

	self.enterIcon = pg.world_port_data[arg_36_1].port_entrance_icon

	setActive(self.rtEnterIcon, #self.enterIcon > 0)

	if #self.enterIcon > 0 then
		GetImageSpriteFromAtlasAsync("world/porttitle/" .. self.enterIcon, "", self.rtEnterIcon, false)
	end

	GetImageSpriteFromAtlasAsync("world/portword/" .. self.portBg, "", self.rtImageTitle, true)
	GetImageSpriteFromAtlasAsync("world/portword/" .. self.portBg .. "_en", "", self.rtImageTitle:Find("Image"), true)

	return
end

function WorldPortLayer:OnUpdateTasks()
	self:UpdateTaskTip()
	self:SetPageDirty(WorldPortLayer.PageTask)

	if self.page == WorldPortLayer.PageTask then
		self:UpdateTasks()
	end

	return
end

function WorldPortLayer:OnUpdateGoods()
	self:UpdateCDTip()
	self:SetPageDirty(WorldPortLayer.PageShop)

	if self.page == WorldPortLayer.PageShop then
		self:UpdateGoods()
	end

	return
end

function WorldPortLayer:OnUpdateNGoods(arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	if self.page == WorldPortLayer.PageNShop then
		self.nGoodsDic[arg_39_3].buyCount = arg_39_4

		setText(self.rtNGoodsDic[arg_39_3]:Find("count_contain/count"), self.nGoodsDic[arg_39_3]:GetPurchasableCnt() .. "/" .. self.nGoodsDic[arg_39_3]:GetLimitGoodCount())
		setActive(self.rtNGoodsDic[arg_39_3]:Find("mask"), not self.nGoodsDic[arg_39_3]:canPurchase())
		setActive(self.rtNGoodsDic[arg_39_3]:Find("new"), false)
	else
		self:SetPageDirty(WorldPortLayer.PageNShop)
	end

	return
end

function WorldPortLayer:SetPage(arg_40_1)
	if self.page ~= arg_40_1 then
		if WorldPortLayer.BlurPages[self.page or 0] ~= WorldPortLayer.BlurPages[arg_40_1] then
			if WorldPortLayer.BlurPages[arg_40_1] then
				pg.UIMgr.GetInstance():BlurPanel(self.rtBlurPanel)
			else
				pg.UIMgr.GetInstance():UnOverlayPanel(self.rtBlurPanel, self._tf)
			end
		end

		if arg_40_1 == WorldPortLayer.PageShop and self.paintingName == "buzhihuo_shop" then
			self:showRandomShipWord(pg.navalacademy_shoppingstreet_template[1].words_enter, true, "enter")
		end

		self.page = arg_40_1

		self:UpdatePage()

		self.contextData.page = arg_40_1
	end

	return
end

function WorldPortLayer:SetPageDirty(arg_41_1)
	self.dirtyFlags[arg_41_1] = true

	return
end

function WorldPortLayer:IsPageDirty(arg_42_1)
	return self.dirtyFlags[arg_42_1] == true or self.dirtyFlags[arg_42_1] == nil
end

function WorldPortLayer:UpdatePage()
	self:DisplayTopUI(self.page)
	setActive(self.rtTasks, self.page == WorldPortLayer.PageTask)
	setActive(self.rtShop, self.page == WorldPortLayer.PageShop)
	setActive(self.rtNShop, self.page == WorldPortLayer.PageNShop)

	if self:IsPageDirty(self.page) then
		if self.page == WorldPortLayer.PageTask then
			self:UpdateTasks()
		elseif self.page == WorldPortLayer.PageShop then
			self:UpdateGoods()
		elseif self.page == WorldPortLayer.PageNShop then
			self:UpdateNShopPorts()
		end
	end

	return
end

function WorldPortLayer:UpdateTasks()
	self.dirtyFlags[WorldPortLayer.PageTask] = false

	local var_44_0 = self.rtTasks:Find("frame/viewport/content")
	local var_44_1 = _.map(self.port.taskIds, function(arg_45_0)
		return WorldTask.New({
			id = arg_45_0
		})
	end)

	table.sort(var_44_1, CompareFuncs(WorldTask.sortDic))
	UIItemList.StaticAlign(var_44_0, var_44_0:GetChild(0), #var_44_1, function(arg_46_0, arg_46_1, arg_46_2)
		if arg_46_0 == UIItemList.EventUpdate then
			local var_46_0 = var_44_1[arg_46_1 + 1]

			self.wsTasks[arg_46_1 + 1] = self.wsTasks[arg_46_1 + 1] or WSPortTask.New(arg_46_2)

			self.wsTasks[arg_46_1 + 1]:Setup(var_44_1[arg_46_1 + 1])
			onButton(self, self.wsTasks[arg_46_1 + 1].btnInactive, function()
				self:emit(WorldPortMediator.OnAccepetTask, var_46_0, self.port.id)

				return
			end, SFX_PANEL)
			onButton(self, self.wsTasks[arg_46_1 + 1].btnOnGoing, function()
				self:showTaskWindow(var_46_0)

				return
			end, SFX_PANEL)
			onButton(self, self.wsTasks[arg_46_1 + 1].btnFinished, function()
				self:emit(WorldPortMediator.OnSubmitTask, var_46_0)

				return
			end, SFX_PANEL)

			self.wsTasks[arg_46_1 + 1].onDrop = function(arg_50_0)
				self:emit(WorldPortLayer.ON_DROP, arg_50_0)

				return
			end
		end

		return
	end)
	setActive(self.rtTasks:Find("frame/empty"), #var_44_1 == 0)

	return
end

function WorldPortLayer:DisposeTasks()
	_.each(self.wsTasks, function(arg_52_0)
		arg_52_0:Dispose()

		return
	end)

	self.wsTasks = {}

	return
end

function WorldPortLayer:UpdateGoods()
	self.dirtyFlags[WorldPortLayer.PageShop] = false

	local var_53_0 = self.rtShop:Find("frame/scrollview/view")
	local var_53_1 = underscore.rest(self.port.goods, 1)

	table.sort(var_53_1, CompareFuncs({
		function(arg_54_0)
			return -arg_54_0.config.priority
		end,
		function(arg_55_0)
			return arg_55_0.id
		end
	}))
	UIItemList.StaticAlign(var_53_0, var_53_0:GetChild(0), #var_53_1, function(arg_56_0, arg_56_1, arg_56_2)
		arg_56_1 = arg_56_1 + 1

		if arg_56_0 == UIItemList.EventUpdate then
			local var_56_0 = var_53_1[arg_56_1]

			self.wsGoods[arg_56_1] = self.wsGoods[arg_56_1] or WSPortGoods.New(arg_56_2)

			self.wsGoods[arg_56_1]:Setup(var_53_1[arg_56_1])
			onButton(self, self.wsGoods[arg_56_1].transform, function()
				if var_56_0.count > 0 then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						yesText = "text_buy",
						type = MSGBOX_TYPE_SINGLE_ITEM,
						drop = var_56_0.item,
						onYes = function()
							self:emit(WorldPortMediator.OnBuyGoods, var_56_0)

							return
						end
					})
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function WorldPortLayer:DisposeGoods()
	_.each(self.wsGoods, function(arg_60_0)
		arg_60_0:Dispose()

		return
	end)

	self.wsGoods = {}

	return
end

function WorldPortLayer:UpdateNShopPorts()
	self.dirtyFlags[WorldPortLayer.PageNShop] = false

	local var_61_0 = underscore.keys(self.nGoodsPortDic)

	table.sort(var_61_0)

	for iter_61_0, iter_61_1 in ipairs(var_61_0) do
		if not self.poolTplPort[iter_61_0] then
			table.insert(self.poolTplPort, cloneTplTo(self.tplPort, self.containerPort))
		end

		local var_61_1 = self.poolTplPort[iter_61_0]

		setText(self.poolTplPort[iter_61_0]:Find("Text"), pg.world_port_data[iter_61_1].name)
		setActive(var_61_1:Find("tip"), self.atlas.markPortDic.newGoods[iter_61_1])
		onToggle(self, var_61_1, function(arg_62_0)
			if arg_62_0 then
				if self.nShopPortId == iter_61_1 then
					return
				end

				setActive(var_61_1:Find("tip"), false)
				self.atlas:UpdatePortMarkNShop(iter_61_1, false)
				self:UpdateNShopTip()
				self:UpdateNShopGoods(iter_61_1)
			end

			return
		end, SFX_PANEL)
		triggerToggle(var_61_1, iter_61_1 == self.port.id)
	end

	return
end

function WorldPortLayer:UpdateNShopGoods(arg_63_1)
	self.nShopPortId = arg_63_1

	local var_63_0 = self.atlas:GetPressingUnlockCount()
	local var_63_1 = self.atlas:GetPressingUnlockRecordCount(arg_63_1)
	local var_63_2 = {}

	for iter_63_0, iter_63_1 in ipairs(self.nGoodsPortDic[arg_63_1]) do
		local var_63_3 = iter_63_1:getConfig("unlock_num")

		var_63_2[var_63_3] = var_63_2[var_63_3] or {}

		table.insert(var_63_2[var_63_3], iter_63_1)
	end

	self.rtNGoodsDic = {}

	local var_63_4 = underscore.keys(var_63_2)

	table.sort(var_63_4)
	UIItemList.StaticAlign(self.rtNGoodsContainer, self.rtNGoodsContainer:Find("group"), #var_63_4, function(arg_64_0, arg_64_1, arg_64_2)
		arg_64_1 = arg_64_1 + 1

		if arg_64_0 == UIItemList.EventUpdate then
			local var_64_0 = var_63_4[arg_64_1]

			setActive(arg_64_2:Find("title"), arg_64_1 > 1)
			setText(arg_64_2:Find("title/other/Text"), i18n("world_instruction_port_goods_locked"))
			setText(arg_64_2:Find("title/other/progress"), math.min(var_63_0, var_64_0) .. "/" .. var_64_0)

			local var_64_1 = arg_64_2:Find("container")

			UIItemList.StaticAlign(var_64_1, var_64_1:Find("item_tpl"), #var_63_2[var_64_0], function(arg_65_0, arg_65_1, arg_65_2)
				arg_65_1 = arg_65_1 + 1

				if arg_65_0 == UIItemList.EventUpdate then
					local var_65_0 = var_63_2[var_64_0][arg_65_1]

					self.rtNGoodsDic[var_63_2[var_64_0][arg_65_1].id] = arg_65_2

					local var_65_1 = var_65_0:GetDropInfo()

					updateDrop(arg_65_2:Find("IconTpl"), var_65_1)
					setText(arg_65_2:Find("name_mask/name"), shortenString(var_65_1:getConfig("name"), 6))

					local var_65_2 = var_65_0:GetPriceInfo()

					GetImageSpriteFromAtlasAsync(var_65_2:getIcon(), "", arg_65_2:Find("consume/contain/icon"), false)
					setText(arg_65_2:Find("consume/contain/Text"), var_65_2.count)
					setText(arg_65_2:Find("count_contain/count"), var_65_0:GetPurchasableCnt() .. "/" .. var_65_0:GetLimitGoodCount())
					setText(arg_65_2:Find("count_contain/label"), i18n("activity_shop_exchange_count"))
					setText(arg_65_2:Find("mask/tag/sellout_tag"), i18n("word_sell_out"))
					setActive(arg_65_2:Find("mask"), not var_65_0:canPurchase())
					setText(arg_65_2:Find("lock/Image/Text"), i18n("word_sell_lock"))
					setActive(arg_65_2:Find("lock"), var_63_0 < var_64_0)
					setActive(arg_65_2:Find("new"), var_65_0.buyCount == 0 and var_63_1 < var_64_0 and var_64_0 <= var_63_0)
					onButton(self, arg_65_2, function()
						((var_65_0:GetLimitGoodCount() > 1 or nil) and (self.multiWindow or self.singleWindow)):ExecuteAction("Open", var_65_0, function(arg_67_0, arg_67_1)
							self:emit(WorldPortMediator.OnBuyNShopGoods, arg_67_0, arg_67_1)

							return
						end)

						return
					end, SFX_PANEL)
				end

				return
			end)
		end

		return
	end)
	self.atlas:SetPressingUnlockRecordCount(arg_63_1, var_63_0)

	return
end

function WorldPortLayer:OnUpdateMoneyCount(arg_68_1, arg_68_2, arg_68_3)
	if not arg_68_1 or arg_68_3.id == WorldItem.PortMoneyId then
		local var_68_0 = self.inventory:GetItemCount(WorldItem.PortMoneyId)

		setText(self.rtShop:Find("quick_count/value"), var_68_0)
		setText(self.rtNShopRes:Find("Text"), var_68_0)
	end

	return
end

function WorldPortLayer:UpdateRefreshTime(arg_69_1)
	setText(self.cdTF:Find("Text"), pg.TimeMgr.GetInstance():DescCDTime(arg_69_1))

	return
end

function WorldPortLayer:UpdateCDTip()
	setActive(self.cdTF, #self.port.goods > 0 and not self.port:IsTempPort())
	setActive(self.emptyTF, #self.port.goods == 0)

	if not nowWorld():UsePortNShop() then
		setActive(self.btnSupply:Find("new"), nowWorld():GetAtlas().markPortDic.goods[self.port.id])
	end

	return
end

function WorldPortLayer:UpdateTaskTip()
	setActive(self.btnOperation:Find("new"), false)

	return
end

function WorldPortLayer:UpdateNShopTip()
	if nowWorld():UsePortNShop() then
		setActive(self.btnSupply:Find("new"), self.atlas:GetAnyPortMarkNShop())
	end

	return
end

function WorldPortLayer:showTaskWindow(arg_73_1)
	local var_73_0 = self.rtTaskWindow:Find("main_window/left_panel")

	setActive(var_73_0:Find("bg"), arg_73_1:IsSpecialType())

	if #arg_73_1.config.rare_task_icon > 0 then
		GetImageSpriteFromAtlasAsync("shipyardicon/" .. arg_73_1.config.rare_task_icon, "", var_73_0:Find("card"), true)
	else
		GetImageSpriteFromAtlasAsync("ui/worldportui_atlas", "nobody", var_73_0:Find("card"), true)
	end

	local var_73_1 = self.rtTaskWindow:Find("main_window/right_panel")

	setText(var_73_1:Find("title/Text"), arg_73_1.config.name)
	setText(var_73_1:Find("content/desc"), arg_73_1.config.rare_task_text)
	setText(var_73_1:Find("content/slider_progress/Text"), arg_73_1:getProgress() .. "/" .. arg_73_1:getMaxProgress())
	setSlider(var_73_1:Find("content/slider"), 0, arg_73_1:getMaxProgress(), arg_73_1:getProgress())

	local var_73_2 = var_73_1:Find("content/item_tpl")
	local var_73_3 = var_73_1:Find("content/award_bg/panel/content")
	local var_73_4 = arg_73_1.config.show

	removeAllChildren(var_73_3)

	for iter_73_0, iter_73_1 in ipairs(var_73_4) do
		local var_73_5 = cloneTplTo(var_73_2, var_73_3)
		local var_73_6 = {
			type = iter_73_1[1],
			id = iter_73_1[2],
			count = iter_73_1[3]
		}

		updateDrop(var_73_5, var_73_6)
		onButton(self, var_73_5, function()
			self:emit(WorldPortLayer.ON_DROP, var_73_6)

			return
		end, SFX_PANEL)
		setActive(var_73_5, true)
	end

	setActive(var_73_2, false)
	setActive(var_73_1:Find("content/award_bg/arror"), #var_73_4 > 3)
	onButton(self, var_73_1:Find("btn_close"), function()
		self:hideTaskWindow()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtTaskWindow:Find("bg"), function()
		self:hideTaskWindow()

		return
	end, SFX_CANCEL)
	onButton(self, var_73_1:Find("btn_go"), function()
		self:hideTaskWindow()
		self:emit(WorldPortMediator.OnTaskGoto, arg_73_1.id)

		return
	end, SFX_PANEL)
	setButtonEnabled(var_73_1:Find("btn_go"), arg_73_1:GetFollowingAreaId() or arg_73_1:GetFollowingEntrance())
	setActive(self.rtTaskWindow, true)
	pg.UIMgr.GetInstance():BlurPanel(self.rtTaskWindow)

	return
end

function WorldPortLayer:hideTaskWindow()
	setActive(self.rtTaskWindow, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.rtTaskWindow, self._tf)

	return
end

return WorldPortLayer
