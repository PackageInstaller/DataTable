local IslandShipOrderPage = class("IslandShipOrderPage", import("...base.IslandBasePage"))

IslandShipOrderPage.MODE_REQUEST_VIEW = 0
IslandShipOrderPage.MODE_AWARD_VIEW = 1
IslandShipOrderPage.EVENT_CLOSE_LOAD_UP = "IslandShipOrderPage:EVENT_CLOSE_LOAD_UP"

function IslandShipOrderPage:getUIName()
	return "IslandShipOrderUI"
end

function IslandShipOrderPage:OnLoaded()
	self.backBtn = self._tf:Find("back")
	self.uiSlots = UIItemList.New(self._tf:Find("frame/list"), self._tf:Find("frame/list/tpl"))
	self.onekeySlots = UIItemList.New(self._tf:Find("list_1"), self._tf:Find("list_1/onekey"))
	self.switchBtn = self._tf:Find("frame/switch")
	self.cards = {}
	self.loadUpPage = IslandShipOrderLoadUpPage.New(self._tf, self.event)
	self.canvasGroup = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self.delegateBtn = self._tf:Find("frame/event_btn")
	self.uilistAniamtion = self._tf:Find("frame/list"):GetComponent(typeof(Animation))

	setText(self._tf:Find("frame/switch/on/Text"), i18n("island_order_ship_page_req"))
	setText(self._tf:Find("frame/switch/off/Text"), i18n("island_order_ship_page_award"))
	setText(self._tf:Find("list_1/onekey/btn/Text"), i18n("island_order_ship_page_onekey_loadup"))

	return
end

function IslandShipOrderPage:OnInit()
	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("frame/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_ship_order.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.delegateBtn, function()
		self:OpenPage(IslandShipOrderDelegatePage)

		return
	end, SFX_PANEL)
	self:bind(IslandShipOrderPage.EVENT_CLOSE_LOAD_UP, function()
		self:ClearSelected()

		return
	end)
	triggerToggle(self.switchBtn, false)
	onToggle(self, self.switchBtn, function(arg_8_0)
		self:SwitchMode(arg_8_0)

		return
	end, SFX_PANEL)

	return
end

function IslandShipOrderPage:AddListeners()
	self:AddListener(GAME.ISLAND_SHIP_ORDER_OP_DONE, self.OnOrderUpdate)
	self:AddListener(GAME.ISLAND_USE_TICKET_DONE, self.OnUseTicketDone)
	self:AddListener(GAME.ISLAND_REFRESH_SHIP_ORDER_DONE, self.OnRefreshOrder)
	self:AddListener(IslandShipOrderCard.EVENT_CD_END, self.OnOrderReloadingEnd)
	self:AddListener(GAME.ISLAND_EXCHANGE_SHIP_ORDER_DONE, self.OnExchangeShipOrderDone)
	self:AddListener(GAME.ISLAND_RESET_SHIP_ORDER_DONE, self.OnResetShipOrderList)

	return
end

function IslandShipOrderPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_SHIP_ORDER_OP_DONE, self.OnOrderUpdate)
	self:RemoveListener(GAME.ISLAND_USE_TICKET_DONE, self.OnUseTicketDone)
	self:RemoveListener(GAME.ISLAND_REFRESH_SHIP_ORDER_DONE, self.OnRefreshOrder)
	self:RemoveListener(IslandShipOrderCard.EVENT_CD_END, self.OnOrderReloadingEnd)
	self:RemoveListener(GAME.ISLAND_EXCHANGE_SHIP_ORDER_DONE, self.OnExchangeShipOrderDone)
	self:RemoveListener(GAME.ISLAND_RESET_SHIP_ORDER_DONE, self.OnResetShipOrderList)

	return
end

function IslandShipOrderPage:OnResetShipOrderList()
	self:FlushSlots()

	return
end

function IslandShipOrderPage:OnExchangeShipOrderDone(arg_12_1)
	self:OnRefreshOrder({
		id = arg_12_1.id
	})
	self:UpdateOnekeyBtns()

	return
end

function IslandShipOrderPage:OnOrderReloadingEnd()
	self:UpdateOnekeyBtns()

	return
end

function IslandShipOrderPage:OnRefreshOrder(arg_14_1)
	local var_14_0

	for iter_14_0, iter_14_1 in pairs(self.cards) do
		if iter_14_1.slot.id == arg_14_1.id then
			var_14_0 = iter_14_1

			break
		end
	end

	if not var_14_0 then
		return
	end

	var_14_0:Flush(var_14_0.slot, self.mode)
	self:UpdateOnekeyBtns()

	return
end

function IslandShipOrderPage:OnOrderUpdate(arg_15_1)
	local var_15_0

	for iter_15_0, iter_15_1 in pairs(self.cards) do
		if iter_15_1.slot.id == arg_15_1.id then
			var_15_0 = iter_15_1

			break
		end
	end

	if not var_15_0 then
		return
	end

	self:ClearSelected()

	self.canvasGroup.blocksRaycasts = false

	seriesAsync({
		function(arg_16_0)
			var_15_0:PlayAniamtion(arg_15_1.op, arg_15_1.isLoadUpAll, arg_16_0)

			return
		end
	}, function()
		self.canvasGroup.blocksRaycasts = true

		var_15_0:Flush(var_15_0.slot, self.mode)
		self:RegisterCardEvent(var_15_0)

		for iter_17_0, iter_17_1 in pairs(self.cards) do
			iter_17_1:UpdateRequest(iter_17_1.slot)
		end

		self:UpdateOnekeyBtns()

		return
	end)

	return
end

function IslandShipOrderPage:OnUseTicketDone(arg_18_1)
	if arg_18_1.type == IslandUseTicketCommand.TYPES.SHIP_ORDER then
		local var_18_0

		for iter_18_0, iter_18_1 in pairs(self.cards) do
			if iter_18_1.slot.id == arg_18_1.id then
				var_18_0 = iter_18_1

				break
			end
		end

		if not var_18_0 then
			return
		end

		var_18_0:Flush(var_18_0.slot, self.mode)
	end

	self:UpdateOnekeyBtns()

	return
end

function IslandShipOrderPage:OnShow()
	self.mode = IslandShipOrderPage.MODE_REQUEST_VIEW
	self.canvasGroup.blocksRaycasts = true

	self:FlushSlots()
	self:UnlockFirstSlot()

	return
end

function IslandShipOrderPage:UnlockFirstSlot()
	if self.displays[1] and self.displays[1]:IsLock() and self.displays[1]:GetUnlockGold().count <= 0 then
		for iter_20_0, iter_20_1 in pairs(self.cards) do
			if iter_20_1.slot.id == self.displays[1].id then
				target = iter_20_1

				break
			end
		end

		if target then
			triggerButton(target.lockTr)
		end
	end

	return
end

function IslandShipOrderPage:SwitchMode(arg_21_1)
	if arg_21_1 then
		self.mode = IslandShipOrderPage.MODE_AWARD_VIEW or IslandShipOrderPage.MODE_REQUEST_VIEW
	end

	for iter_21_0, iter_21_1 in pairs(self.cards) do
		iter_21_1:SwitchMode(iter_21_1.slot, self.mode)
	end

	self:ClearSelected()
	self.uilistAniamtion:Stop()
	self.uilistAniamtion:Play("anim_island_shiporder_list")

	return
end

function IslandShipOrderPage:GetDisplays(...)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in pairs((getProxy(IslandProxy):GetIsland():GetOrderAgency():GetShipSlotList())) do
		table.insert(var_22_0, iter_22_1)
	end

	return var_22_0
end

function IslandShipOrderPage:FlushSlots()
	self.displays = self:GetDisplays()

	table.sort(self.displays, function(arg_24_0, arg_24_1)
		return arg_24_0:GetUnlockLevel() < arg_24_1:GetUnlockLevel()
	end)
	self.uiSlots:make(function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			print(self.displays[arg_25_1 + 1].finishCnt, self.displays[arg_25_1 + 1].nextRefreshFinishCntTime <= pg.TimeMgr.GetInstance():GetServerTime())
			self:UpdateSlot(self.displays[arg_25_1 + 1], arg_25_2)
		end

		return
	end)
	self.uiSlots:align(#self.displays)
	self:UpdateOnekeyBtns()

	return
end

function IslandShipOrderPage:UpdateOnekeyBtns()
	self.onekeySlots:make(function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == UIItemList.EventUpdate then
			local var_27_0 = arg_27_2:Find("btn")
			local var_27_1 = self.displays[arg_27_1 + 1]

			setActive(var_27_0, self.displays[arg_27_1 + 1]:IsWaiting() and not self.displays[arg_27_1 + 1]:IsEmpty())

			if self.displays[arg_27_1 + 1]:IsWaiting() then
				local var_27_2

				if self.displays[arg_27_1 + 1]:GetOrder():AnyCanLoadUp() then
					var_27_2 = not self.displays[arg_27_1 + 1]:CanTransport()

					goto label_27_0
				end
			end

			var_27_2 = true

			::label_27_0::

			setGray(var_27_0, var_27_2, true)

			if not var_27_2 then
				onButton(self, var_27_0, function()
					if var_27_1:IsEmpty() then
						return
					end

					self:emit(IslandMediator.SUBMIT_SHIP_ORDER_ITME_ONEKEY, var_27_1.id)

					return
				end, SFX_PANEL)
			else
				removeOnButton(var_27_0)
			end
		end

		return
	end)
	self.onekeySlots:align(#self.displays)

	return
end

function IslandShipOrderPage:UpdateSlot(arg_29_1, arg_29_2)
	local var_29_0 = self.cards[arg_29_2] or IslandShipOrderCard.New(arg_29_2, self)

	var_29_0:Flush(arg_29_1, self.mode)
	onButton(self, var_29_0.getBtn, function()
		self:emit(IslandMediator.GET_SHIP_ORDER_AWARD, var_29_0.slot.id)

		return
	end, SFX_PANEL)
	onButton(self, var_29_0.lockTr, function()
		self:emit(IslandMediator.UNLOKC_SHIP_ORDER, var_29_0.slot.id)

		return
	end, SFX_PANEL)
	onButton(self, var_29_0.loadingRequest, function()
		self:OpenPage(IslandTicketUsePage, IslandUseTicketCommand.TYPES.SHIP_ORDER, var_29_0.slot.id)

		return
	end, SFX_PANEL)
	onButton(self, var_29_0.exchangeBtn, function()
		self:OpenPage(IslandShipOrderDelegatePage, var_29_0.slot.id)

		return
	end, SFX_PANEL)
	onButton(self, var_29_0.emptyTr, function()
		self:OpenPage(IslandShipOrderDelegatePage, var_29_0.slot.id)

		return
	end, SFX_PANEL)
	onNextTick(function()
		self:RegisterCardEvent(var_29_0)

		return
	end)

	self.cards[arg_29_2] = var_29_0

	return
end

function IslandShipOrderPage:CheckSelected(arg_36_1)
	if self.loadUpItem == arg_36_1 then
		self:ClearSelected()

		return false
	end

	return true
end

function IslandShipOrderPage:RegisterCardEvent(arg_37_1)
	arg_37_1.uiRequestList:each(function(arg_38_0, arg_38_1)
		onButton(self, arg_38_1, function()
			if not arg_37_1.slot:IsWaiting() then
				return
			end

			if arg_37_1.slot:GetOrder():ItemIsSubmited(arg_38_0 + 1) then
				return
			end

			if not self:CheckSelected(arg_38_1) then
				return
			end

			self:ClearSelected()
			setActive(arg_38_1:Find("loaded_1"), true)
			self:LoadUpItem(arg_37_1, arg_38_0 + 1, arg_38_1)

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function IslandShipOrderPage:ClearSelected()
	if self.loadUpItem then
		setActive(self.loadUpItem:Find("loaded_1"), false)
	end

	self.loadUpItem = nil

	if self.loadUpPage and self.loadUpPage:GetLoaded() and self.loadUpPage:isShowing() then
		self.loadUpPage:Hide()
	end

	return
end

function IslandShipOrderPage:LoadUpItem(arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = self._tf:InverseTransformPoint(arg_41_3:Find("loaded_1").position)

	self.loadUpPage:ExecuteAction("Show", Vector3(var_41_0.x, var_41_0.y, 0), arg_41_1.slot, arg_41_2)

	self.loadUpItem = arg_41_3

	return
end

function IslandShipOrderPage:OnHide()
	self:ClearSelected()

	if self.loadUpPage then
		self.loadUpPage:Destroy()
		self.loadUpPage:Reset()
	end

	return
end

function IslandShipOrderPage:OnDestroy()
	for iter_43_0, iter_43_1 in pairs(self.cards) do
		iter_43_1:Dispose()
	end

	self.cards = {}

	if self.loadUpPage then
		self.loadUpPage:Destroy()

		self.loadUpPage = nil
	end

	return
end

return IslandShipOrderPage
