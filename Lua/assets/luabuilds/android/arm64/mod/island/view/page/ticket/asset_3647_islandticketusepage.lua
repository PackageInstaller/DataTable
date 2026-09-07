local IslandTicketUsePage = class("IslandTicketUsePage", import("...base.IslandBasePage"))

function IslandTicketUsePage:getUIName()
	return "IslandTicketUseUI"
end

function IslandTicketUsePage:OnLoaded()
	local var_2_0 = self._tf:Find("window/time_panel")

	setText(var_2_0:Find("left/Text"), i18n("island_ticket_remain_time"))

	self.remainTimeTF = var_2_0:Find("left/time")
	self.progressSliderTF = var_2_0:Find("right/progress")
	self.progressUpSliderTF = var_2_0:Find("right/progress_up")
	self.reduceTimeTF = var_2_0:Find("right/Text")
	self.formulaNumTF = self._tf:Find("window/Text")
	self.viewBtn = self._tf:Find("window/view")

	setText(self.viewBtn:Find("Text"), i18n("island_ticket_view"))

	self.autoBtn = self._tf:Find("window/auto")

	setText(self.autoBtn:Find("Text"), i18n("island_ticket_auto_select"))

	self.useBtn = self._tf:Find("window/use")

	setText(self.useBtn:Find("Text"), i18n("island_ticket_use"))

	self.scrollRect = self._tf:Find("window/scrollrect"):GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function IslandTicketUsePage:OnInit()
	onButton(self, self._tf:Find("window/help"), function()
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_helpbtn_speedup")
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("window/close"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("mask"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.viewBtn, function()
		self:OpenPage(IslandTicketStoragePage)

		return
	end, SFX_PANEL)
	onButton(self, self.viewBtn, function()
		self:OpenPage(IslandTicketStoragePage)

		return
	end, SFX_PANEL)
	onButton(self, self.autoBtn, function()
		self:AutoSelect()

		return
	end, SFX_PANEL)
	onButton(self, self.useBtn, function()
		self:UseTickets()

		return
	end, SFX_PANEL)

	self.cards = {}
	self.displayGroups = underscore.keys(pg.island_speedup_ticket.get_id_list_by_speedup_time)

	table.sort(self.displayGroups)

	return
end

function IslandTicketUsePage:OnInitItem(arg_13_1)
	local var_13_0 = IslandTicketGroupCard.New(arg_13_1)

	self.cards[arg_13_1] = var_13_0

	onButton(self, var_13_0.shopBtn, function()
		if not IslandMainBtnTipHelper.IsUnlock("shop") then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_shop_lock_tip"))

			return
		end

		self:OpenPage(IslandShopPage, unpack(pg.island_set.island_ticket_shopid.key_value_varchar))

		return
	end, SFX_PANEL)

	return
end

function IslandTicketUsePage:OnUpdateItem(arg_15_1, arg_15_2)
	local var_15_0 = self.cards[arg_15_2]

	if not self.cards[arg_15_2] then
		self:OnInitItem(arg_15_2)

		var_15_0 = self.cards[arg_15_2]
	end

	local function var_15_1(arg_16_0, arg_16_1)
		self.selCounts[arg_16_0] = arg_16_1

		var_15_0:UpdateSelCnt(self.selCounts[arg_16_0])
		self:UpdataSelected()
		self:SetOverflowFlag()

		return
	end

	local var_15_2 = arg_15_1 + 1

	onButton(self, var_15_0._go, function()
		if self.overflowFlag then
			return
		end

		local var_17_0 = self.selCounts[var_15_2] + 1

		if self.selCounts[var_15_2] + 1 > self.allCounts[var_15_2] then
			return
		end

		var_15_1(var_15_2, var_17_0)

		return
	end, SFX_PANEL)
	onButton(self, var_15_0.reduceBtn, function()
		if self.selCounts[var_15_2] - 1 < 0 then
			return
		end

		var_15_1(var_15_2, self.selCounts[var_15_2] - 1)

		return
	end, SFX_PANEL)
	onInputEndEdit(self, var_15_0.countInput, function(arg_19_0)
		if not arg_19_0 or arg_19_0 == "" or not tonumber(arg_19_0) then
			-- block empty
		end

		local var_19_2 = math.min(math.max(0, (tonumber(arg_19_0))), self.allCounts[var_15_2])

		if var_19_2 > self.selCounts[var_15_2] and self.overflowFlag then
			return
		end

		var_15_1(var_15_2, var_19_2)

		return
	end)

	if self.displayDic[self.displayGroups[arg_15_1 + 1]] then
		var_15_0:Update(self.displayGroups[arg_15_1 + 1], self.displayDic[self.displayGroups[arg_15_1 + 1]], self.allCounts[arg_15_1 + 1], self.selCounts[arg_15_1 + 1])
	end

	return
end

function IslandTicketUsePage:SetOverflowFlag()
	self.overflowFlag = self.endTime - self.timeMgr:GetServerTime() - self.reduceTime <= 0

	return
end

function IslandTicketUsePage:AddListeners()
	self:AddListener(GAME.ISLAND_REMOVE_EXPIRED_TICKET_DONE, self.Flush)
	self:AddListener(GAME.ISLAND_USE_TICKET_DONE, self.Flush)
	self:AddListener(GAME.ISLAND_SHOP_OP_DONE, self.Flush)

	return
end

function IslandTicketUsePage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_REMOVE_EXPIRED_TICKET_DONE, self.Flush)
	self:RemoveListener(GAME.ISLAND_USE_TICKET_DONE, self.Flush)
	self:RemoveListener(GAME.ISLAND_SHOP_OP_DONE, self.Flush)

	return
end

function IslandTicketUsePage:OnShow(arg_23_1, arg_23_2)
	self:BlurPanel()

	self.type = arg_23_1
	self.id = arg_23_2
	self.timeMgr = pg.TimeMgr.GetInstance()

	self:Flush()

	return
end

function IslandTicketUsePage:Flush()
	self:SetSystemData()
	self:SetTicketsData()
	self.scrollRect:SetTotalCount(#self.displayGroups, -1)
	self:UpdataSelected()
	self:StopTimer()
	self:StartTimer()

	self.overflowFlag = false

	return
end

function IslandTicketUsePage:SetSystemData()
	self.allTime = 0
	self.endTime = 0

	switch(self.type, {
		[IslandUseTicketCommand.TYPES.ORDER_CD] = function()
			local var_26_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetSlot(self.id)

			if not var_26_0 then
				return
			end

			self.endTime = var_26_0:GetCanSubmitTime()
			self.allTime = var_26_0:GetTotalTime()

			return
		end,
		[IslandUseTicketCommand.TYPES.SHIP_ORDER] = function()
			local var_27_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetShipOrderSlot(self.id)

			if not var_27_0 then
				return
			end

			self.endTime = var_27_0:GetEndTime()
			self.allTime = var_27_0:GetNeedTime()

			return
		end,
		[IslandUseTicketCommand.TYPES.MANAGE] = function()
			local var_28_0 = getProxy(IslandProxy):GetIsland():GetManageAgency():GetRestaurant(self.id)

			if not var_28_0 then
				return
			end

			self.endTime = var_28_0:GetEndTime()
			self.allTime = var_28_0:getConfig("opening_time")

			return
		end,
		[IslandUseTicketCommand.TYPES.APPOINT] = function()
			self.appointRoleData = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(pg.island_production_slot[self.id].place):GetDelegationSlotData(self.id):GetSlotRoleData()

			if not self.appointRoleData then
				return
			end

			self.endTime = self.appointRoleData:GetFinishTime()
			self.allTime = self.appointRoleData:GetAllTime()

			return
		end,
		[IslandUseTicketCommand.TYPES.SHIP_ORDER_RELOAD] = function()
			self.endTime = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetNextManualReloadDelegateTime()
			self.allTime = pg.island_set.island_shiporder_refresh_cd.key_value_int

			return
		end
	}, function()
		assert(false, "no ticket use type: " .. self.type)

		return
	end)

	return
end

function IslandTicketUsePage:SetTicketsData()
	self.ticketAgency = getProxy(IslandProxy):GetIsland():GetTicketAgency()
	self.displayDic = {}

	for iter_32_0, iter_32_1 in pairs((self.ticketAgency:GetTicketData())) do
		local var_32_0 = underscore.values(iter_32_1)

		if #var_32_0 > 0 then
			local var_32_1 = var_32_0[1]:GetTime()

			self.displayDic[var_32_1] = self.displayDic[var_32_1] or {}
			self.displayDic[var_32_1] = table.mergeArray(self.displayDic[var_32_1], var_32_0)
		end
	end

	for iter_32_2, iter_32_3 in pairs(self.displayDic) do
		table.sort(iter_32_3, CompareFuncs({
			function(arg_33_0)
				return arg_33_0:IsForever() and 1 or 0
			end,
			function(arg_34_0)
				return arg_34_0:GetEndTime()
			end,
			function(arg_35_0)
				return arg_35_0.id
			end
		}))
	end

	self.allCounts = {}
	self.selCounts = {}

	for iter_32_4, iter_32_5 in ipairs(self.displayGroups) do
		self.displayDic[iter_32_5] = self.displayDic[iter_32_5] or {}

		table.insert(self.allCounts, (underscore.reduce(self.displayDic[iter_32_5], 0, function(arg_36_0, arg_36_1)
			return arg_36_0 + arg_36_1:GetCount()
		end)))
		table.insert(self.selCounts, 0)
	end

	self.reduceTime = 0

	return
end

function IslandTicketUsePage:UpdateSliderUI()
	local var_37_0 = self.timeMgr:GetServerTime()
	local var_37_1 = self.endTime - var_37_0

	if self.endTime - var_37_0 - self.reduceTime > 0 then
		setText(self.remainTimeTF, self.timeMgr:DescCDTime(self.endTime - var_37_0 - self.reduceTime))
	else
		setText(self.remainTimeTF, i18n("island_ticket_finished"))
	end

	setText(self.reduceTimeTF, "-" .. self.timeMgr:DescCDTime(self.reduceTime))
	setSlider(self.progressSliderTF, 0, 1, 1 - var_37_1 / self.allTime)
	setSlider(self.progressUpSliderTF, 0, 1, 1 - (var_37_1 - self.reduceTime) / self.allTime)

	local var_37_2 = self.type == IslandUseTicketCommand.TYPES.APPOINT

	setActive(self.formulaNumTF, self.type == IslandUseTicketCommand.TYPES.APPOINT)

	if var_37_2 and self.appointRoleData then
		setText(self.formulaNumTF, i18n("island_ticket_completed_quantity", (self.appointRoleData:GetCountByTimestamp(var_37_0 + self.reduceTime))))
	end

	return
end

function IslandTicketUsePage:UpdateReduceTime()
	self.reduceTime = 0

	for iter_38_0, iter_38_1 in ipairs(self.selCounts) do
		self.reduceTime = self.reduceTime + self.displayGroups[iter_38_0] * iter_38_1
	end

	return
end

function IslandTicketUsePage:UpdataSelected()
	self:UpdateReduceTime()
	self:UpdateSliderUI()

	local var_39_0 = underscore.any(self.selCounts, function(arg_40_0)
		return arg_40_0 > 0
	end)

	setGray(self.useBtn, not var_39_0, true)
	setButtonEnabled(self.useBtn, var_39_0)

	return
end

function IslandTicketUsePage:_SelectTickets()
	local var_41_0 = self.endTime - self.timeMgr:GetServerTime()
	local var_41_1 = 0

	self.selCounts = {}

	for iter_41_0, iter_41_1 in ipairs(self.displayGroups) do
		table.insert(self.selCounts, 0)
	end

	for iter_41_2, iter_41_3 in ipairs(self.displayGroups) do
		for iter_41_4, iter_41_5 in ipairs(self.displayDic[iter_41_3]) do
			for iter_41_6 = 1, iter_41_5:GetCount() do
				var_41_1 = var_41_1 + iter_41_5:GetTime()

				if var_41_0 <= var_41_1 then
					return
				end

				self.selCounts[iter_41_2] = self.selCounts[iter_41_2] + 1
			end
		end
	end

	return
end

function IslandTicketUsePage:AutoSelect()
	self:_SelectTickets()
	self:UpdataSelected()
	self.scrollRect:SetTotalCount(#self.displayGroups, -1)

	return
end

function IslandTicketUsePage:GetSelectedTickets()
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in ipairs(self.selCounts) do
		for iter_43_2, iter_43_3 in ipairs(self.displayDic[self.displayGroups[iter_43_0]]) do
			if iter_43_1 - 0 <= iter_43_3:GetCount() then
				table.insert(var_43_0, IslandTicket.New(iter_43_3.id, iter_43_3.endTime, iter_43_1 - 0))

				break
			else
				table.insert(var_43_0, IslandTicket.New(iter_43_3.id, iter_43_3.endTime, iter_43_3:GetCount()))

				local var_43_1 = 0 + iter_43_3:GetCount()
			end
		end
	end

	return (underscore.select(var_43_0, function(arg_44_0)
		return arg_44_0:GetCount() > 0
	end))
end

function IslandTicketUsePage:UseTickets()
	seriesAsync({
		function(arg_46_0)
			if self.endTime - self.timeMgr:GetServerTime() <= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_ticket_finished"))
			else
				arg_46_0()
			end

			return
		end,
		function(arg_47_0)
			if self.endTime - self.timeMgr:GetServerTime() < self.reduceTime then
				self:ShowMsgBox({
					type = IslandMsgBox.TYPE_COMMON,
					content = i18n("island_sure_ticket_overflow"),
					onYes = arg_47_0
				})
			else
				arg_47_0()
			end

			return
		end
	}, function()
		self:emit(IslandMediator.USE_TICKETS, self.type, self.id, (self:GetSelectedTickets()))

		return
	end)

	return
end

function IslandTicketUsePage:StartTimer()
	self.timer = Timer.New(function()
		self:UpdateTimer()

		return
	end, 1, -1)

	self.timer:Start()
	self:UpdateTimer()

	return
end

function IslandTicketUsePage:UpdateTimer()
	self:UpdateSliderUI()

	return
end

function IslandTicketUsePage:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandTicketUsePage:OnHide()
	self:UnBlurPanel()
	self:StopTimer()

	return
end

function IslandTicketUsePage:OnDisable()
	self:OnHide()

	return
end

function IslandTicketUsePage:OnDestroy()
	self:OnHide()
	ClearLScrollrect(self.scrollRect)

	for iter_55_0, iter_55_1 in pairs(self.cards) do
		iter_55_1:Dispose()
	end

	self.cards = {}

	return
end

return IslandTicketUsePage
