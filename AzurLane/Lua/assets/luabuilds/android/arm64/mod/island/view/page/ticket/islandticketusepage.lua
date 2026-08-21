local var_0_0 = class("IslandTicketUsePage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandTicketUseUI"
end

function var_0_0.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("window/time_panel")

	setText(var_2_0:Find("left/Text"), i18n("island_ticket_remain_time"))

	arg_2_0.remainTimeTF = var_2_0:Find("left/time")
	arg_2_0.progressSliderTF = var_2_0:Find("right/progress")
	arg_2_0.progressUpSliderTF = var_2_0:Find("right/progress_up")
	arg_2_0.reduceTimeTF = var_2_0:Find("right/Text")
	arg_2_0.formulaNumTF = arg_2_0._tf:Find("window/Text")
	arg_2_0.viewBtn = arg_2_0._tf:Find("window/view")

	setText(arg_2_0.viewBtn:Find("Text"), i18n("island_ticket_view"))

	arg_2_0.autoBtn = arg_2_0._tf:Find("window/auto")

	setText(arg_2_0.autoBtn:Find("Text"), i18n("island_ticket_auto_select"))

	arg_2_0.useBtn = arg_2_0._tf:Find("window/use")

	setText(arg_2_0.useBtn:Find("Text"), i18n("island_ticket_use"))

	arg_2_0.scrollRect = arg_2_0._tf:Find("window/scrollrect"):GetComponent("LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		arg_2_0:OnInitItem(arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_0.OnInit(arg_5_0)
	onButton(arg_5_0, arg_5_0._tf:Find("window/help"), function()
		arg_5_0:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_helpbtn_speedup")
		})

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("window/close"), function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("mask"), function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.viewBtn, function()
		arg_5_0:OpenPage(IslandTicketStoragePage)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.viewBtn, function()
		arg_5_0:OpenPage(IslandTicketStoragePage)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.autoBtn, function()
		arg_5_0:AutoSelect()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.useBtn, function()
		arg_5_0:UseTickets()

		return
	end, SFX_PANEL)

	arg_5_0.cards = {}
	arg_5_0.displayGroups = underscore.keys(pg.island_speedup_ticket.get_id_list_by_speedup_time)

	table.sort(arg_5_0.displayGroups)

	return
end

function var_0_0.OnInitItem(arg_13_0, arg_13_1)
	local var_13_0 = IslandTicketGroupCard.New(arg_13_1)

	arg_13_0.cards[arg_13_1] = var_13_0

	onButton(arg_13_0, var_13_0.shopBtn, function()
		if not IslandMainBtnTipHelper.IsUnlock("shop") then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_shop_lock_tip"))

			return
		end

		arg_13_0:OpenPage(IslandShopPage, unpack(pg.island_set.island_ticket_shopid.key_value_varchar))

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.cards[arg_15_2]

	if not arg_15_0.cards[arg_15_2] then
		arg_15_0:OnInitItem(arg_15_2)

		var_15_0 = arg_15_0.cards[arg_15_2]
	end

	local function var_15_1(arg_16_0, arg_16_1)
		arg_15_0.selCounts[arg_16_0] = arg_16_1

		var_15_0:UpdateSelCnt(arg_15_0.selCounts[arg_16_0])
		arg_15_0:UpdataSelected()
		arg_15_0:SetOverflowFlag()

		return
	end

	local var_15_2 = arg_15_1 + 1

	onButton(arg_15_0, var_15_0._go, function()
		if arg_15_0.overflowFlag then
			return
		end

		local var_17_0 = arg_15_0.selCounts[var_15_2] + 1

		if arg_15_0.selCounts[var_15_2] + 1 > arg_15_0.allCounts[var_15_2] then
			return
		end

		var_15_1(var_15_2, var_17_0)

		return
	end, SFX_PANEL)
	onButton(arg_15_0, var_15_0.reduceBtn, function()
		if arg_15_0.selCounts[var_15_2] - 1 < 0 then
			return
		end

		var_15_1(var_15_2, arg_15_0.selCounts[var_15_2] - 1)

		return
	end, SFX_PANEL)
	onInputEndEdit(arg_15_0, var_15_0.countInput, function(arg_19_0)
		if not arg_19_0 or arg_19_0 == "" or not tonumber(arg_19_0) then
			-- block empty
		end

		local var_19_2 = math.min(math.max(0, (tonumber(arg_19_0))), arg_15_0.allCounts[var_15_2])

		if var_19_2 > arg_15_0.selCounts[var_15_2] and arg_15_0.overflowFlag then
			return
		end

		var_15_1(var_15_2, var_19_2)

		return
	end)

	if arg_15_0.displayDic[arg_15_0.displayGroups[arg_15_1 + 1]] then
		var_15_0:Update(arg_15_0.displayGroups[arg_15_1 + 1], arg_15_0.displayDic[arg_15_0.displayGroups[arg_15_1 + 1]], arg_15_0.allCounts[arg_15_1 + 1], arg_15_0.selCounts[arg_15_1 + 1])
	end

	return
end

function var_0_0.SetOverflowFlag(arg_20_0)
	arg_20_0.overflowFlag = arg_20_0.endTime - arg_20_0.timeMgr:GetServerTime() - arg_20_0.reduceTime <= 0

	return
end

function var_0_0.AddListeners(arg_21_0)
	arg_21_0:AddListener(GAME.ISLAND_REMOVE_EXPIRED_TICKET_DONE, arg_21_0.Flush)
	arg_21_0:AddListener(GAME.ISLAND_USE_TICKET_DONE, arg_21_0.Flush)
	arg_21_0:AddListener(GAME.ISLAND_SHOP_OP_DONE, arg_21_0.Flush)

	return
end

function var_0_0.RemoveListeners(arg_22_0)
	arg_22_0:RemoveListener(GAME.ISLAND_REMOVE_EXPIRED_TICKET_DONE, arg_22_0.Flush)
	arg_22_0:RemoveListener(GAME.ISLAND_USE_TICKET_DONE, arg_22_0.Flush)
	arg_22_0:RemoveListener(GAME.ISLAND_SHOP_OP_DONE, arg_22_0.Flush)

	return
end

function var_0_0.OnShow(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:BlurPanel()

	arg_23_0.type = arg_23_1
	arg_23_0.id = arg_23_2
	arg_23_0.timeMgr = pg.TimeMgr.GetInstance()

	arg_23_0:Flush()

	return
end

function var_0_0.Flush(arg_24_0)
	arg_24_0:SetSystemData()
	arg_24_0:SetTicketsData()
	arg_24_0.scrollRect:SetTotalCount(#arg_24_0.displayGroups, -1)
	arg_24_0:UpdataSelected()
	arg_24_0:StopTimer()
	arg_24_0:StartTimer()

	arg_24_0.overflowFlag = false

	return
end

function var_0_0.SetSystemData(arg_25_0)
	arg_25_0.allTime = 0
	arg_25_0.endTime = 0

	switch(arg_25_0.type, {
		[IslandUseTicketCommand.TYPES.ORDER_CD] = function()
			local var_26_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetSlot(arg_25_0.id)

			if not var_26_0 then
				return
			end

			arg_25_0.endTime = var_26_0:GetCanSubmitTime()
			arg_25_0.allTime = var_26_0:GetTotalTime()

			return
		end,
		[IslandUseTicketCommand.TYPES.SHIP_ORDER] = function()
			local var_27_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetShipOrderSlot(arg_25_0.id)

			if not var_27_0 then
				return
			end

			arg_25_0.endTime = var_27_0:GetEndTime()
			arg_25_0.allTime = var_27_0:GetNeedTime()

			return
		end,
		[IslandUseTicketCommand.TYPES.MANAGE] = function()
			local var_28_0 = getProxy(IslandProxy):GetIsland():GetManageAgency():GetRestaurant(arg_25_0.id)

			if not var_28_0 then
				return
			end

			arg_25_0.endTime = var_28_0:GetEndTime()
			arg_25_0.allTime = var_28_0:getConfig("opening_time")

			return
		end,
		[IslandUseTicketCommand.TYPES.APPOINT] = function()
			arg_25_0.appointRoleData = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(pg.island_production_slot[arg_25_0.id].place):GetDelegationSlotData(arg_25_0.id):GetSlotRoleData()

			if not arg_25_0.appointRoleData then
				return
			end

			arg_25_0.endTime = arg_25_0.appointRoleData:GetFinishTime()
			arg_25_0.allTime = arg_25_0.appointRoleData:GetAllTime()

			return
		end,
		[IslandUseTicketCommand.TYPES.SHIP_ORDER_RELOAD] = function()
			arg_25_0.endTime = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetNextManualReloadDelegateTime()
			arg_25_0.allTime = pg.island_set.island_shiporder_refresh_cd.key_value_int

			return
		end
	}, function()
		assert(false, "no ticket use type: " .. arg_25_0.type)

		return
	end)

	return
end

function var_0_0.SetTicketsData(arg_32_0)
	arg_32_0.ticketAgency = getProxy(IslandProxy):GetIsland():GetTicketAgency()
	arg_32_0.displayDic = {}

	for iter_32_0, iter_32_1 in pairs((arg_32_0.ticketAgency:GetTicketData())) do
		local var_32_0 = underscore.values(iter_32_1)

		if #var_32_0 > 0 then
			local var_32_1 = var_32_0[1]:GetTime()

			arg_32_0.displayDic[var_32_1] = arg_32_0.displayDic[var_32_1] or {}
			arg_32_0.displayDic[var_32_1] = table.mergeArray(arg_32_0.displayDic[var_32_1], var_32_0)
		end
	end

	for iter_32_2, iter_32_3 in pairs(arg_32_0.displayDic) do
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

	arg_32_0.allCounts = {}
	arg_32_0.selCounts = {}

	for iter_32_4, iter_32_5 in ipairs(arg_32_0.displayGroups) do
		arg_32_0.displayDic[iter_32_5] = arg_32_0.displayDic[iter_32_5] or {}

		table.insert(arg_32_0.allCounts, (underscore.reduce(arg_32_0.displayDic[iter_32_5], 0, function(arg_36_0, arg_36_1)
			return arg_36_0 + arg_36_1:GetCount()
		end)))
		table.insert(arg_32_0.selCounts, 0)
	end

	arg_32_0.reduceTime = 0

	return
end

function var_0_0.UpdateSliderUI(arg_37_0)
	local var_37_0 = arg_37_0.timeMgr:GetServerTime()
	local var_37_1 = arg_37_0.endTime - var_37_0

	if arg_37_0.endTime - var_37_0 - arg_37_0.reduceTime > 0 then
		setText(arg_37_0.remainTimeTF, arg_37_0.timeMgr:DescCDTime(arg_37_0.endTime - var_37_0 - arg_37_0.reduceTime))
	else
		setText(arg_37_0.remainTimeTF, i18n("island_ticket_finished"))
	end

	setText(arg_37_0.reduceTimeTF, "-" .. arg_37_0.timeMgr:DescCDTime(arg_37_0.reduceTime))
	setSlider(arg_37_0.progressSliderTF, 0, 1, 1 - var_37_1 / arg_37_0.allTime)
	setSlider(arg_37_0.progressUpSliderTF, 0, 1, 1 - (var_37_1 - arg_37_0.reduceTime) / arg_37_0.allTime)

	local var_37_2 = arg_37_0.type == IslandUseTicketCommand.TYPES.APPOINT

	setActive(arg_37_0.formulaNumTF, arg_37_0.type == IslandUseTicketCommand.TYPES.APPOINT)

	if var_37_2 and arg_37_0.appointRoleData then
		setText(arg_37_0.formulaNumTF, i18n("island_ticket_completed_quantity", (arg_37_0.appointRoleData:GetCountByTimestamp(var_37_0 + arg_37_0.reduceTime))))
	end

	return
end

function var_0_0.UpdateReduceTime(arg_38_0)
	arg_38_0.reduceTime = 0

	for iter_38_0, iter_38_1 in ipairs(arg_38_0.selCounts) do
		arg_38_0.reduceTime = arg_38_0.reduceTime + arg_38_0.displayGroups[iter_38_0] * iter_38_1
	end

	return
end

function var_0_0.UpdataSelected(arg_39_0)
	arg_39_0:UpdateReduceTime()
	arg_39_0:UpdateSliderUI()

	local var_39_0 = underscore.any(arg_39_0.selCounts, function(arg_40_0)
		return arg_40_0 > 0
	end)

	setGray(arg_39_0.useBtn, not var_39_0, true)
	setButtonEnabled(arg_39_0.useBtn, var_39_0)

	return
end

function var_0_0._SelectTickets(arg_41_0)
	local var_41_0 = arg_41_0.endTime - arg_41_0.timeMgr:GetServerTime()
	local var_41_1 = 0

	arg_41_0.selCounts = {}

	for iter_41_0, iter_41_1 in ipairs(arg_41_0.displayGroups) do
		table.insert(arg_41_0.selCounts, 0)
	end

	for iter_41_2, iter_41_3 in ipairs(arg_41_0.displayGroups) do
		for iter_41_4, iter_41_5 in ipairs(arg_41_0.displayDic[iter_41_3]) do
			for iter_41_6 = 1, iter_41_5:GetCount() do
				var_41_1 = var_41_1 + iter_41_5:GetTime()

				if var_41_0 <= var_41_1 then
					return
				end

				arg_41_0.selCounts[iter_41_2] = arg_41_0.selCounts[iter_41_2] + 1
			end
		end
	end

	return
end

function var_0_0.AutoSelect(arg_42_0)
	arg_42_0:_SelectTickets()
	arg_42_0:UpdataSelected()
	arg_42_0.scrollRect:SetTotalCount(#arg_42_0.displayGroups, -1)

	return
end

function var_0_0.GetSelectedTickets(arg_43_0)
	for iter_43_0, iter_43_1 in ipairs(arg_43_0.selCounts) do
		for iter_43_2, iter_43_3 in ipairs(arg_43_0.displayDic[arg_43_0.displayGroups[iter_43_0]]) do
			local var_43_0

			if iter_43_1 - 0 <= iter_43_3:GetCount() then
				table.insert({}, IslandTicket.New(iter_43_3.id, iter_43_3.endTime, iter_43_1 - 0))

				break
			else
				table.insert({}, IslandTicket.New(iter_43_3.id, iter_43_3.endTime, iter_43_3:GetCount()))

				var_43_0 = 0 + iter_43_3:GetCount()
			end
		end
	end

	return (underscore.select({}, function(arg_44_0)
		return arg_44_0:GetCount() > 0
	end))
end

function var_0_0.UseTickets(arg_45_0)
	seriesAsync({
		function(arg_46_0)
			if arg_45_0.endTime - arg_45_0.timeMgr:GetServerTime() <= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_ticket_finished"))
			else
				arg_46_0()
			end

			return
		end,
		function(arg_47_0)
			if arg_45_0.endTime - arg_45_0.timeMgr:GetServerTime() < arg_45_0.reduceTime then
				arg_45_0:ShowMsgBox({
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
		arg_45_0:emit(IslandMediator.USE_TICKETS, arg_45_0.type, arg_45_0.id, (arg_45_0:GetSelectedTickets()))

		return
	end)

	return
end

function var_0_0.StartTimer(arg_49_0)
	arg_49_0.timer = Timer.New(function()
		arg_49_0:UpdateTimer()

		return
	end, 1, -1)

	arg_49_0.timer:Start()
	arg_49_0:UpdateTimer()

	return
end

function var_0_0.UpdateTimer(arg_51_0)
	arg_51_0:UpdateSliderUI()

	return
end

function var_0_0.StopTimer(arg_52_0)
	if arg_52_0.timer then
		arg_52_0.timer:Stop()

		arg_52_0.timer = nil
	end

	return
end

function var_0_0.OnHide(arg_53_0)
	arg_53_0:UnBlurPanel()
	arg_53_0:StopTimer()

	return
end

function var_0_0.OnDisable(arg_54_0)
	arg_54_0:OnHide()

	return
end

function var_0_0.OnDestroy(arg_55_0)
	arg_55_0:OnHide()
	ClearLScrollrect(arg_55_0.scrollRect)

	for iter_55_0, iter_55_1 in pairs(arg_55_0.cards) do
		iter_55_1:Dispose()
	end

	arg_55_0.cards = {}

	return
end

return var_0_0
