local var_0_0 = class("IslandShipOrderPage", import("...base.IslandBasePage"))

var_0_0.MODE_REQUEST_VIEW = 0
var_0_0.MODE_AWARD_VIEW = 1
var_0_0.EVENT_CLOSE_LOAD_UP = "IslandShipOrderPage:EVENT_CLOSE_LOAD_UP"

function var_0_0.getUIName(arg_1_0)
	return "IslandShipOrderUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("back")
	arg_2_0.uiSlots = UIItemList.New(arg_2_0._tf:Find("frame/list"), arg_2_0._tf:Find("frame/list/tpl"))
	arg_2_0.onekeySlots = UIItemList.New(arg_2_0._tf:Find("list_1"), arg_2_0._tf:Find("list_1/onekey"))
	arg_2_0.switchBtn = arg_2_0._tf:Find("frame/switch")
	arg_2_0.cards = {}
	arg_2_0.loadUpPage = IslandShipOrderLoadUpPage.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.canvasGroup = GetOrAddComponent(arg_2_0._tf, typeof(CanvasGroup))
	arg_2_0.delegateBtn = arg_2_0._tf:Find("frame/event_btn")
	arg_2_0.uilistAniamtion = arg_2_0._tf:Find("frame/list"):GetComponent(typeof(Animation))

	setText(arg_2_0._tf:Find("frame/switch/on/Text"), i18n("island_order_ship_page_req"))
	setText(arg_2_0._tf:Find("frame/switch/off/Text"), i18n("island_order_ship_page_award"))
	setText(arg_2_0._tf:Find("list_1/onekey/btn/Text"), i18n("island_order_ship_page_onekey_loadup"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("frame/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_ship_order.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.delegateBtn, function()
		arg_3_0:OpenPage(IslandShipOrderDelegatePage)

		return
	end, SFX_PANEL)
	arg_3_0:bind(var_0_0.EVENT_CLOSE_LOAD_UP, function()
		arg_3_0:ClearSelected()

		return
	end)
	triggerToggle(arg_3_0.switchBtn, false)
	onToggle(arg_3_0, arg_3_0.switchBtn, function(arg_8_0)
		arg_3_0:SwitchMode(arg_8_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddListener(GAME.ISLAND_SHIP_ORDER_OP_DONE, arg_9_0.OnOrderUpdate)
	arg_9_0:AddListener(GAME.ISLAND_USE_TICKET_DONE, arg_9_0.OnUseTicketDone)
	arg_9_0:AddListener(GAME.ISLAND_REFRESH_SHIP_ORDER_DONE, arg_9_0.OnRefreshOrder)
	arg_9_0:AddListener(IslandShipOrderCard.EVENT_CD_END, arg_9_0.OnOrderReloadingEnd)
	arg_9_0:AddListener(GAME.ISLAND_EXCHANGE_SHIP_ORDER_DONE, arg_9_0.OnExchangeShipOrderDone)
	arg_9_0:AddListener(GAME.ISLAND_RESET_SHIP_ORDER_DONE, arg_9_0.OnResetShipOrderList)

	return
end

function var_0_0.RemoveListeners(arg_10_0)
	arg_10_0:RemoveListener(GAME.ISLAND_SHIP_ORDER_OP_DONE, arg_10_0.OnOrderUpdate)
	arg_10_0:RemoveListener(GAME.ISLAND_USE_TICKET_DONE, arg_10_0.OnUseTicketDone)
	arg_10_0:RemoveListener(GAME.ISLAND_REFRESH_SHIP_ORDER_DONE, arg_10_0.OnRefreshOrder)
	arg_10_0:RemoveListener(IslandShipOrderCard.EVENT_CD_END, arg_10_0.OnOrderReloadingEnd)
	arg_10_0:RemoveListener(GAME.ISLAND_EXCHANGE_SHIP_ORDER_DONE, arg_10_0.OnExchangeShipOrderDone)
	arg_10_0:RemoveListener(GAME.ISLAND_RESET_SHIP_ORDER_DONE, arg_10_0.OnResetShipOrderList)

	return
end

function var_0_0.OnResetShipOrderList(arg_11_0)
	arg_11_0:FlushSlots()

	return
end

function var_0_0.OnExchangeShipOrderDone(arg_12_0, arg_12_1)
	arg_12_0:OnRefreshOrder({
		id = arg_12_1.id
	})
	arg_12_0:UpdateOnekeyBtns()

	return
end

function var_0_0.OnOrderReloadingEnd(arg_13_0)
	arg_13_0:UpdateOnekeyBtns()

	return
end

function var_0_0.OnRefreshOrder(arg_14_0, arg_14_1)
	local var_14_0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.cards) do
		if iter_14_1.slot.id == arg_14_1.id then
			var_14_0 = iter_14_1

			break
		end
	end

	if not var_14_0 then
		return
	end

	var_14_0:Flush(var_14_0.slot, arg_14_0.mode)
	arg_14_0:UpdateOnekeyBtns()

	return
end

function var_0_0.OnOrderUpdate(arg_15_0, arg_15_1)
	local var_15_0

	for iter_15_0, iter_15_1 in pairs(arg_15_0.cards) do
		if iter_15_1.slot.id == arg_15_1.id then
			var_15_0 = iter_15_1

			break
		end
	end

	if not var_15_0 then
		return
	end

	arg_15_0:ClearSelected()

	arg_15_0.canvasGroup.blocksRaycasts = false

	seriesAsync({
		function(arg_16_0)
			var_15_0:PlayAniamtion(arg_15_1.op, arg_15_1.isLoadUpAll, arg_16_0)

			return
		end
	}, function()
		arg_15_0.canvasGroup.blocksRaycasts = true

		var_15_0:Flush(var_15_0.slot, arg_15_0.mode)
		arg_15_0:RegisterCardEvent(var_15_0)

		for iter_17_0, iter_17_1 in pairs(arg_15_0.cards) do
			iter_17_1:UpdateRequest(iter_17_1.slot)
		end

		arg_15_0:UpdateOnekeyBtns()

		return
	end)

	return
end

function var_0_0.OnUseTicketDone(arg_18_0, arg_18_1)
	if arg_18_1.type == IslandUseTicketCommand.TYPES.SHIP_ORDER then
		local var_18_0

		for iter_18_0, iter_18_1 in pairs(arg_18_0.cards) do
			if iter_18_1.slot.id == arg_18_1.id then
				var_18_0 = iter_18_1

				break
			end
		end

		if not var_18_0 then
			return
		end

		var_18_0:Flush(var_18_0.slot, arg_18_0.mode)
	end

	arg_18_0:UpdateOnekeyBtns()

	return
end

function var_0_0.OnShow(arg_19_0)
	arg_19_0.mode = var_0_0.MODE_REQUEST_VIEW
	arg_19_0.canvasGroup.blocksRaycasts = true

	arg_19_0:FlushSlots()
	arg_19_0:UnlockFirstSlot()

	return
end

function var_0_0.UnlockFirstSlot(arg_20_0)
	if arg_20_0.displays[1] and arg_20_0.displays[1]:IsLock() and arg_20_0.displays[1]:GetUnlockGold().count <= 0 then
		for iter_20_0, iter_20_1 in pairs(arg_20_0.cards) do
			if iter_20_1.slot.id == arg_20_0.displays[1].id then
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

function var_0_0.SwitchMode(arg_21_0, arg_21_1)
	if arg_21_1 then
		arg_21_0.mode = var_0_0.MODE_AWARD_VIEW or var_0_0.MODE_REQUEST_VIEW

		for iter_21_0, iter_21_1 in pairs(arg_21_0.cards) do
			iter_21_1:SwitchMode(iter_21_1.slot, arg_21_0.mode)
		end

		arg_21_0:ClearSelected()
		arg_21_0.uilistAniamtion:Stop()
		arg_21_0.uilistAniamtion:Play("anim_island_shiporder_list")

		return
	end
end

function var_0_0.GetDisplays(arg_22_0, ...)
	for iter_22_0, iter_22_1 in pairs((getProxy(IslandProxy):GetIsland():GetOrderAgency():GetShipSlotList())) do
		table.insert({}, iter_22_1)
	end

	return {}
end

function var_0_0.FlushSlots(arg_23_0)
	arg_23_0.displays = arg_23_0:GetDisplays()

	table.sort(arg_23_0.displays, function(arg_24_0, arg_24_1)
		return arg_24_0:GetUnlockLevel() < arg_24_1:GetUnlockLevel()
	end)
	arg_23_0.uiSlots:make(function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			local var_25_0 = pg.TimeMgr.GetInstance()

			print(arg_23_0.displays[arg_25_1 + 1].finishCnt, arg_23_0.displays[arg_25_1 + 1].nextRefreshFinishCntTime <= var_25_0:GetServerTime())
			arg_23_0:UpdateSlot(arg_23_0.displays[arg_25_1 + 1], arg_25_2)
		end

		return
	end)
	arg_23_0.uiSlots:align(#arg_23_0.displays)
	arg_23_0:UpdateOnekeyBtns()

	return
end

function var_0_0.UpdateOnekeyBtns(arg_26_0)
	arg_26_0.onekeySlots:make(function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == UIItemList.EventUpdate then
			local var_27_0 = arg_27_2:Find("btn")
			local var_27_1 = arg_26_0.displays[arg_27_1 + 1]
			local var_27_2 = arg_26_0.displays[arg_27_1 + 1]:IsWaiting() and not arg_26_0.displays[arg_27_1 + 1]:IsEmpty()

			setActive(var_27_0, var_27_2)

			if arg_26_0.displays[arg_27_1 + 1]:IsWaiting() then
				local var_27_3

				if arg_26_0.displays[arg_27_1 + 1]:GetOrder():AnyCanLoadUp() then
					var_27_3 = not arg_26_0.displays[arg_27_1 + 1]:CanTransport()

					if false then
						var_27_3 = false
					end
				else
					var_27_3 = true
				end

				setGray(var_27_0, var_27_3, true)

				if not var_27_3 then
					onButton(arg_26_0, var_27_0, function()
						if var_27_1:IsEmpty() then
							return
						end

						arg_26_0:emit(IslandMediator.SUBMIT_SHIP_ORDER_ITME_ONEKEY, var_27_1.id)

						return
					end, SFX_PANEL)
				else
					removeOnButton(var_27_0)
				end

				return
			end
		end
	end)
	arg_26_0.onekeySlots:align(#arg_26_0.displays)

	return
end

function var_0_0.UpdateSlot(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0.cards[arg_29_2] or IslandShipOrderCard.New(arg_29_2, arg_29_0)

	var_29_0:Flush(arg_29_1, arg_29_0.mode)
	onButton(arg_29_0, var_29_0.getBtn, function()
		arg_29_0:emit(IslandMediator.GET_SHIP_ORDER_AWARD, var_29_0.slot.id)

		return
	end, SFX_PANEL)
	onButton(arg_29_0, var_29_0.lockTr, function()
		arg_29_0:emit(IslandMediator.UNLOKC_SHIP_ORDER, var_29_0.slot.id)

		return
	end, SFX_PANEL)
	onButton(arg_29_0, var_29_0.loadingRequest, function()
		arg_29_0:OpenPage(IslandTicketUsePage, IslandUseTicketCommand.TYPES.SHIP_ORDER, var_29_0.slot.id)

		return
	end, SFX_PANEL)
	onButton(arg_29_0, var_29_0.exchangeBtn, function()
		arg_29_0:OpenPage(IslandShipOrderDelegatePage, var_29_0.slot.id)

		return
	end, SFX_PANEL)
	onButton(arg_29_0, var_29_0.emptyTr, function()
		arg_29_0:OpenPage(IslandShipOrderDelegatePage, var_29_0.slot.id)

		return
	end, SFX_PANEL)
	onNextTick(function()
		arg_29_0:RegisterCardEvent(var_29_0)

		return
	end)

	arg_29_0.cards[arg_29_2] = var_29_0

	return
end

function var_0_0.CheckSelected(arg_36_0, arg_36_1)
	if arg_36_0.loadUpItem == arg_36_1 then
		arg_36_0:ClearSelected()

		return false
	end

	return true
end

function var_0_0.RegisterCardEvent(arg_37_0, arg_37_1)
	arg_37_1.uiRequestList:each(function(arg_38_0, arg_38_1)
		onButton(arg_37_0, arg_38_1, function()
			if not arg_37_1.slot:IsWaiting() then
				return
			end

			local var_39_0 = arg_37_1.slot:GetOrder()

			if var_39_0:ItemIsSubmited(arg_38_0 + 1) then
				return
			end

			if not arg_37_0:CheckSelected(arg_38_1) then
				return
			end

			arg_37_0:ClearSelected()
			setActive(arg_38_1:Find("loaded_1"), true)
			arg_37_0:LoadUpItem(arg_37_1, arg_38_0 + 1, arg_38_1)

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function var_0_0.ClearSelected(arg_40_0)
	if arg_40_0.loadUpItem then
		setActive(arg_40_0.loadUpItem:Find("loaded_1"), false)
	end

	arg_40_0.loadUpItem = nil

	if arg_40_0.loadUpPage and arg_40_0.loadUpPage:GetLoaded() and arg_40_0.loadUpPage:isShowing() then
		arg_40_0.loadUpPage:Hide()
	end

	return
end

function var_0_0.LoadUpItem(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = arg_41_0._tf:InverseTransformPoint(arg_41_3:Find("loaded_1").position)

	arg_41_0.loadUpPage:ExecuteAction("Show", Vector3(var_41_0.x, var_41_0.y, 0), arg_41_1.slot, arg_41_2)

	arg_41_0.loadUpItem = arg_41_3

	return
end

function var_0_0.OnHide(arg_42_0)
	arg_42_0:ClearSelected()

	if arg_42_0.loadUpPage then
		arg_42_0.loadUpPage:Destroy()
		arg_42_0.loadUpPage:Reset()
	end

	return
end

function var_0_0.OnDestroy(arg_43_0)
	for iter_43_0, iter_43_1 in pairs(arg_43_0.cards) do
		iter_43_1:Dispose()
	end

	arg_43_0.cards = {}

	if arg_43_0.loadUpPage then
		arg_43_0.loadUpPage:Destroy()

		arg_43_0.loadUpPage = nil
	end

	return
end

return var_0_0
