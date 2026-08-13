class = var_0_10000

local var_0_0 = "IslandShipOrderPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

var_0_1.MODE_REQUEST_VIEW = 0
var_0_1.MODE_AWARD_VIEW = 1
var_0_1.EVENT_CLOSE_LOAD_UP = "IslandShipOrderPage:EVENT_CLOSE_LOAD_UP"

function var_0_1.getUIName(arg_1_0)
	return "IslandShipOrderUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "back")
	UIItemList = var_1

	local var_2_1 = var_1.New
	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "frame/list")
	local var_2_4 = arg_2_0._tf

	arg_2_0.uiSlots = var_2_1(var_2_3, var_3.Find(var_2_4, "frame/list/tpl"))
	UIItemList = var_1

	local var_2_5 = var_1.New
	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "list_1")
	local var_2_8 = arg_2_0._tf

	arg_2_0.onekeySlots = var_2_5(var_2_7, var_3.Find(var_2_8, "list_1/onekey"))

	local var_2_9 = arg_2_0._tf

	arg_2_0.switchBtn = var_1.Find(var_2_9, "frame/switch")
	arg_2_0.cards = {}
	IslandShipOrderLoadUpPage = var_1
	arg_2_0.loadUpPage = var_1.New(arg_2_0._tf, arg_2_0.event)
	GetOrAddComponent = var_1

	local var_2_10 = arg_2_0._tf

	typeof = var_3
	CanvasGroup = var_2_8
	arg_2_0.canvasGroup = var_1(var_2_10, var_3(var_2_8))

	local var_2_11 = arg_2_0._tf

	arg_2_0.delegateBtn = var_1.Find(var_2_11, "frame/event_btn")

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "frame/list")
	local var_2_14 = var_1.GetComponent

	typeof = var_3
	Animation = var_2_8
	arg_2_0.uilistAniamtion = var_2_14(var_2_13, var_3(var_2_8))
	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_2.Find(var_2_15, "frame/switch/on/Text")

	i18n = var_2_15

	var_1(var_2_16, var_2_15("island_order_ship_page_req"))

	setText = var_1

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_2.Find(var_2_17, "frame/switch/off/Text")

	i18n = var_2_17

	var_1(var_2_18, var_2_17("island_order_ship_page_award"))

	setText = var_1

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_2.Find(var_2_19, "list_1/onekey/btn/Text")

	i18n = var_2_19

	var_1(var_2_20, var_2_19("island_order_ship_page_onekey_loadup"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_3.Find(var_3_4, "frame/help")

	local function var_3_6()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003
		pg = var_2_10003
		var_5_2.helps = var_2_10003.gametip.island_help_ship_order.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_3, var_3_5, var_3_6, var_5)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.delegateBtn

	local function var_3_9()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.OpenPage

		IslandShipOrderDelegatePage = var_2_10002

		var_6_1(var_6_0, var_2_10002)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_7, var_3_8, var_3_9, var_5)
	arg_3_0:bind(var_0_1.EVENT_CLOSE_LOAD_UP, function()
		local var_7_0 = arg_3_0

		var_0.ClearSelected(var_7_0)

		return
	end)

	triggerToggle = var_1

	var_1(arg_3_0.switchBtn, false)

	onToggle = var_1

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.switchBtn

	local function var_3_12(arg_8_0)
		local var_8_0 = arg_3_0

		var_1.SwitchMode(var_8_0, arg_8_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_10, var_3_11, var_3_12, var_5)

	return
end

function var_0_1.AddListeners(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.AddListener

	GAME = var_1_10003

	var_9_1(var_9_0, var_1_10003.ISLAND_SHIP_ORDER_OP_DONE, arg_9_0.OnOrderUpdate)

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.AddListener

	GAME = var_3

	var_9_3(var_9_2, var_3.ISLAND_USE_TICKET_DONE, arg_9_0.OnUseTicketDone)

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0.AddListener

	GAME = var_3

	var_9_5(var_9_4, var_3.ISLAND_REFRESH_SHIP_ORDER_DONE, arg_9_0.OnRefreshOrder)

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.AddListener

	IslandShipOrderCard = var_3

	var_9_7(var_9_6, var_3.EVENT_CD_END, arg_9_0.OnOrderReloadingEnd)

	local var_9_8 = arg_9_0
	local var_9_9 = arg_9_0.AddListener

	GAME = var_3

	var_9_9(var_9_8, var_3.ISLAND_EXCHANGE_SHIP_ORDER_DONE, arg_9_0.OnExchangeShipOrderDone)

	local var_9_10 = arg_9_0
	local var_9_11 = arg_9_0.AddListener

	GAME = var_3

	var_9_11(var_9_10, var_3.ISLAND_RESET_SHIP_ORDER_DONE, arg_9_0.OnResetShipOrderList)

	return
end

function var_0_1.RemoveListeners(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.RemoveListener

	GAME = var_1_10003

	var_10_1(var_10_0, var_1_10003.ISLAND_SHIP_ORDER_OP_DONE, arg_10_0.OnOrderUpdate)

	local var_10_2 = arg_10_0
	local var_10_3 = arg_10_0.RemoveListener

	GAME = var_3

	var_10_3(var_10_2, var_3.ISLAND_USE_TICKET_DONE, arg_10_0.OnUseTicketDone)

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.RemoveListener

	GAME = var_3

	var_10_5(var_10_4, var_3.ISLAND_REFRESH_SHIP_ORDER_DONE, arg_10_0.OnRefreshOrder)

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_0.RemoveListener

	IslandShipOrderCard = var_3

	var_10_7(var_10_6, var_3.EVENT_CD_END, arg_10_0.OnOrderReloadingEnd)

	local var_10_8 = arg_10_0
	local var_10_9 = arg_10_0.RemoveListener

	GAME = var_3

	var_10_9(var_10_8, var_3.ISLAND_EXCHANGE_SHIP_ORDER_DONE, arg_10_0.OnExchangeShipOrderDone)

	local var_10_10 = arg_10_0
	local var_10_11 = arg_10_0.RemoveListener

	GAME = var_3

	var_10_11(var_10_10, var_3.ISLAND_RESET_SHIP_ORDER_DONE, arg_10_0.OnResetShipOrderList)

	return
end

function var_0_1.OnResetShipOrderList(arg_11_0)
	arg_11_0:FlushSlots()

	return
end

function var_0_1.OnExchangeShipOrderDone(arg_12_0, arg_12_1)
	arg_12_0:OnRefreshOrder({
		id = arg_12_1.id
	})
	arg_12_0:UpdateOnekeyBtns()

	return
end

function var_0_1.OnOrderReloadingEnd(arg_13_0)
	arg_13_0:UpdateOnekeyBtns()

	return
end

function var_0_1.OnRefreshOrder(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.id
	local var_14_1

	pairs = var_1_10004

	for iter_14_0, iter_14_1 in var_1_10004(arg_14_0.cards) do
		if iter_14_1.slot.id == var_14_0 then
			var_14_1 = iter_14_1

			break
		end
	end

	if not var_14_1 then
		return
	end

	var_14_1:Flush(var_14_1.slot, arg_14_0.mode)
	arg_14_0:UpdateOnekeyBtns()

	return
end

function var_0_1.OnOrderUpdate(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.id
	local var_15_1

	pairs = var_1_10004

	for iter_15_0, iter_15_1 in var_1_10004(arg_15_0.cards) do
		if iter_15_1.slot.id == var_15_0 then
			var_15_1 = iter_15_1

			break
		end
	end

	if not var_15_1 then
		return
	end

	arg_15_0:ClearSelected()

	local var_15_2 = arg_15_0.canvasGroup

	var_15_2.blocksRaycasts = false
	seriesAsync = var_15_2

	var_15_2({
		function(arg_16_0)
			local var_16_0 = var_15_1

			var_1.PlayAniamtion(var_16_0, arg_15_1.op, arg_15_1.isLoadUpAll, arg_16_0)

			return
		end
	}, function()
		arg_15_0.canvasGroup.blocksRaycasts = true

		local var_17_0 = var_15_1

		var_0.Flush(var_17_0, var_15_1.slot, arg_15_0.mode)

		local var_17_1 = arg_15_0

		var_0.RegisterCardEvent(var_17_1, var_15_1)

		pairs = var_0

		for iter_17_0, iter_17_1 in var_0(arg_15_0.cards) do
			iter_17_1:UpdateRequest(iter_17_1.slot)
		end

		local var_17_2 = arg_15_0

		var_0.UpdateOnekeyBtns(var_17_2)

		return
	end)

	return
end

function var_0_1.OnUseTicketDone(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.type

	IslandUseTicketCommand = var_1_10003

	if var_18_0 == var_1_10003.TYPES.SHIP_ORDER then
		local var_18_1 = arg_18_1.id
		local var_18_2

		pairs = var_1_10004

		for iter_18_0, iter_18_1 in var_1_10004(arg_18_0.cards) do
			if iter_18_1.slot.id == var_18_1 then
				var_18_2 = iter_18_1

				break
			end
		end

		if not var_18_2 then
			return
		end

		var_18_2:Flush(var_18_2.slot, arg_18_0.mode)
	end

	arg_18_0:UpdateOnekeyBtns()

	return
end

function var_0_1.OnShow(arg_19_0)
	arg_19_0.mode = var_0_1.MODE_REQUEST_VIEW
	arg_19_0.canvasGroup.blocksRaycasts = true

	arg_19_0:FlushSlots()
	arg_19_0:UnlockFirstSlot()

	return
end

function var_0_1.UnlockFirstSlot(arg_20_0)
	if arg_20_0.displays[1] and var_1:IsLock() and var_1:GetUnlockGold().count <= 0 then
		pairs = var_2

		for iter_20_0, iter_20_1 in var_2(arg_20_0.cards) do
			if iter_20_1.slot.id == var_1.id then
				iter_20_1 = target

				break
			end
		end

		target = var_2

		if var_2 then
			triggerButton = var_2
			target = var_3

			var_2(var_3.lockTr)
		end
	end

	return
end

function var_0_1.SwitchMode(arg_21_0, arg_21_1)
	local var_21_0

	if not arg_21_1 or not var_0_1.MODE_AWARD_VIEW then
		var_21_0 = var_0_1.MODE_REQUEST_VIEW
	end

	arg_21_0.mode = var_21_0
	pairs = var_21_0

	for iter_21_0, iter_21_1 in var_21_0(arg_21_0.cards) do
		iter_21_1:SwitchMode(iter_21_1.slot, arg_21_0.mode)
	end

	arg_21_0:ClearSelected()

	local var_21_1 = arg_21_0.uilistAniamtion

	var_2.Stop(var_21_1)

	local var_21_2 = arg_21_0.uilistAniamtion

	var_2.Play(var_21_2, "anim_island_shiporder_list")

	return
end

function var_0_1.GetDisplays(arg_22_0, ...)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_22_0 = var_1_10001(var_1_10002)
	local var_22_1 = var_1.GetIsland(var_22_0)
	local var_22_2 = var_1.GetOrderAgency(var_22_1)
	local var_22_3 = var_1.GetShipSlotList(var_22_2)
	local var_22_4 = {}

	pairs = var_1_10004

	for iter_22_0, iter_22_1 in var_1_10004(var_22_3) do
		table = var_1_10009

		var_1_10009.insert(var_22_4, iter_22_1)
	end

	return var_22_4
end

function var_0_1.FlushSlots(arg_23_0)
	arg_23_0.displays = arg_23_0:GetDisplays()
	table = var_1

	var_1.sort(arg_23_0.displays, function(arg_24_0, arg_24_1)
		return arg_24_0:GetUnlockLevel() < arg_24_1:GetUnlockLevel()
	end)

	local var_23_0 = arg_23_0.uiSlots

	var_1.make(var_23_0, function(arg_25_0, arg_25_1, arg_25_2)
		UIItemList = var_2_10003

		if arg_25_0 == var_2_10003.EventUpdate then
			local var_25_0 = arg_23_0.displays[arg_25_1 + 1].nextRefreshFinishCntTime

			pg = var_4

			local var_25_1 = var_4.TimeMgr.GetInstance()
			local var_25_2 = var_4.GetServerTime(var_25_1)

			print = var_25_1

			var_25_1(arg_23_0.displays[arg_25_1 + 1].finishCnt, var_25_0 <= var_25_2)

			local var_25_3 = arg_23_0

			var_5.UpdateSlot(var_25_3, arg_23_0.displays[arg_25_1 + 1], arg_25_2)
		end

		return
	end)

	local var_23_1 = arg_23_0.uiSlots

	var_1.align(var_23_1, #arg_23_0.displays)
	arg_23_0:UpdateOnekeyBtns()

	return
end

function var_0_1.UpdateOnekeyBtns(arg_26_0)
	local var_26_0 = arg_26_0.onekeySlots

	var_1.make(var_26_0, function(arg_27_0, arg_27_1, arg_27_2)
		UIItemList = var_2_10003

		if arg_27_0 == var_2_10003.EventUpdate then
			local var_27_0 = arg_27_2:Find("btn")
			local var_27_1 = arg_26_0.displays[arg_27_1 + 1]

			setActive = var_5

			local var_27_2 = var_27_0
			local var_27_3

			if var_27_1:IsWaiting() then
				var_27_3 = not var_27_1:IsEmpty()
			end

			var_5(var_27_2, var_27_3)

			local var_27_4 = var_27_1

			if var_27_1.IsWaiting(var_27_4) then
				var_27_4 = var_27_1
				var_27_4 = var_27_1.GetOrder(var_27_4)

				local var_27_5

				if var_5.AnyCanLoadUp(var_27_4) then
					var_27_4 = var_27_1
					var_27_5 = not var_27_1.CanTransport(var_27_4)

					if false then
						var_27_5 = false
					end
				else
					var_27_5 = true
				end

				setGray = var_27_4

				var_27_4(var_27_0, var_27_5, true)

				if not var_27_5 then
					onButton = var_27_4

					local var_27_6 = arg_26_0
					local var_27_7 = var_27_0

					local function var_27_8()
						local var_28_0 = var_27_1

						if var_0.IsEmpty(var_28_0) then
							return
						end

						local var_28_1 = arg_26_0
						local var_28_2 = var_0.emit

						IslandMediator = var_3_10002

						var_28_2(var_28_1, var_3_10002.SUBMIT_SHIP_ORDER_ITME_ONEKEY, var_27_1.id)

						return
					end

					SFX_PANEL = var_2_10010

					var_27_4(var_27_6, var_27_7, var_27_8, var_2_10010)
				else
					removeOnButton = var_27_4

					var_27_4(var_27_0)
				end

				return
			end
		end
	end)

	local var_26_1 = arg_26_0.onekeySlots

	var_1.align(var_26_1, #arg_26_0.displays)

	return
end

function var_0_1.UpdateSlot(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0

	if not arg_29_0.cards[arg_29_2] then
		IslandShipOrderCard = var_29_0
		var_29_0 = var_29_0.New(arg_29_2, arg_29_0)
	end

	var_29_0:Flush(arg_29_1, arg_29_0.mode)

	onButton = var_4

	local var_29_1 = arg_29_0
	local var_29_2 = var_29_0.getBtn

	local function var_29_3()
		local var_30_0 = arg_29_0
		local var_30_1 = var_0.emit

		IslandMediator = var_2_10002

		var_30_1(var_30_0, var_2_10002.GET_SHIP_ORDER_AWARD, var_29_0.slot.id)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_29_1, var_29_2, var_29_3, var_1_10008)

	onButton = var_4

	local var_29_4 = arg_29_0
	local var_29_5 = var_29_0.lockTr

	local function var_29_6()
		local var_31_0 = arg_29_0
		local var_31_1 = var_0.emit

		IslandMediator = var_2_10002

		var_31_1(var_31_0, var_2_10002.UNLOKC_SHIP_ORDER, var_29_0.slot.id)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_29_4, var_29_5, var_29_6, var_1_10008)

	onButton = var_4

	local var_29_7 = arg_29_0
	local var_29_8 = var_29_0.loadingRequest

	local function var_29_9()
		local var_32_0 = arg_29_0
		local var_32_1 = var_0.OpenPage

		IslandTicketUsePage = var_2_10002
		IslandUseTicketCommand = var_2_10003

		var_32_1(var_32_0, var_2_10002, var_2_10003.TYPES.SHIP_ORDER, var_29_0.slot.id)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_29_7, var_29_8, var_29_9, var_1_10008)

	onButton = var_4

	local var_29_10 = arg_29_0
	local var_29_11 = var_29_0.exchangeBtn

	local function var_29_12()
		local var_33_0 = arg_29_0
		local var_33_1 = var_0.OpenPage

		IslandShipOrderDelegatePage = var_2_10002

		var_33_1(var_33_0, var_2_10002, var_29_0.slot.id)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_29_10, var_29_11, var_29_12, var_1_10008)

	onButton = var_4

	local var_29_13 = arg_29_0
	local var_29_14 = var_29_0.emptyTr

	local function var_29_15()
		local var_34_0 = arg_29_0
		local var_34_1 = var_0.OpenPage

		IslandShipOrderDelegatePage = var_2_10002

		var_34_1(var_34_0, var_2_10002, var_29_0.slot.id)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_29_13, var_29_14, var_29_15, var_1_10008)

	onNextTick = var_4

	var_4(function()
		local var_35_0 = arg_29_0

		var_0.RegisterCardEvent(var_35_0, var_29_0)

		return
	end)

	arg_29_0.cards[arg_29_2] = var_29_0

	return
end

function var_0_1.CheckSelected(arg_36_0, arg_36_1)
	if arg_36_0.loadUpItem == arg_36_1 then
		arg_36_0:ClearSelected()

		return false
	end

	return true
end

function var_0_1.RegisterCardEvent(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1.uiRequestList

	var_2.each(var_37_0, function(arg_38_0, arg_38_1)
		onButton = var_2_10002

		local var_38_0 = arg_37_0
		local var_38_1 = arg_38_1

		local function var_38_2()
			local var_39_0 = arg_37_1.slot

			if not var_0.IsWaiting(var_39_0) then
				return
			end

			local var_39_1 = arg_37_1.slot
			local var_39_2 = var_0.GetOrder(var_39_1)

			if var_0.ItemIsSubmited(var_39_2, arg_38_0 + 1) then
				return
			end

			local var_39_3 = arg_37_0

			if not var_0.CheckSelected(var_39_3, arg_38_1) then
				return
			end

			local var_39_4 = arg_37_0

			var_0.ClearSelected(var_39_4)

			setActive = var_0

			local var_39_5 = arg_38_1

			var_0(var_1.Find(var_39_5, "loaded_1"), true)

			local var_39_6 = arg_37_0

			var_0.LoadUpItem(var_39_6, arg_37_1, arg_38_0 + 1, arg_38_1)

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10002(var_38_0, var_38_1, var_38_2, var_2_10006)

		return
	end)

	return
end

function var_0_1.ClearSelected(arg_40_0)
	if arg_40_0.loadUpItem then
		setActive = var_1

		local var_40_0 = arg_40_0.loadUpItem

		var_1(var_2.Find(var_40_0, "loaded_1"), false)
	end

	arg_40_0.loadUpItem = nil

	if arg_40_0.loadUpPage then
		local var_40_1 = arg_40_0.loadUpPage

		if var_1.GetLoaded(var_40_1) then
			local var_40_2 = arg_40_0.loadUpPage

			if var_1.isShowing(var_40_2) then
				local var_40_3 = arg_40_0.loadUpPage

				var_1.Hide(var_40_3)
			end
		end
	end

	return
end

function var_0_1.LoadUpItem(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = arg_41_0._tf
	local var_41_1 = var_4.InverseTransformPoint(var_41_0, arg_41_3:Find("loaded_1").position)
	local var_41_2 = arg_41_0.loadUpPage
	local var_41_3 = var_5.ExecuteAction
	local var_41_4 = "Show"

	Vector3 = var_8

	var_41_3(var_41_2, var_41_4, var_8(var_41_1.x, var_41_1.y, 0), arg_41_1.slot, arg_41_2)

	arg_41_0.loadUpItem = arg_41_3

	return
end

function var_0_1.OnHide(arg_42_0)
	arg_42_0:ClearSelected()

	if arg_42_0.loadUpPage then
		local var_42_0 = arg_42_0.loadUpPage

		var_1.Destroy(var_42_0)

		local var_42_1 = arg_42_0.loadUpPage

		var_1.Reset(var_42_1)
	end

	return
end

function var_0_1.OnDestroy(arg_43_0)
	pairs = var_1_10001

	for iter_43_0, iter_43_1 in var_1_10001(arg_43_0.cards) do
		iter_43_1:Dispose()
	end

	arg_43_0.cards = {}

	if arg_43_0.loadUpPage then
		local var_43_0 = arg_43_0.loadUpPage

		var_1.Destroy(var_43_0)

		arg_43_0.loadUpPage = nil
	end

	return
end

return var_0_1
