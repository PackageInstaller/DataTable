local IslandOrderPage = class("IslandOrderPage", import("...base.IslandBasePage"))

IslandOrderPage.ON_UPDADE = "IslandOrderPage:ON_UPDADE"

function IslandOrderPage:getUIName()
	return "IslandOrderUI"
end

function IslandOrderPage:OnLoaded()
	self.backBtn = self._tf:Find("top/back")
	self.favorBtn = self._tf:Find("top/favor_bg")
	self.levelTxt = self._tf:Find("top/favor_bg/level"):GetComponent(typeof(Text))
	self.expTxt = self._tf:Find("top/favor_bg/Text"):GetComponent(typeof(Text))
	self.charTr = self._tf:Find("bottom/char")
	self.chatTxt = self.charTr:Find("dialogue/Text"):GetComponent(typeof(Text))
	self.trendBtn = self._tf:Find("trend_btn")
	self.trendIco = self.trendBtn:Find("difficulty"):GetComponent(typeof(Image))
	self.trendTxt = self.trendBtn:Find("Text"):GetComponent(typeof(Text))
	self.orderContainer = self._tf:Find("map")
	self.upgradePage = IslandOrderUpgradePage.New(self._parentTf)
	self.countTxt = self._tf:Find("count_bg/Text"):GetComponent(typeof(Text))
	self.orderTplPool = OrderTplPool.New(self._tf:Find("root/orderTpl"), 3, 6)
	self.orderTpls = {}
	self.timers = {}
	self.disappearTimers = {}

	setActive(self.charTr, false)
	setText(self._tf:Find("top/title/Text"), i18n("island_order_title"))

	return
end

function IslandOrderPage:OnHide()
	if self.upgradePage:GetLoaded() then
		self.upgradePage:Destroy()
		self.upgradePage:Reset()
	end

	return
end

function IslandOrderPage:OnInit()
	onButton(self, self._tf:Find("top/title/help"), function()
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_helpbtn_order")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.favorBtn, function()
		self:OpenPage(IslandOrderLevelInfoPage)

		return
	end, SFX_PANEL)
	onButton(self, self.trendBtn, function()
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_ORDER_TENDENCY,
			title = i18n("island_order_difficulty"),
			selected = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetTendency(),
			onYes = function(arg_9_0)
				self:emit(IslandMediator.SET_ORDER_TENDENCY, arg_9_0)

				return
			end
		})

		return
	end, SFX_PANEL)
	self:UpdateFavorBtn()

	return
end

function IslandOrderPage:UpdateFavorBtn()
	setActive(self.favorBtn, getProxy(IslandProxy):GetIsland():GetOrderAgency():ExpSystemIsOpen())

	return
end

function IslandOrderPage:AddListeners()
	self:AddListener(GAME.ISLAND_SUBMIT_ORDER_DONE, self.OnSubmitOrder)
	self:AddListener(GAME.ISLAND_REPLACE_ORDER_DONE, self.OnReplaceOrder)
	self:AddListener(IslandOrderAgency.GEN_NEW_ORDER, self.OnGenNewOrder)
	self:AddListener(IslandOrderAgency.UDPATE_ORDER, self.OnFlushOrder)
	self:AddListener(GAME.ISLAND_SET_ORDER_TENDENCY_DONE, self.OnOrderTendencyChanged)
	self:AddListener(IslandScene.ON_CHECK_ORDER_EXP_AWARD, self.OnCheckOrderExpAward)
	self:AddListener(IslandOrderPage.ON_UPDADE, self.OnUpgrade)
	self:AddListener(IslandOrderAgency.ORDER_FINISH_UPDATE, self.OnUpdateFinishCnt)
	self:AddListener(GAME.ISLAND_USE_TICKET_DONE, self.OnUseTicketDone)
	self:AddListener(IslandAblityAgency.UNLOCK_SYSTEM, self.OnUnlockSystem)

	return
end

function IslandOrderPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_SUBMIT_ORDER_DONE, self.OnSubmitOrder)
	self:RemoveListener(GAME.ISLAND_REPLACE_ORDER_DONE, self.OnReplaceOrder)
	self:RemoveListener(GAME.ISLAND_SET_ORDER_TENDENCY_DONE, self.OnOrderTendencyChanged)
	self:RemoveListener(IslandOrderAgency.GEN_NEW_ORDER, self.OnGenNewOrder)
	self:RemoveListener(IslandOrderAgency.UDPATE_ORDER, self.OnFlushOrder)
	self:RemoveListener(IslandOrderPage.ON_UPDADE, self.OnUpgrade)
	self:RemoveListener(IslandOrderAgency.ORDER_FINISH_UPDATE, self.OnUpdateFinishCnt)
	self:RemoveListener(GAME.ISLAND_USE_TICKET_DONE, self.OnUseTicketDone)
	self:RemoveListener(IslandAblityAgency.UNLOCK_SYSTEM, self.OnUnlockSystem)

	return
end

function IslandOrderPage:OnUnlockSystem()
	self:UpdateFavorBtn()
	self:CheckOrderExpAward()

	return
end

function IslandOrderPage:OnReset()
	self:Flush()

	return
end

function IslandOrderPage:OnUpgrade(arg_15_1)
	self.upgradePage:ExecuteAction("Show", arg_15_1.level, arg_15_1.callback)

	return
end

function IslandOrderPage:OnOrderTendencyChanged()
	self:UpdateTrendBtn((getProxy(IslandProxy):GetIsland():GetOrderAgency()))

	return
end

function IslandOrderPage:OnSubmitOrder(arg_17_1)
	local var_17_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	self:UpdateExpPanel(var_17_0)
	self:UpdateOrderState(arg_17_1.slotId)
	self:UpdateCount(var_17_0)

	for iter_17_0, iter_17_1 in pairs(self.orderTpls or {}) do
		self:UpdateOrderState(iter_17_0)
	end

	return
end

function IslandOrderPage:OnReplaceOrder(arg_18_1)
	self:UpdateOrderState(arg_18_1.slotId)

	return
end

function IslandOrderPage:OnGenNewOrder(arg_19_1)
	self:UpdateOrderState(arg_19_1.slotId)

	return
end

function IslandOrderPage:OnFlushOrder(arg_20_1)
	self:UpdateOrderState(arg_20_1.slotId)

	return
end

function IslandOrderPage:OnUseTicketDone(arg_21_1)
	if arg_21_1.type == IslandUseTicketCommand.TYPES.ORDER_CD then
		self:UpdateOrderState(arg_21_1.id)
	end

	return
end

function IslandOrderPage:OnCheckOrderExpAward()
	self:CheckOrderExpAward()

	return
end

function IslandOrderPage:OnUpdateFinishCnt()
	local var_23_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	self:UpdateCount(var_23_0)
	self:UpdateExpPanel(var_23_0)

	return
end

function IslandOrderPage:Show()
	IslandOrderPage.super.Show(self)
	self:Flush()

	return
end

function IslandOrderPage:Flush()
	local var_25_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	self:UpdateExpPanel(var_25_0)
	self:GenOrderList(var_25_0)
	self:TriggerOrder(var_25_0)
	self:UpdateTrendBtn(var_25_0)
	self:UpdateCount(var_25_0)
	self:CheckOrderExpAward()

	return
end

function IslandOrderPage:UpdateCount(arg_26_1)
	local var_26_0 = arg_26_1:GetMaxFinishCount()

	self.countTxt.text = i18n("island_order_leftCnt_tip") .. var_26_0 - arg_26_1:GetFinishCnt() .. "/" .. var_26_0

	return
end

function IslandOrderPage:UpdateTrendBtn(arg_27_1)
	local var_27_0 = arg_27_1:GetTendency()

	self.trendTxt.text = IslandOrderSlot.TENDENCY2CN(var_27_0)
	self.trendIco.sprite = GetSpriteFromAtlas("ui/IslandOrderUI_atlas", ({
		"icon_common",
		"icon_easy",
		"icon_hard"
	})[var_27_0 + 1])

	return
end

function IslandOrderPage:CheckOrderExpAward()
	local var_28_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency()
	local var_28_1

	if not var_28_0:ExpSystemIsOpen() then
		self:CheckGuide()

		do return end

		var_28_1 = {}
	end

	for iter_28_0, iter_28_1 in ipairs((var_28_0:GetAllCanGetAwardList())) do
		table.insert(var_28_1, function(arg_29_0)
			self:emit(IslandMediator.ON_GET_ORDER_EXP_AWARD, iter_28_1, arg_29_0)

			return
		end)
	end

	seriesAsync(var_28_1, function()
		self:CheckGuide()

		return
	end)

	return
end

function IslandOrderPage:CheckGuide()
	if getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTask(IslandGuideChecker.ORDER_TASK_ID) then
		onDelayTick(function()
			local var_32_0 = getProxy(IslandProxy):GetIsland()
			local var_32_1 = var_32_0:GetInventoryAgency()
			local var_32_2 = underscore.all(IslandGuideChecker.ORDER_NEED_ITEMS, function(arg_33_0)
				return var_32_1:GetOwnCount(arg_33_0[1]) >= arg_33_0[2]
			end) and {
				1,
				2
			} or {
				1,
				3
			}

			IslandGuideChecker.CheckGuideWithArgs("ISLAND_GUIDE_7", IslandGuideChecker.FINISH_TYPE.ON_GUIDE, nil, var_32_0)

			return
		end, 0.2)
	end

	return
end

function IslandOrderPage:TriggerOrder(arg_34_1)
	local var_34_0 = arg_34_1:GetSlots()
	local var_34_1 = var_34_0[arg_34_1:GetCacheSelectedId()]

	if var_34_1 and not var_34_1:IsEmpty() then
		if self.orderTpls[var_34_1.id] then
			triggerButton(self.orderTpls[var_34_1.id])
		end
	else
		local var_34_2

		for iter_34_0, iter_34_1 in pairs(var_34_0) do
			if not iter_34_1:IsEmpty() then
				var_34_2 = iter_34_1

				break
			end
		end

		if var_34_2 then
			if self.orderTpls[var_34_2.id] then
				triggerButton(self.orderTpls[var_34_2.id])
			end
		end
	end

	return
end

function IslandOrderPage:GenOrderList(arg_35_1)
	self:ReturnOrderTplList()

	for iter_35_0, iter_35_1 in pairs((arg_35_1:GetSlots())) do
		self:NewOrderTpl(iter_35_1.id)
		self:UpdateOrderState(iter_35_1.id)
	end

	return
end

function IslandOrderPage:NewOrderTpl(arg_36_1)
	local var_36_0 = self.orderTplPool:Dequeue()

	setParent(var_36_0, self.orderContainer)

	self.orderTpls[arg_36_1] = var_36_0

	return var_36_0
end

function IslandOrderPage:ReturnOrderTplList()
	for iter_37_0, iter_37_1 in pairs(self.orderTpls) do
		self.orderTplPool:Enqueue(iter_37_1)
	end

	self.orderTpls = {}

	return
end

function IslandOrderPage:UpdateOrderState(arg_38_1)
	local var_38_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetSlot(arg_38_1)
	local var_38_1 = self.orderTpls[arg_38_1] or self:NewOrderTpl(arg_38_1)

	self:RemoveLoadingTimer(arg_38_1)
	self:RemoveDisappearTimer(arg_38_1)
	self:ShowDiaglog(var_38_0)

	if not var_38_0 or var_38_0:IsEmpty() then
		removeOnButton(var_38_1)
		setActive(var_38_1, false)

		return
	end

	var_38_1.transform.localPosition = var_38_0:GetPosition()

	setActive(var_38_1, true)
	onButton(self, var_38_1, function()
		self:ClickOrder(var_38_1, var_38_0)

		self.selected = var_38_1

		return
	end, SFX_PANEL)

	local var_38_2 = var_38_0:GetOrder()

	setActive(var_38_1.transform:Find("bg_urgent"), var_38_2:IsUrgency())
	setActive(var_38_1.transform:Find("bg_act"), var_38_2:IsActivity())
	setActive(var_38_1.transform:Find("sel"), self.selected and self.selected == var_38_1)
	setActive(var_38_1.transform:Find("finish"), (var_38_0:CanSubmit()))
	setActive(var_38_1.transform:Find("easy"), var_38_2:GetTendency() == IslandOrderSlot.TENDENCY_TYPE_EASY)
	setActive(var_38_1.transform:Find("hard"), var_38_2:GetTendency() == IslandOrderSlot.TENDENCY_TYPE_HARD)

	local var_38_3 = var_38_0:IsLoading()

	setActive(var_38_1.transform:Find("icon"), not var_38_3)
	setActive(var_38_1.transform:Find("loading"), var_38_3)
	setActive(var_38_1.transform:Find("bg/progress"), not var_38_3)
	GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. var_38_2:GetRoleIcon(), "", var_38_1.transform:Find("icon"))

	if var_38_3 then
		self:AddLoadingTimer(var_38_1, var_38_0)
	end

	if var_38_2:IsUrgency() then
		self:AddDisappearTimer(var_38_1, var_38_0)
	end

	return
end

function IslandOrderPage:AddDisappearTimer(arg_40_1, arg_40_2)
	self:RemoveDisappearTimer(arg_40_2.id)

	local var_40_0 = arg_40_2:GetDisappearTime()

	if var_40_0 <= pg.TimeMgr.GetInstance():GetServerTime() then
		return
	end

	self.disappearTimers[arg_40_2.id] = Timer.New(function()
		local var_41_0 = var_40_0 - pg.TimeMgr.GetInstance():GetServerTime()

		setText(arg_40_1.transform:Find("bg_urgent/time_label/Text"), (pg.TimeMgr.GetInstance():DescCDTime(var_41_0)))

		if var_41_0 < 0 then
			self:UpdateOrderState(arg_40_2.id)
		end

		return
	end, 1, -1)

	self.disappearTimers[arg_40_2.id].func()
	self.disappearTimers[arg_40_2.id]:Start()

	return
end

function IslandOrderPage:RemoveDisappearTimer(arg_42_1)
	if self.disappearTimers[arg_42_1] then
		self.disappearTimers[arg_42_1]:Stop()

		self.disappearTimers[arg_42_1] = nil
	end

	return
end

function IslandOrderPage:ClickOrder(arg_43_1, arg_43_2)
	self:OpenPage(IslandOrderDescPage, arg_43_2)
	self:ShowDiaglog(arg_43_2)
	getProxy(IslandProxy):GetIsland():GetOrderAgency():SetCacheSelectedId(arg_43_2.id)

	if self.selected then
		setActive(self.selected.transform:Find("sel"), false)
	end

	setActive(arg_43_1.transform:Find("sel"), true)

	return
end

function IslandOrderPage:ShowDiaglog(arg_44_1)
	if not arg_44_1 or not arg_44_1:GetOrder() or arg_44_1:IsEmpty() or arg_44_1:IsLoading() then
		setActive(self.charTr, false)

		return
	end

	local var_44_0 = arg_44_1:GetOrder()

	setActive(self.charTr, true)
	GetImageSpriteFromAtlasAsync("island/IslandShipIconHalf/" .. var_44_0:GetRoleIcon(), "", self.charTr)

	self.chatTxt.text = var_44_0:GetDesc()

	return
end

function IslandOrderPage:AddLoadingTimer(arg_45_1, arg_45_2)
	local function var_45_0()
		self:UpdateOrderState(arg_45_2.id)

		return
	end

	local var_45_1 = arg_45_2:GetCanSubmitTime()
	local var_45_2 = arg_45_2:GetTotalTime()
	local var_45_3 = Timer.New(function()
		local var_47_0 = var_45_1 - pg.TimeMgr.GetInstance():GetServerTime()

		setText(arg_45_1.transform:Find("loading/time_label/Text"), pg.TimeMgr.GetInstance():DescCDTime(var_47_0))
		setFillAmount(arg_45_1.transform:Find("loading/progress"), 1 - var_47_0 / var_45_2)

		if var_47_0 <= 0 then
			var_45_0()
		end

		return
	end, 1, -1)

	var_45_3:Start()
	var_45_3.func()

	self.timers[arg_45_2.id] = var_45_3

	return
end

function IslandOrderPage:RemoveLoadingTimer(arg_48_1)
	if self.timers[arg_48_1] then
		self.timers[arg_48_1]:Stop()

		self.timers[arg_48_1] = nil
	end

	return
end

function IslandOrderPage:RemoveAllLoadingTimer()
	for iter_49_0, iter_49_1 in pairs(self.timers) do
		iter_49_1:Stop()
	end

	for iter_49_2, iter_49_3 in pairs(self.disappearTimers) do
		iter_49_3:Stop()
	end

	self.disappearTimers = {}
	self.timers = {}

	return
end

function IslandOrderPage:UpdateExpPanel(arg_50_1)
	self.levelTxt.text = arg_50_1:GetLevel()
	self.expTxt.text = arg_50_1:IsMaxLevel() and "MAX" or arg_50_1:GetExp() .. "/" .. math.max(1, arg_50_1:GetNextTargetExp())

	return
end

function IslandOrderPage:OnDestroy()
	if self.upgradePage:GetLoaded() then
		self.upgradePage:Destroy()

		self.upgradePage = nil
	end

	if self.orderTplPool then
		self.orderTplPool:Dispose()

		self.orderTplPool = nil
	end

	self:RemoveAllLoadingTimer()

	return
end

return IslandOrderPage
