class = var_0_10000

local var_0_0 = "IslandOrderDescPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandOrderDescUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.infoPanel = var_1.Find(var_2_0, "info")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "info/name/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_3(var_2_2, var_3(var_1_10004))
	UIItemList = var_1

	local var_2_4 = var_1.New
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_2.Find(var_2_5, "info/subtitle_item/list")
	local var_2_7 = arg_2_0._tf

	arg_2_0.consumeUIList = var_2_4(var_2_6, var_3.Find(var_2_7, "info/subtitle_item/list/tpl"))
	UIItemList = var_1

	local var_2_8 = var_1.New
	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_2.Find(var_2_9, "info/subtitle_reward/list")
	local var_2_11 = arg_2_0._tf

	arg_2_0.awardUIList = var_2_8(var_2_10, var_3.Find(var_2_11, "info/subtitle_reward/list/tpl"))

	local var_2_12 = arg_2_0._tf

	arg_2_0.submitBtn = var_1.Find(var_2_12, "info/btns/submit")

	local var_2_13 = arg_2_0._tf

	arg_2_0.submitBtnMark = var_1.Find(var_2_13, "info/btns/submit/mask")

	local var_2_14 = arg_2_0._tf

	arg_2_0.replaceBtn = var_1.Find(var_2_14, "info/btns/cancel")

	local var_2_15 = arg_2_0._tf

	arg_2_0.speedUpBtn = var_1.Find(var_2_15, "loading/submit")

	local var_2_16 = arg_2_0._tf

	arg_2_0.loadingPanel = var_1.Find(var_2_16, "loading")

	local var_2_17 = arg_2_0.loadingPanel
	local var_2_18 = var_1.Find(var_2_17, "Text/time")
	local var_2_19 = var_1.GetComponent

	typeof = var_3
	Text = var_2_11
	arg_2_0.loadingTimeTxt = var_2_19(var_2_18, var_3(var_2_11))
	setText = var_1

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_2.Find(var_2_20, "info/btns/cancel/Text")

	i18n = var_2_20

	var_1(var_2_21, var_2_20("island_word_turndown"))

	setText = var_1

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_2.Find(var_2_22, "info/btns/submit/Text")

	i18n = var_2_22

	var_1(var_2_23, var_2_22("island_word_sbumit"))

	setText = var_1

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_2.Find(var_2_24, "loading/Text")

	i18n = var_2_24

	var_1(var_2_25, var_2_24("island_order_cd_tip"))

	setText = var_1

	local var_2_26 = arg_2_0._tf
	local var_2_27 = var_2.Find(var_2_26, "loading/submit/Text")

	i18n = var_2_26

	var_1(var_2_27, var_2_26("island_word_speedup"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.replaceBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		IslandMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.ON_REPLACE_ORDER, arg_3_0.slot.id)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.submitBtn

	local function var_3_5()
		getProxy = var_2_10000
		IslandProxy = var_2_10001

		local var_5_0 = var_2_10000(var_2_10001)
		local var_5_1 = var_0.GetIsland(var_5_0)
		local var_5_2 = var_0.GetOrderAgency(var_5_1)
		local var_5_3, var_5_4 = var_0.CanSubmitOrder(var_5_2)

		if not var_5_3 then
			pg = var_2_10003

			local var_5_5 = var_2_10003.TimeMgr.GetInstance()
			local var_5_6 = var_3.GetServerTime(var_5_5)

			pg = var_5_5
			var_2_10005 = var_5_5.TimeMgr.GetInstance()

			local var_5_7 = var_4.DescCDTime(var_2_10005, var_5_4 - var_5_6)

			pg = var_2_10005

			local var_5_8 = var_2_10005.TipsMgr.GetInstance()

			var_2_10005 = var_2_10005.ShowTips
			i18n = var_2_10007

			var_2_10005(var_5_8, var_2_10007("island_submit_order_cd_tip", var_5_7))

			return
		end

		local var_5_9 = arg_3_0
		local var_5_10 = var_3.emit

		IslandMediator = var_2_10005

		var_5_10(var_5_9, var_2_10005.ON_SUBMIT_ORDER, arg_3_0.slot.id)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.speedUpBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.OpenPage

		IslandTicketUsePage = var_2_10002
		IslandUseTicketCommand = var_2_10003

		var_6_1(var_6_0, var_2_10002, var_2_10003.TYPES.ORDER_CD, arg_3_0.slot.id)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.AddListeners(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.AddListener

	GAME = var_1_10003

	var_7_1(var_7_0, var_1_10003.ISLAND_SUBMIT_ORDER_DONE, arg_7_0.OnSubmitOrder)

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.AddListener

	GAME = var_3

	var_7_3(var_7_2, var_3.ISLAND_REPLACE_ORDER_DONE, arg_7_0.OnReplaceOrder)

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.AddListener

	IslandOrderAgency = var_3

	var_7_5(var_7_4, var_3.GEN_NEW_ORDER, arg_7_0.OnGenNewOrder)

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.AddListener

	IslandOrderAgency = var_3

	var_7_7(var_7_6, var_3.UDPATE_ORDER, arg_7_0.OnFlushOrder)

	local var_7_8 = arg_7_0
	local var_7_9 = arg_7_0.AddListener

	GAME = var_3

	var_7_9(var_7_8, var_3.ISLAND_USE_TICKET_DONE, arg_7_0.OnUseTicketDone)

	return
end

function var_0_1.RemoveListeners(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.RemoveListener

	GAME = var_1_10003

	var_8_1(var_8_0, var_1_10003.ISLAND_SUBMIT_ORDER_DONE, arg_8_0.OnSubmitOrder)

	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_0.RemoveListener

	GAME = var_3

	var_8_3(var_8_2, var_3.ISLAND_REPLACE_ORDER_DONE, arg_8_0.OnReplaceOrder)

	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_0.RemoveListener

	IslandOrderAgency = var_3

	var_8_5(var_8_4, var_3.GEN_NEW_ORDER, arg_8_0.OnGenNewOrder)

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.RemoveListener

	IslandOrderAgency = var_3

	var_8_7(var_8_6, var_3.UDPATE_ORDER, arg_8_0.OnFlushOrder)

	local var_8_8 = arg_8_0
	local var_8_9 = arg_8_0.RemoveListener

	GAME = var_3

	var_8_9(var_8_8, var_3.ISLAND_USE_TICKET_DONE, arg_8_0.OnUseTicketDone)

	return
end

function var_0_1.OnSubmitOrder(arg_9_0, arg_9_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_9_0 = var_1_10002(var_1_10003)
	local var_9_1 = var_2.GetIsland(var_9_0)
	local var_9_2 = var_2.GetOrderAgency(var_9_1)
	local var_9_3 = var_2.GetSlot(var_9_2, arg_9_1.slotId)

	arg_9_0:Flush(var_9_3)

	return
end

function var_0_1.OnReplaceOrder(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_10_0 = var_1_10002(var_1_10003)
	local var_10_1 = var_2.GetIsland(var_10_0)
	local var_10_2 = var_2.GetOrderAgency(var_10_1)
	local var_10_3 = var_2.GetSlot(var_10_2, arg_10_1.slotId)

	arg_10_0:Flush(var_10_3)

	return
end

function var_0_1.OnFlushOrder(arg_11_0, arg_11_1)
	arg_11_0:TryFlushOrderInfo(arg_11_1.slotId)

	return
end

function var_0_1.OnUseTicketDone(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.type

	IslandUseTicketCommand = var_1_10003

	if var_12_0 == var_1_10003.TYPES.ORDER_CD then
		arg_12_0:TryFlushOrderInfo(arg_12_1.id)
	end

	return
end

function var_0_1.OnGenNewOrder(arg_13_0, arg_13_1)
	arg_13_0:TryFlushOrderInfo(arg_13_1.slotId)

	return
end

function var_0_1.TryFlushOrderInfo(arg_14_0, arg_14_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_14_0 = var_1_10002(var_1_10003)
	local var_14_1 = var_2.GetIsland(var_14_0)
	local var_14_2 = var_2.GetOrderAgency(var_14_1)
	local var_14_3 = var_2.GetSlot(var_14_2, arg_14_1)

	if not arg_14_0.slot then
		return
	end

	if arg_14_0.slot.id ~= var_14_3.id then
		return
	end

	arg_14_0:Flush(var_14_3)

	return
end

function var_0_1.Show(arg_15_0, arg_15_1)
	var_0_1.super.Show(arg_15_0)
	arg_15_0:Flush(arg_15_1)

	return
end

function var_0_1.Flush(arg_16_0, arg_16_1)
	arg_16_0.slot = arg_16_1

	if not arg_16_1 or arg_16_1:IsEmpty() then
		arg_16_0:Hide()

		return
	end

	local var_16_0 = arg_16_1
	local var_16_1 = arg_16_1.IsLoading(var_16_0)

	setActive = var_16_0

	var_16_0(arg_16_0.infoPanel, not var_16_1)

	setActive = var_16_0

	var_16_0(arg_16_0.loadingPanel, var_16_1)
	arg_16_0:RemoveSubmitCdTimer()
	arg_16_0:RemoveLoadingTimer()
	arg_16_0:RemoveDisappearTimer()

	if var_16_1 then
		arg_16_0:FlushLoadingPanel(arg_16_1)
	else
		arg_16_0:FlusInfoPanel(arg_16_1)
	end

	local var_16_2 = arg_16_1:GetOrder()

	if var_3.IsUrgency(var_16_2) then
		arg_16_0:AddDisappearTimer(arg_16_1)
	end

	return
end

function var_0_1.AddDisappearTimer(arg_17_0, arg_17_1)
	arg_17_0:RemoveDisappearTimer()

	local var_17_0 = arg_17_1
	local var_17_1 = arg_17_1.GetDisappearTime(var_17_0)

	pg = var_17_0

	local var_17_2 = var_17_0.TimeMgr.GetInstance()

	if var_17_1 <= var_3.GetServerTime(var_17_2) then
		arg_17_0:Hide()

		return
	end

	Timer = var_3
	arg_17_0.disappearTimer = var_3.New(function()
		pg = var_2_10000

		local var_18_0 = var_2_10000.TimeMgr.GetInstance()
		local var_18_1 = var_0.GetServerTime(var_18_0)

		if var_17_1 - var_18_1 < 0 then
			local var_18_2 = arg_17_0

			var_2.Hide(var_18_2)
		end

		return
	end, 1, -1)

	arg_17_0.disappearTimer.func()

	local var_17_3 = arg_17_0.disappearTimer

	var_3.Start(var_17_3)

	return
end

function var_0_1.RemoveDisappearTimer(arg_19_0)
	if arg_19_0.disappearTimer then
		local var_19_0 = arg_19_0.disappearTimer

		var_1.Stop(var_19_0)

		arg_19_0.disappearTimer = nil
	end

	return
end

function var_0_1.FlushLoadingPanel(arg_20_0, arg_20_1)
	local function var_20_0()
		arg_20_0.loadingTimeTxt.text = ""

		local var_21_0 = arg_20_0

		var_0.Flush(var_21_0, arg_20_1)

		return
	end

	local var_20_1 = arg_20_1
	local var_20_2 = arg_20_1.GetCanSubmitTime(var_20_1)

	pg = var_20_1

	local var_20_3 = var_20_1.TimeMgr.GetInstance()

	if var_20_2 <= var_4.GetServerTime(var_20_3) then
		var_20_0()

		return
	end

	Timer = var_20_3
	arg_20_0.loadingTimer = var_20_3.New(function()
		pg = var_2_10000

		local var_22_0 = var_2_10000.TimeMgr.GetInstance()
		local var_22_1 = var_0.GetServerTime(var_22_0)
		local var_22_2 = var_20_2 - var_22_1
		local var_22_3 = arg_20_0.loadingTimeTxt

		pg = var_2_10003

		local var_22_4 = var_2_10003.TimeMgr.GetInstance()

		var_22_3.text = var_3.DescCDTime(var_22_4, var_22_2)

		if var_22_2 < 0 then
			local var_22_5 = arg_20_0

			var_2.RemoveLoadingTimer(var_22_5)
			var_20_0()
		end

		return
	end, 1, -1)

	local var_20_4 = arg_20_0.loadingTimer

	var_5.Start(var_20_4)
	arg_20_0.loadingTimer.func()

	return
end

function var_0_1.RemoveLoadingTimer(arg_23_0)
	if arg_23_0.loadingTimer then
		local var_23_0 = arg_23_0.loadingTimer

		var_1.Stop(var_23_0)

		arg_23_0.loadingTimer = nil
	end

	return
end

function var_0_1.FlusInfoPanel(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1:GetOrder()

	arg_24_0:FlushAwards(var_24_0)
	arg_24_0:FlushConsume(var_24_0)

	setActive = var_3

	local var_24_1 = arg_24_0.replaceBtn
	local var_24_2 = var_24_0

	var_3(var_24_1, not var_24_0.IsUrgency(var_24_2))

	local var_24_3 = arg_24_0.nameTxt

	var_24_3.text = var_24_0:GetRoleName()
	getProxy = var_24_3
	IslandProxy = var_4

	local var_24_4 = var_24_3(var_4)
	local var_24_5 = var_3.GetIsland(var_24_4)
	local var_24_6 = var_3.GetOrderAgency(var_24_5)
	local var_24_7, var_24_8 = var_3.CanSubmitOrder(var_24_6)

	setActive = var_24_2

	var_24_2(arg_24_0.submitBtnMark, not var_24_0:CanFinish())

	local var_24_9

	if var_24_7 then
		var_24_9 = arg_24_0

		arg_24_0.SetMaskFillAmount(var_24_9, arg_24_0.submitBtnMark, 1)

		return
	end

	pg = var_24_2

	local var_24_10 = var_24_2.island_set.order_complete_refresh_time.key_value_int

	Timer = var_24_9
	arg_24_0.submitTimer = var_24_9.New(function()
		pg = var_2_10000

		local var_25_0 = var_2_10000.TimeMgr.GetInstance()
		local var_25_1 = var_0.GetServerTime(var_25_0)
		local var_25_2 = (var_24_8 - var_25_1) / var_24_10
		local var_25_3 = arg_24_0

		var_2.SetMaskFillAmount(var_25_3, arg_24_0.submitBtnMark, 1 - var_25_2)

		if var_25_2 <= 0 then
			local var_25_4 = arg_24_0

			var_2.RemoveSubmitCdTimer(var_25_4)
		end

		return
	end, 1, -1)

	local var_24_11 = arg_24_0.submitTimer

	var_7.Start(var_24_11)
	arg_24_0.submitTimer.func()

	return
end

function var_0_1.SetMaskFillAmount(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_1
	local var_26_1 = arg_26_1.GetComponent

	typeof = var_1_10005
	RectMask2D = var_1_10006

	local var_26_2 = var_26_1(var_26_0, var_1_10005(var_1_10006))
	local var_26_3 = arg_26_1.sizeDelta.x * arg_26_2

	Vector4 = var_1_10006
	var_26_2.padding = var_1_10006(var_26_3, 0, 0, 0)

	return
end

function var_0_1.FlushAwards(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:GetDisplayAwards()
	local var_27_1 = arg_27_0.awardUIList

	var_3.make(var_27_1, function(arg_28_0, arg_28_1, arg_28_2)
		UIItemList = var_2_10003

		if arg_28_0 == var_2_10003.EventUpdate then
			local var_28_0 = var_27_0[arg_28_1 + 1]

			updateCustomDrop = var_4

			var_4(arg_28_2, var_28_0)

			onButton = var_4

			var_4(arg_27_0, arg_28_2, function()
				local var_29_0 = arg_27_0
				local var_29_1 = var_0.ShowMsgBox
				local var_29_2 = {}

				i18n = var_3_10003
				var_29_2.title = var_3_10003("island_word_desc")
				IslandMsgBox = var_3
				var_29_2.type = var_3.TYPE_COMMON_DROP_DESCRIBE
				var_29_2.dropData = var_28_0

				var_29_1(var_29_0, var_29_2)

				return
			end)
		end

		return
	end)

	local var_27_2 = arg_27_0.awardUIList

	var_3.align(var_27_2, #var_27_0)

	return
end

function var_0_1.FlushConsume(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1:GetConsume()
	local var_30_1 = arg_30_0.consumeUIList

	var_3.make(var_30_1, function(arg_31_0, arg_31_1, arg_31_2)
		UIItemList = var_2_10003

		if arg_31_0 == var_2_10003.EventUpdate then
			local var_31_0 = var_30_0[arg_31_1 + 1]
			local var_31_1 = {
				count = 0,
				type = var_31_0.type,
				id = var_31_0.id
			}

			updateCustomDrop = var_5

			var_5(arg_31_2:Find("tpl"), var_31_1)

			onButton = var_5

			var_5(arg_30_0, arg_31_2, function()
				local var_32_0 = arg_30_0
				local var_32_1 = var_0.ShowMsgBox
				local var_32_2 = {}

				i18n = var_3_10003
				var_32_2.title = var_3_10003("island_word_desc")
				IslandMsgBox = var_3
				var_32_2.type = var_3.TYPE_COMMON_DROP_DESCRIBE
				var_32_2.dropData = var_31_1

				var_32_1(var_32_0, var_32_2)

				return
			end)

			setText = var_5

			var_5(arg_31_2:Find("Text"), var_31_1.cfg.name)

			Drop = var_5

			local var_31_2 = var_5.New({
				type = var_31_1.type,
				id = var_31_1.id
			})

			if var_5.getOwnedCount(var_31_2) >= var_31_0.count then
				setText = var_7

				var_7(arg_31_2:Find("count"), var_5 .. "/" .. var_31_0.count)
			else
				setText = var_7

				local var_31_3 = arg_31_2
				local var_31_4 = arg_31_2.Find(var_31_3, "count")

				setColorStr = var_31_3

				local var_31_5 = var_5

				COLOR_RED = var_2_10011

				var_7(var_31_4, var_31_3(var_31_5, var_2_10011) .. "/" .. var_31_0.count)
			end

			setActive = var_7

			var_7(arg_31_2:Find("finish"), var_6)

			setActive = var_7

			var_7(arg_31_2:Find("line"), arg_31_1 + 1 ~= #var_30_0)
		end

		return
	end)

	local var_30_2 = arg_30_0.consumeUIList

	var_3.align(var_30_2, #var_30_0)

	return
end

function var_0_1.RemoveSubmitCdTimer(arg_33_0)
	if arg_33_0.submitTimer then
		local var_33_0 = arg_33_0.submitTimer

		var_1.Stop(var_33_0)

		arg_33_0.submitTimer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_34_0)
	arg_34_0:RemoveSubmitCdTimer()
	arg_34_0:RemoveLoadingTimer()
	arg_34_0:RemoveDisappearTimer()

	return
end

return var_0_1
