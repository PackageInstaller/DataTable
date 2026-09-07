local IslandShipOrderDelegatePage = class("IslandShipOrderDelegatePage", import("...base.IslandBasePage"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 1
local var_0_4 = 2

function IslandShipOrderDelegatePage:getUIName()
	return "IslandShipOrderDelegateUI"
end

function IslandShipOrderDelegatePage:OnLoaded()
	self.toggles = {
		[var_0_3] = self._tf:Find("frame/tags/request"),
		[var_0_4] = self._tf:Find("frame/tags/award")
	}
	self.toggleLabels = {
		[var_0_3] = i18n("island_ship_order_toggle_label_request"),
		[var_0_4] = i18n("island_ship_order_toggle_label_award")
	}
	self.confirmBtn = self._tf:Find("frame/confirm")
	self.cancelBtn = self._tf:Find("frame/cancel")
	self.refreshBtn = self._tf:Find("frame/refresh")
	self.speedUpBtn = self._tf:Find("frame/refresh/time")
	self.refreshTimeTxt = self._tf:Find("frame/refresh/time/Text"):GetComponent(typeof(Text))
	self.autoRefreshTimeTr = self._tf:Find("frame/list/label")
	self.autoRefreshTimeTxt = self._tf:Find("frame/list/label/Text/time"):GetComponent(typeof(Text))
	self.uiItemList = UIItemList.New(self._tf:Find("frame/list/content"), self._tf:Find("frame/list/content/tpl"))

	setText(self._tf:Find("frame/confirm/Text"), i18n("word_ok"))
	setText(self._tf:Find("frame/cancel/Text"), i18n("word_cancel"))
	setText(self._tf:Find("frame/list/label"), i18n("island_ship_order_delegate_auto_refresh_label"))
	setText(self._tf:Find("frame/list/label/Text"), i18n("island_ship_order_delegate_auto_refresh_time"))

	return
end

function IslandShipOrderDelegatePage:IsEmptySlot()
	local var_3_0 = self:GetIsland():GetOrderAgency():GetShipOrderSlot(self.slotId)

	return var_3_0 and var_3_0:IsEmpty()
end

function IslandShipOrderDelegatePage:IsAnyLoadUp()
	local var_4_0 = self:GetIsland():GetOrderAgency():GetShipOrderSlot(self.slotId)

	return var_4_0 and var_4_0:GetOrder():IsAnyLoadUp()
end

function IslandShipOrderDelegatePage:CanExchange()
	local var_5_0 = self:GetIsland():GetOrderAgency():GetShipOrderSlot(self.slotId)

	return var_5_0 and var_5_0:CanTransport()
end

function IslandShipOrderDelegatePage:OnInit()
	onButton(self, self.confirmBtn, function()
		if self:IsSelectMode() and self.selectedId then
			local var_7_0 = self.selectedId

			if self:IsEmptySlot() then
				self:emit(IslandMediator.EXCHANGE_SHIP_ORDER, self.slotId, self.selectedId)
			elseif self:IsAnyLoadUp() and not self:CanExchange() then
				pg.TipsMgr.GetInstance():ShowTip(i18n("island_order_ship_exchange_tip_2"))
			else
				local var_7_1 = self:IsAnyLoadUp() and i18n("island_order_ship_exchange_tip_1") or i18n("island_order_ship_exchange_tip")

				self:ShowMsgBox({
					content = var_7_1,
					onYes = function()
						self:emit(IslandMediator.EXCHANGE_SHIP_ORDER, self.slotId, var_7_0)

						return
					end
				})
			end
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.refreshBtn, function()
		self:ShowMsgBox({
			content = i18n("island_order_ship_reset_all"),
			onYes = function()
				self:emit(IslandMediator.RESET_SHIP_ORDER)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.speedUpBtn, function()
		self:OpenPage(IslandTicketUsePage, IslandUseTicketCommand.TYPES.SHIP_ORDER_RELOAD, 0)

		return
	end, SFX_PANEL)
	self:InitToggles()

	return
end

function IslandShipOrderDelegatePage:AddListeners()
	self:AddListener(GAME.ISLAND_RESET_SHIP_ORDER_DONE, self.OnResetShipOrderList)
	self:AddListener(GAME.ISLAND_USE_TICKET_DONE, self.OnUseTicketDone)

	return
end

function IslandShipOrderDelegatePage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_RESET_SHIP_ORDER_DONE, self.OnResetShipOrderList)
	self:RemoveListener(GAME.ISLAND_USE_TICKET_DONE, self.OnUseTicketDone)

	return
end

function IslandShipOrderDelegatePage:OnUseTicketDone(arg_16_1)
	if arg_16_1.type == IslandUseTicketCommand.TYPES.SHIP_ORDER_RELOAD then
		self:FlushRefreshBtn()
	end

	return
end

function IslandShipOrderDelegatePage:OnResetShipOrderList()
	self:InitList()
	self:FlushRefreshBtn()

	return
end

function IslandShipOrderDelegatePage:OnShow(arg_18_1)
	self.slotId = arg_18_1

	self:UpdateMode(arg_18_1)
	self:FlushRefreshBtn()
	self:InitList()
	self:TriggerDefaultToggle()

	return
end

function IslandShipOrderDelegatePage:IsSelectMode()
	return self.mode == var_0_2 and self.slotId ~= nil
end

function IslandShipOrderDelegatePage:UpdateMode(arg_20_1)
	self.mode = var_0_1

	if arg_20_1 then
		self.mode = var_0_2
	end

	return
end

function IslandShipOrderDelegatePage:GetDisplays()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs((self:GetIsland():GetOrderAgency():GetDelegateList())) do
		if iter_21_1:CanShow() then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function IslandShipOrderDelegatePage:InitList()
	local var_22_0 = self:GetDisplays()

	self:RemoveNextAutoRefreshTimer()
	setActive(self.autoRefreshTimeTr, #var_22_0 <= 0)

	if #var_22_0 <= 0 then
		self.selectedId = nil

		self:AddNextAutoRefreshTimer()
		self.uiItemList:align(0)

		return
	end

	self.uiItemList:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_23_2, var_22_0[arg_23_1 + 1])
			onToggle(self, arg_23_2, function(arg_24_0)
				if arg_24_0 then
					self.selectedId = var_22_0[arg_23_1 + 1].id
				end

				return
			end, SFX_PANEL)

			if arg_23_1 == 0 then
				triggerToggle(arg_23_2, true)
			end
		end

		return
	end)
	self.uiItemList:align(#var_22_0)

	return
end

function IslandShipOrderDelegatePage:AddNextAutoRefreshTimer()
	local var_25_0 = self:GetIsland():GetOrderAgency():GetNextAutoReloadDelegateTime()

	self.autoTimer = Timer.New(function()
		local var_26_0 = var_25_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_26_0 < 0 then
			self:RemoveNextAutoRefreshTimer()

			self.autoRefreshTimeTxt.text = ""

			if #self:GetDisplays() > 0 then
				self:InitList()
			end
		else
			self.autoRefreshTimeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_26_0)
		end

		return
	end, 1, -1)

	self.autoTimer:Start()
	self.autoTimer.func()

	return
end

function IslandShipOrderDelegatePage:RemoveNextAutoRefreshTimer()
	if self.autoTimer then
		self.autoTimer:Stop()

		self.autoTimer = nil
	end

	return
end

function IslandShipOrderDelegatePage:UpdateItem(arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2:GetRequestList()

	setText(arg_28_1:Find("num"), "0" .. arg_28_2.id)

	local var_28_1 = UIItemList.New(arg_28_1:Find("request"), arg_28_1:Find("request/tpl"))

	var_28_1:make(function(arg_29_0, arg_29_1, arg_29_2)
		if arg_29_0 == UIItemList.EventUpdate then
			local var_29_0 = Drop.New(var_28_0[arg_29_1 + 1])

			GetImageSpriteFromAtlasAsync("island/" .. (var_29_0.icon or var_29_0:getConfig("icon")), "", arg_29_2:Find("icon"))

			local var_29_1 = var_29_0:getOwnedCount()

			setText(arg_29_2:Find("cnt"), setColorStr(var_29_1 .. "/" .. var_29_0.count, var_29_1 >= var_29_0.count and "#39beff" or "#f36c6e"))
			setActive(arg_29_2:Find("mark"), var_29_1 >= var_29_0.count)
		end

		return
	end)
	var_28_1:align(#var_28_0)

	local var_28_2 = arg_28_2:GetAwardList()
	local var_28_3 = UIItemList.New(arg_28_1:Find("award"), arg_28_1:Find("award/tpl"))

	var_28_3:make(function(arg_30_0, arg_30_1, arg_30_2)
		if arg_30_0 == UIItemList.EventUpdate then
			local var_30_0 = Drop.New(var_28_2[arg_30_1 + 1])

			updateCustomDrop(arg_30_2, Drop.New(var_28_2[arg_30_1 + 1]))
		end

		return
	end)
	var_28_3:align(#var_28_2)

	return
end

function IslandShipOrderDelegatePage:FlushRefreshBtn()
	local var_31_0, var_31_1 = self:GetIsland():GetOrderAgency():CanRefreshShipOrderDelegate()

	setGray(self.refreshBtn, not var_31_0, true)
	setButtonEnabled(self.refreshBtn, var_31_0)
	setActive(self.refreshTimeTxt.gameObject.transform.parent, not var_31_0)
	self:RemoveRefreshTimer()

	if not var_31_0 then
		self:AddRefreshTimer(var_31_1)
	end

	return
end

function IslandShipOrderDelegatePage:AddRefreshTimer(arg_32_1)
	self.timer = Timer.New(function()
		local var_33_0 = arg_32_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_33_0 < 0 then
			self:RemoveRefreshTimer()

			self.refreshTimeTxt.text = ""

			self:FlushRefreshBtn()
		else
			self.refreshTimeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_33_0)
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function IslandShipOrderDelegatePage:RemoveRefreshTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandShipOrderDelegatePage:InitToggles()
	for iter_35_0, iter_35_1 in pairs(self.toggles) do
		onToggle(self, iter_35_1, function(arg_36_0)
			self:SwitchPage(iter_35_0)

			return
		end, SFX_PANEL)
	end

	return
end

function IslandShipOrderDelegatePage:SwitchPage(arg_37_1)
	self.pageIndex = arg_37_1

	for iter_37_0, iter_37_1 in pairs(self.toggles) do
		setText(iter_37_1:Find("Text"), (setColorStr(self.toggleLabels[iter_37_0], iter_37_0 == arg_37_1 and "#F9B64B" or "#707172")))
	end

	self.uiItemList:each(function(arg_38_0, arg_38_1)
		setActive(arg_38_1:Find("request"), arg_37_1 == var_0_3)
		setActive(arg_38_1:Find("award"), arg_37_1 == var_0_4)

		return
	end)

	return
end

function IslandShipOrderDelegatePage:TriggerDefaultToggle()
	triggerToggle(self.toggles[var_0_3], true)

	return
end

function IslandShipOrderDelegatePage:RemoveTimers()
	self:RemoveRefreshTimer()
	self:RemoveNextAutoRefreshTimer()

	return
end

function IslandShipOrderDelegatePage:OnHide()
	self:RemoveTimers()

	self.selectedId = nil

	return
end

function IslandShipOrderDelegatePage:OnExit()
	self:RemoveTimers()

	self.selectedId = nil

	return
end

return IslandShipOrderDelegatePage
