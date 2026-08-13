class = var_0_10000

local var_0_0 = "IslandShipOrderDelegatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 1
local var_0_5 = 2

function var_0_1.getUIName(arg_1_0)
	return "IslandShipOrderDelegateUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = var_0_4
	local var_2_2 = arg_2_0._tf

	var_2_0[var_2_1] = var_3.Find(var_2_2, "frame/tags/request")

	local var_2_3 = var_0_5
	local var_2_4 = arg_2_0._tf

	var_2_0[var_2_3] = var_3.Find(var_2_4, "frame/tags/award")
	arg_2_0.toggles = var_2_0

	local var_2_5 = {}
	local var_2_6 = var_0_4

	i18n = var_3
	var_2_5[var_2_6] = var_3("island_ship_order_toggle_label_request")

	local var_2_7 = var_0_5

	i18n = var_3
	var_2_5[var_2_7] = var_3("island_ship_order_toggle_label_award")
	arg_2_0.toggleLabels = var_2_5

	local var_2_8 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_8, "frame/confirm")

	local var_2_9 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_9, "frame/cancel")

	local var_2_10 = arg_2_0._tf

	arg_2_0.refreshBtn = var_1.Find(var_2_10, "frame/refresh")

	local var_2_11 = arg_2_0._tf

	arg_2_0.speedUpBtn = var_1.Find(var_2_11, "frame/refresh/time")

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "frame/refresh/time/Text")
	local var_2_14 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.refreshTimeTxt = var_2_14(var_2_13, var_4(var_6))

	local var_2_15 = arg_2_0._tf

	arg_2_0.autoRefreshTimeTr = var_1.Find(var_2_15, "frame/list/label")

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_1.Find(var_2_16, "frame/list/label/Text/time")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.autoRefreshTimeTxt = var_2_18(var_2_17, var_4(var_6))
	UIItemList = var_1

	local var_2_19 = var_1.New
	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_3.Find(var_2_20, "frame/list/content")
	local var_2_22 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_19(var_2_21, var_4.Find(var_2_22, "frame/list/content/tpl"))
	setText = var_1

	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_3.Find(var_2_23, "frame/confirm/Text")

	i18n = var_4

	var_1(var_2_24, var_4("word_ok"))

	setText = var_1

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_3.Find(var_2_25, "frame/cancel/Text")

	i18n = var_4

	var_1(var_2_26, var_4("word_cancel"))

	setText = var_1

	local var_2_27 = arg_2_0._tf
	local var_2_28 = var_3.Find(var_2_27, "frame/list/label")

	i18n = var_4

	var_1(var_2_28, var_4("island_ship_order_delegate_auto_refresh_label"))

	setText = var_1

	local var_2_29 = arg_2_0._tf
	local var_2_30 = var_3.Find(var_2_29, "frame/list/label/Text")

	i18n = var_4

	var_1(var_2_30, var_4("island_ship_order_delegate_auto_refresh_time"))

	return
end

function var_0_1.IsEmptySlot(arg_3_0)
	local var_3_0 = arg_3_0:GetIsland()
	local var_3_1 = var_1.GetOrderAgency(var_3_0)

	return var_1.GetShipOrderSlot(var_3_1, arg_3_0.slotId) and var_1:IsEmpty()
end

function var_0_1.IsAnyLoadUp(arg_4_0)
	local var_4_0 = arg_4_0:GetIsland()
	local var_4_1 = var_1.GetOrderAgency(var_4_0)
	local var_4_3

	if var_1.GetShipOrderSlot(var_4_1, arg_4_0.slotId) then
		::label_4_0::

		local var_4_2 = var_1:GetOrder()

		var_4_3 = var_2.IsAnyLoadUp(var_4_2)
	end

	return var_4_3
end

function var_0_1.CanExchange(arg_5_0)
	local var_5_0 = arg_5_0:GetIsland()
	local var_5_1 = var_1.GetOrderAgency(var_5_0)

	return var_1.GetShipOrderSlot(var_5_1, arg_5_0.slotId) and var_1:CanTransport()
end

function var_0_1.OnInit(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.confirmBtn

	local function var_6_2()
		local var_7_0 = arg_6_0

		if var_0.IsSelectMode(var_7_0) and arg_6_0.selectedId then
			local var_7_1 = arg_6_0.selectedId
			local var_7_2 = arg_6_0

			if var_1.IsEmptySlot(var_7_2) then
				local var_7_3 = arg_6_0
				local var_7_4 = var_1.emit

				IslandMediator = var_2_10004

				var_7_4(var_7_3, var_2_10004.EXCHANGE_SHIP_ORDER, arg_6_0.slotId, var_7_1)

				goto label_7_0
			end

			local var_7_5 = arg_6_0

			if var_1.IsAnyLoadUp(var_7_5) then
				local var_7_6 = arg_6_0

				if not var_1.CanExchange(var_7_6) then
					pg = var_1

					local var_7_7 = var_1.TipsMgr.GetInstance()
					local var_7_8 = var_1.ShowTip

					i18n = var_2_10004

					var_7_8(var_7_7, var_2_10004("island_order_ship_exchange_tip_2"))

					goto label_7_0
				end
			end

			local var_7_9 = arg_6_0

			if var_1.IsAnyLoadUp(var_7_9) then
				i18n = var_7_10

				do
					local var_7_10

					if not var_7_10("island_order_ship_exchange_tip_1") then
						i18n = var_7_10
						var_7_10 = var_7_10("island_order_ship_exchange_tip")
					end

					local var_7_11 = arg_6_0

					var_2.ShowMsgBox(var_7_11, {
						content = var_7_10,
						onYes = function()
							local var_8_0 = arg_6_0
							local var_8_1 = var_0.emit

							IslandMediator = var_3_10003

							var_8_1(var_8_0, var_3_10003.EXCHANGE_SHIP_ORDER, arg_6_0.slotId, var_7_1)

							return
						end
					})
				end

				::label_7_0::

				local var_7_12 = arg_6_0

				var_0.Hide(var_7_12)

				return
			end
		end
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10006)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.cancelBtn

	local function var_6_5()
		local var_9_0 = arg_6_0

		var_0.Hide(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10006)

	onButton = var_1_10001

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0._tf

	local function var_6_8()
		local var_10_0 = arg_6_0

		var_0.Hide(var_10_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10006)

	onButton = var_1_10001

	local var_6_9 = arg_6_0
	local var_6_10 = arg_6_0.refreshBtn

	local function var_6_11()
		local var_11_0 = arg_6_0
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		i18n = var_2_10004
		var_11_2.content = var_2_10004("island_order_ship_reset_all")

		function var_11_2.onYes()
			local var_12_0 = arg_6_0
			local var_12_1 = var_0.emit

			IslandMediator = var_3_10003

			var_12_1(var_12_0, var_3_10003.RESET_SHIP_ORDER)

			return
		end

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_9, var_6_10, var_6_11, var_1_10006)

	onButton = var_1_10001

	local var_6_12 = arg_6_0
	local var_6_13 = arg_6_0.speedUpBtn

	local function var_6_14()
		local var_13_0 = arg_6_0
		local var_13_1 = var_0.OpenPage

		IslandTicketUsePage = var_2_10003
		IslandUseTicketCommand = var_2_10004

		var_13_1(var_13_0, var_2_10003, var_2_10004.TYPES.SHIP_ORDER_RELOAD, 0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_12, var_6_13, var_6_14, var_1_10006)
	arg_6_0:InitToggles()

	return
end

function var_0_1.AddListeners(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.AddListener

	GAME = var_1_10004

	var_14_1(var_14_0, var_1_10004.ISLAND_RESET_SHIP_ORDER_DONE, arg_14_0.OnResetShipOrderList)

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.AddListener

	GAME = var_4

	var_14_3(var_14_2, var_4.ISLAND_USE_TICKET_DONE, arg_14_0.OnUseTicketDone)

	return
end

function var_0_1.RemoveListeners(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.RemoveListener

	GAME = var_1_10004

	var_15_1(var_15_0, var_1_10004.ISLAND_RESET_SHIP_ORDER_DONE, arg_15_0.OnResetShipOrderList)

	local var_15_2 = arg_15_0
	local var_15_3 = arg_15_0.RemoveListener

	GAME = var_4

	var_15_3(var_15_2, var_4.ISLAND_USE_TICKET_DONE, arg_15_0.OnUseTicketDone)

	return
end

function var_0_1.OnUseTicketDone(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.type

	IslandUseTicketCommand = var_1_10003

	if var_16_0 == var_1_10003.TYPES.SHIP_ORDER_RELOAD then
		arg_16_0:FlushRefreshBtn()
	end

	return
end

function var_0_1.OnResetShipOrderList(arg_17_0)
	arg_17_0:InitList()
	arg_17_0:FlushRefreshBtn()

	return
end

function var_0_1.OnShow(arg_18_0, arg_18_1)
	arg_18_0.slotId = arg_18_1

	arg_18_0:UpdateMode(arg_18_1)
	arg_18_0:FlushRefreshBtn()
	arg_18_0:InitList()
	arg_18_0:TriggerDefaultToggle()

	return
end

function var_0_1.IsSelectMode(arg_19_0)
	return arg_19_0.mode == var_0_3 and arg_19_0.slotId ~= nil
end

function var_0_1.UpdateMode(arg_20_0, arg_20_1)
	arg_20_0.mode = var_0_2

	if arg_20_1 then
		arg_20_0.mode = var_0_3
	end

	return
end

function var_0_1.GetDisplays(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = arg_21_0:GetIsland()
	local var_21_2 = var_2.GetOrderAgency(var_21_1)
	local var_21_3 = var_2.GetDelegateList(var_21_2)

	pairs = var_1_10003

	for iter_21_0, iter_21_1 in var_1_10003(var_21_3) do
		if iter_21_1:CanShow() then
			table = var_8

			var_8.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function var_0_1.InitList(arg_22_0)
	local var_22_0 = arg_22_0:GetDisplays()

	arg_22_0:RemoveNextAutoRefreshTimer()

	setActive = var_2

	var_2(arg_22_0.autoRefreshTimeTr, #var_22_0 <= 0)

	if #var_22_0 <= 0 then
		arg_22_0.selectedId = nil

		arg_22_0:AddNextAutoRefreshTimer()

		local var_22_1 = arg_22_0.uiItemList

		var_2.align(var_22_1, 0)

		return
	end

	local var_22_2 = arg_22_0.uiItemList

	var_2.make(var_22_2, function(arg_23_0, arg_23_1, arg_23_2)
		UIItemList = var_2_10003

		if arg_23_0 == var_2_10003.EventUpdate then
			local var_23_0 = arg_22_0

			var_3.UpdateItem(var_23_0, arg_23_2, var_22_0[arg_23_1 + 1])

			onToggle = var_3

			local var_23_1 = arg_22_0
			local var_23_2 = arg_23_2

			local function var_23_3(arg_24_0)
				if arg_24_0 then
					arg_22_0.selectedId = var_22_0[arg_23_1 + 1].id
				end

				return
			end

			SFX_PANEL = var_8

			var_3(var_23_1, var_23_2, var_23_3, var_8)

			if arg_23_1 == 0 then
				triggerToggle = var_3

				var_3(arg_23_2, true)
			end
		end

		return
	end)

	local var_22_3 = arg_22_0.uiItemList

	var_2.align(var_22_3, #var_22_0)

	return
end

function var_0_1.AddNextAutoRefreshTimer(arg_25_0)
	local var_25_0 = arg_25_0:GetIsland()
	local var_25_1 = var_1.GetOrderAgency(var_25_0)
	local var_25_2 = var_1.GetNextAutoReloadDelegateTime(var_25_1)

	Timer = var_1_10002
	arg_25_0.autoTimer = var_1_10002.New(function()
		pg = var_2_10000

		local var_26_0 = var_2_10000.TimeMgr.GetInstance()
		local var_26_1 = var_0.GetServerTime(var_26_0)

		if var_25_2 - var_26_1 < 0 then
			local var_26_2 = arg_25_0

			var_2.RemoveNextAutoRefreshTimer(var_26_2)

			arg_25_0.autoRefreshTimeTxt.text = ""

			local var_26_3 = arg_25_0

			if #var_2.GetDisplays(var_26_3) > 0 then
				local var_26_4 = arg_25_0

				var_2_10003.InitList(var_26_4)
			end
		else
			local var_26_5 = arg_25_0.autoRefreshTimeTxt

			pg = var_2_10003

			local var_26_6 = var_2_10003.TimeMgr.GetInstance()

			var_26_5.text = var_3.DescCDTime(var_26_6, var_1)
		end

		return
	end, 1, -1)

	local var_25_3 = arg_25_0.autoTimer

	var_2.Start(var_25_3)
	arg_25_0.autoTimer.func()

	return
end

function var_0_1.RemoveNextAutoRefreshTimer(arg_27_0)
	if arg_27_0.autoTimer then
		local var_27_0 = arg_27_0.autoTimer

		var_1.Stop(var_27_0)

		arg_27_0.autoTimer = nil
	end

	return
end

function var_0_1.UpdateItem(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2:GetRequestList()

	setText = var_1_10004

	var_1_10004(arg_28_1:Find("num"), "0" .. arg_28_2.id)

	UIItemList = var_1_10004

	local var_28_1 = var_1_10004.New(arg_28_1:Find("request"), arg_28_1:Find("request/tpl"))

	var_4.make(var_28_1, function(arg_29_0, arg_29_1, arg_29_2)
		UIItemList = var_2_10003

		if arg_29_0 == var_2_10003.EventUpdate then
			local var_29_0 = var_28_0[arg_29_1 + 1]

			Drop = var_4

			local var_29_1

			if not var_4.New(var_29_0).icon then
				var_2_10007 = var_4
				var_29_1 = var_4.getConfig(var_2_10007, "icon")
			end

			GetImageSpriteFromAtlasAsync = var_6

			var_6("island/" .. var_29_1, "", arg_29_2:Find("icon"))

			local var_29_2 = var_4:getOwnedCount()

			setText = var_2_10007

			local var_29_3 = arg_29_2:Find("cnt")

			setColorStr = var_10

			var_2_10007(var_29_3, var_10(var_29_2 .. "/" .. var_4.count, var_29_2 >= var_4.count and "#39beff" or "#f36c6e"))

			setActive = var_2_10007

			var_2_10007(arg_29_2:Find("mark"), var_29_2 >= var_4.count)
		end

		return
	end)
	var_4:align(#var_28_0)

	local var_28_2 = arg_28_2:GetAwardList()

	UIItemList = var_6

	local var_28_3 = var_6.New(arg_28_1:Find("award"), arg_28_1:Find("award/tpl"))

	var_6.make(var_28_3, function(arg_30_0, arg_30_1, arg_30_2)
		UIItemList = var_2_10003

		if arg_30_0 == var_2_10003.EventUpdate then
			local var_30_0 = var_28_2[arg_30_1 + 1]

			Drop = var_4

			local var_30_1 = var_4.New(var_30_0)

			updateCustomDrop = var_2_10005

			local var_30_2 = arg_30_2

			Drop = var_2_10008

			var_2_10005(var_30_2, var_2_10008.New(var_30_0))
		end

		return
	end)
	var_6:align(#var_28_2)

	return
end

function var_0_1.FlushRefreshBtn(arg_31_0)
	local var_31_0 = arg_31_0:GetIsland()
	local var_31_1 = var_1.GetOrderAgency(var_31_0)
	local var_31_2, var_31_3 = var_1.CanRefreshShipOrderDelegate(var_31_1)

	setGray = var_31_1

	var_31_1(arg_31_0.refreshBtn, not var_31_2, true)

	setButtonEnabled = var_31_1

	var_31_1(arg_31_0.refreshBtn, var_31_2)

	setActive = var_31_1

	var_31_1(arg_31_0.refreshTimeTxt.gameObject.transform.parent, not var_31_2)
	arg_31_0:RemoveRefreshTimer()

	if not var_31_2 then
		arg_31_0:AddRefreshTimer(var_31_3)
	end

	return
end

function var_0_1.AddRefreshTimer(arg_32_0, arg_32_1)
	Timer = var_1_10002
	arg_32_0.timer = var_1_10002.New(function()
		pg = var_2_10000

		local var_33_0 = var_2_10000.TimeMgr.GetInstance()
		local var_33_1 = var_0.GetServerTime(var_33_0)

		if arg_32_1 - var_33_1 < 0 then
			local var_33_2 = arg_32_0

			var_2.RemoveRefreshTimer(var_33_2)

			arg_32_0.refreshTimeTxt.text = ""

			local var_33_3 = arg_32_0

			var_2.FlushRefreshBtn(var_33_3)
		else
			local var_33_4 = arg_32_0.refreshTimeTxt

			pg = var_2_10003

			local var_33_5 = var_2_10003.TimeMgr.GetInstance()

			var_33_4.text = var_3.DescCDTime(var_33_5, var_1)
		end

		return
	end, 1, -1)

	local var_32_0 = arg_32_0.timer

	var_2.Start(var_32_0)
	arg_32_0.timer.func()

	return
end

function var_0_1.RemoveRefreshTimer(arg_34_0)
	if arg_34_0.timer then
		local var_34_0 = arg_34_0.timer

		var_1.Stop(var_34_0)

		arg_34_0.timer = nil
	end

	return
end

function var_0_1.InitToggles(arg_35_0)
	pairs = var_1_10001

	for iter_35_0, iter_35_1 in var_1_10001(arg_35_0.toggles) do
		onToggle = var_1_10006

		local var_35_0 = arg_35_0
		local var_35_1 = iter_35_1

		local function var_35_2(arg_36_0)
			local var_36_0 = arg_35_0

			var_1.SwitchPage(var_36_0, iter_35_0)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_35_0, var_35_1, var_35_2, var_1_10011)
	end

	return
end

function var_0_1.SwitchPage(arg_37_0, arg_37_1)
	arg_37_0.pageIndex = arg_37_1
	pairs = var_1_10002

	for iter_37_0, iter_37_1 in var_1_10002(arg_37_0.toggles) do
		local var_37_0 = iter_37_0 == arg_37_1 and "#F9B64B" or "#707172"

		setColorStr = var_1_10008
		var_1_10008 = var_1_10008(arg_37_0.toggleLabels[iter_37_0], var_37_0)
		setText = var_1_10009

		var_1_10009(iter_37_1:Find("Text"), var_1_10008)
	end

	local var_37_1 = arg_37_0.uiItemList

	var_2.each(var_37_1, function(arg_38_0, arg_38_1)
		setActive = var_2_10002

		var_2_10002(arg_38_1:Find("request"), arg_37_1 == var_0_4)

		setActive = var_2_10002

		var_2_10002(arg_38_1:Find("award"), arg_37_1 == var_0_5)

		return
	end)

	return
end

function var_0_1.TriggerDefaultToggle(arg_39_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_39_0.toggles[var_0_4], true)

	return
end

function var_0_1.RemoveTimers(arg_40_0)
	arg_40_0:RemoveRefreshTimer()
	arg_40_0:RemoveNextAutoRefreshTimer()

	return
end

function var_0_1.OnHide(arg_41_0)
	arg_41_0:RemoveTimers()

	arg_41_0.selectedId = nil

	return
end

function var_0_1.OnExit(arg_42_0)
	arg_42_0:RemoveTimers()

	arg_42_0.selectedId = nil

	return
end

return var_0_1
