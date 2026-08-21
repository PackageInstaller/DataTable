local var_0_0 = class("IslandShipOrderDelegatePage", import("...base.IslandBasePage"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 1
local var_0_4 = 2

function var_0_0.getUIName(arg_1_0)
	return "IslandShipOrderDelegateUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.toggles = {
		[var_0_3] = arg_2_0._tf:Find("frame/tags/request"),
		[var_0_4] = arg_2_0._tf:Find("frame/tags/award")
	}
	arg_2_0.toggleLabels = {
		[var_0_3] = i18n("island_ship_order_toggle_label_request"),
		[var_0_4] = i18n("island_ship_order_toggle_label_award")
	}
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/confirm")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/cancel")
	arg_2_0.refreshBtn = arg_2_0._tf:Find("frame/refresh")
	arg_2_0.speedUpBtn = arg_2_0._tf:Find("frame/refresh/time")
	arg_2_0.refreshTimeTxt = arg_2_0._tf:Find("frame/refresh/time/Text"):GetComponent(typeof(Text))
	arg_2_0.autoRefreshTimeTr = arg_2_0._tf:Find("frame/list/label")
	arg_2_0.autoRefreshTimeTxt = arg_2_0._tf:Find("frame/list/label/Text/time"):GetComponent(typeof(Text))
	arg_2_0.uiItemList = UIItemList.New(arg_2_0._tf:Find("frame/list/content"), arg_2_0._tf:Find("frame/list/content/tpl"))

	setText(arg_2_0._tf:Find("frame/confirm/Text"), i18n("word_ok"))
	setText(arg_2_0._tf:Find("frame/cancel/Text"), i18n("word_cancel"))
	setText(arg_2_0._tf:Find("frame/list/label"), i18n("island_ship_order_delegate_auto_refresh_label"))
	setText(arg_2_0._tf:Find("frame/list/label/Text"), i18n("island_ship_order_delegate_auto_refresh_time"))

	return
end

function var_0_0.IsEmptySlot(arg_3_0)
	local var_3_0 = arg_3_0:GetIsland():GetOrderAgency():GetShipOrderSlot(arg_3_0.slotId)

	return var_3_0 and var_3_0:IsEmpty()
end

function var_0_0.IsAnyLoadUp(arg_4_0)
	local var_4_0 = arg_4_0:GetIsland():GetOrderAgency():GetShipOrderSlot(arg_4_0.slotId)

	return var_4_0 and var_4_0:GetOrder():IsAnyLoadUp()
end

function var_0_0.CanExchange(arg_5_0)
	local var_5_0 = arg_5_0:GetIsland():GetOrderAgency():GetShipOrderSlot(arg_5_0.slotId)

	return var_5_0 and var_5_0:CanTransport()
end

function var_0_0.OnInit(arg_6_0)
	onButton(arg_6_0, arg_6_0.confirmBtn, function()
		if arg_6_0:IsSelectMode() and arg_6_0.selectedId then
			local var_7_0 = arg_6_0.selectedId

			if arg_6_0:IsEmptySlot() then
				arg_6_0:emit(IslandMediator.EXCHANGE_SHIP_ORDER, arg_6_0.slotId, arg_6_0.selectedId)
			elseif arg_6_0:IsAnyLoadUp() and not arg_6_0:CanExchange() then
				pg.TipsMgr.GetInstance():ShowTip(i18n("island_order_ship_exchange_tip_2"))
			else
				local var_7_1 = arg_6_0:IsAnyLoadUp() and i18n("island_order_ship_exchange_tip_1") or i18n("island_order_ship_exchange_tip")

				arg_6_0:ShowMsgBox({
					content = var_7_1,
					onYes = function()
						arg_6_0:emit(IslandMediator.EXCHANGE_SHIP_ORDER, arg_6_0.slotId, var_7_0)

						return
					end
				})
			end
		end

		arg_6_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.cancelBtn, function()
		arg_6_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0._tf, function()
		arg_6_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.refreshBtn, function()
		arg_6_0:ShowMsgBox({
			content = i18n("island_order_ship_reset_all"),
			onYes = function()
				arg_6_0:emit(IslandMediator.RESET_SHIP_ORDER)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.speedUpBtn, function()
		arg_6_0:OpenPage(IslandTicketUsePage, IslandUseTicketCommand.TYPES.SHIP_ORDER_RELOAD, 0)

		return
	end, SFX_PANEL)
	arg_6_0:InitToggles()

	return
end

function var_0_0.AddListeners(arg_14_0)
	arg_14_0:AddListener(GAME.ISLAND_RESET_SHIP_ORDER_DONE, arg_14_0.OnResetShipOrderList)
	arg_14_0:AddListener(GAME.ISLAND_USE_TICKET_DONE, arg_14_0.OnUseTicketDone)

	return
end

function var_0_0.RemoveListeners(arg_15_0)
	arg_15_0:RemoveListener(GAME.ISLAND_RESET_SHIP_ORDER_DONE, arg_15_0.OnResetShipOrderList)
	arg_15_0:RemoveListener(GAME.ISLAND_USE_TICKET_DONE, arg_15_0.OnUseTicketDone)

	return
end

function var_0_0.OnUseTicketDone(arg_16_0, arg_16_1)
	if arg_16_1.type == IslandUseTicketCommand.TYPES.SHIP_ORDER_RELOAD then
		arg_16_0:FlushRefreshBtn()
	end

	return
end

function var_0_0.OnResetShipOrderList(arg_17_0)
	arg_17_0:InitList()
	arg_17_0:FlushRefreshBtn()

	return
end

function var_0_0.OnShow(arg_18_0, arg_18_1)
	arg_18_0.slotId = arg_18_1

	arg_18_0:UpdateMode(arg_18_1)
	arg_18_0:FlushRefreshBtn()
	arg_18_0:InitList()
	arg_18_0:TriggerDefaultToggle()

	return
end

function var_0_0.IsSelectMode(arg_19_0)
	return arg_19_0.mode == var_0_2 and arg_19_0.slotId ~= nil
end

function var_0_0.UpdateMode(arg_20_0, arg_20_1)
	arg_20_0.mode = var_0_1

	if arg_20_1 then
		arg_20_0.mode = var_0_2
	end

	return
end

function var_0_0.GetDisplays(arg_21_0)
	for iter_21_0, iter_21_1 in pairs((arg_21_0:GetIsland():GetOrderAgency():GetDelegateList())) do
		if iter_21_1:CanShow() then
			table.insert({}, iter_21_1)
		end
	end

	return {}
end

function var_0_0.InitList(arg_22_0)
	local var_22_0 = arg_22_0:GetDisplays()

	arg_22_0:RemoveNextAutoRefreshTimer()
	setActive(arg_22_0.autoRefreshTimeTr, #var_22_0 <= 0)

	if #var_22_0 <= 0 then
		arg_22_0.selectedId = nil

		arg_22_0:AddNextAutoRefreshTimer()
		arg_22_0.uiItemList:align(0)

		return
	end

	arg_22_0.uiItemList:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			arg_22_0:UpdateItem(arg_23_2, var_22_0[arg_23_1 + 1])
			onToggle(arg_22_0, arg_23_2, function(arg_24_0)
				if arg_24_0 then
					arg_22_0.selectedId = var_22_0[arg_23_1 + 1].id
				end

				return
			end, SFX_PANEL)

			if arg_23_1 == 0 then
				triggerToggle(arg_23_2, true)
			end
		end

		return
	end)
	arg_22_0.uiItemList:align(#var_22_0)

	return
end

function var_0_0.AddNextAutoRefreshTimer(arg_25_0)
	local var_25_0 = arg_25_0:GetIsland():GetOrderAgency():GetNextAutoReloadDelegateTime()

	arg_25_0.autoTimer = Timer.New(function()
		local var_26_0 = var_25_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_26_0 < 0 then
			arg_25_0:RemoveNextAutoRefreshTimer()

			arg_25_0.autoRefreshTimeTxt.text = ""

			if #arg_25_0:GetDisplays() > 0 then
				arg_25_0:InitList()
			end
		else
			local var_26_1 = arg_25_0.autoRefreshTimeTxt

			var_26_1.text = pg.TimeMgr.GetInstance():DescCDTime(var_26_0)
		end

		return
	end, 1, -1)

	arg_25_0.autoTimer:Start()
	arg_25_0.autoTimer.func()

	return
end

function var_0_0.RemoveNextAutoRefreshTimer(arg_27_0)
	if arg_27_0.autoTimer then
		arg_27_0.autoTimer:Stop()

		arg_27_0.autoTimer = nil
	end

	return
end

function var_0_0.UpdateItem(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2:GetRequestList()

	setText(arg_28_1:Find("num"), "0" .. arg_28_2.id)

	local var_28_1 = UIItemList.New(arg_28_1:Find("request"), arg_28_1:Find("request/tpl"))

	var_28_1:make(function(arg_29_0, arg_29_1, arg_29_2)
		if arg_29_0 == UIItemList.EventUpdate then
			local var_29_0 = Drop.New(var_28_0[arg_29_1 + 1])
			local var_29_1 = var_29_0.icon or var_29_0:getConfig("icon")

			GetImageSpriteFromAtlasAsync("island/" .. var_29_1, "", arg_29_2:Find("icon"))

			local var_29_2 = var_29_0:getOwnedCount()

			setText(arg_29_2:Find("cnt"), setColorStr(var_29_2 .. "/" .. var_29_0.count, var_29_2 >= var_29_0.count and "#39beff" or "#f36c6e"))
			setActive(arg_29_2:Find("mark"), var_29_2 >= var_29_0.count)
		end

		return
	end)
	var_28_1:align(#arg_28_2:GetRequestList())

	local var_28_2 = arg_28_2:GetAwardList()
	local var_28_3 = UIItemList.New(arg_28_1:Find("award"), arg_28_1:Find("award/tpl"))

	var_28_3:make(function(arg_30_0, arg_30_1, arg_30_2)
		if arg_30_0 == UIItemList.EventUpdate then
			local var_30_0 = Drop.New(var_28_2[arg_30_1 + 1])

			updateCustomDrop(arg_30_2, Drop.New(var_28_2[arg_30_1 + 1]))
		end

		return
	end)
	var_28_3:align(#arg_28_2:GetAwardList())

	return
end

function var_0_0.FlushRefreshBtn(arg_31_0)
	local var_31_0, var_31_1 = arg_31_0:GetIsland():GetOrderAgency():CanRefreshShipOrderDelegate()

	setGray(arg_31_0.refreshBtn, not var_31_0, true)
	setButtonEnabled(arg_31_0.refreshBtn, var_31_0)
	setActive(arg_31_0.refreshTimeTxt.gameObject.transform.parent, not var_31_0)
	arg_31_0:RemoveRefreshTimer()

	if not var_31_0 then
		arg_31_0:AddRefreshTimer(var_31_1)
	end

	return
end

function var_0_0.AddRefreshTimer(arg_32_0, arg_32_1)
	arg_32_0.timer = Timer.New(function()
		local var_33_0 = arg_32_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_33_0 < 0 then
			arg_32_0:RemoveRefreshTimer()

			arg_32_0.refreshTimeTxt.text = ""

			arg_32_0:FlushRefreshBtn()
		else
			local var_33_1 = arg_32_0.refreshTimeTxt

			var_33_1.text = pg.TimeMgr.GetInstance():DescCDTime(var_33_0)
		end

		return
	end, 1, -1)

	arg_32_0.timer:Start()
	arg_32_0.timer.func()

	return
end

function var_0_0.RemoveRefreshTimer(arg_34_0)
	if arg_34_0.timer then
		arg_34_0.timer:Stop()

		arg_34_0.timer = nil
	end

	return
end

function var_0_0.InitToggles(arg_35_0)
	for iter_35_0, iter_35_1 in pairs(arg_35_0.toggles) do
		onToggle(arg_35_0, iter_35_1, function(arg_36_0)
			arg_35_0:SwitchPage(iter_35_0)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.SwitchPage(arg_37_0, arg_37_1)
	arg_37_0.pageIndex = arg_37_1

	for iter_37_0, iter_37_1 in pairs(arg_37_0.toggles) do
		setText(iter_37_1:Find("Text"), (setColorStr(arg_37_0.toggleLabels[iter_37_0], iter_37_0 == arg_37_1 and "#F9B64B" or "#707172")))
	end

	arg_37_0.uiItemList:each(function(arg_38_0, arg_38_1)
		setActive(arg_38_1:Find("request"), arg_37_1 == var_0_3)
		setActive(arg_38_1:Find("award"), arg_37_1 == var_0_4)

		return
	end)

	return
end

function var_0_0.TriggerDefaultToggle(arg_39_0)
	triggerToggle(arg_39_0.toggles[var_0_3], true)

	return
end

function var_0_0.RemoveTimers(arg_40_0)
	arg_40_0:RemoveRefreshTimer()
	arg_40_0:RemoveNextAutoRefreshTimer()

	return
end

function var_0_0.OnHide(arg_41_0)
	arg_41_0:RemoveTimers()

	arg_41_0.selectedId = nil

	return
end

function var_0_0.OnExit(arg_42_0)
	arg_42_0:RemoveTimers()

	arg_42_0.selectedId = nil

	return
end

return var_0_0
