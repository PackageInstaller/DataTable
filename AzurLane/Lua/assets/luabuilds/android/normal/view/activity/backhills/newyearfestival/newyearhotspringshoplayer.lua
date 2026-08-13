class = var_0_10000

local var_0_0 = "NewYearHotSpringShopLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewYearHotSpringShopUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.goodsContainer = var_1.Find(var_2_0, "Box/Container/Goods")

	local var_2_1 = arg_2_0._tf

	arg_2_0.chat = var_1.Find(var_2_1, "Box/Bubble")
	GetComponent = var_1

	local var_2_2 = arg_2_0.chat

	typeof = var_3
	Animator = var_1_10004
	arg_2_0.chatAnimator = var_1(var_2_2, var_3(var_1_10004))
	GetComponent = var_1

	local var_2_3 = arg_2_0.chat

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.chatAnimEvent = var_1(var_2_3, var_3(var_1_10004))

	local var_2_4 = arg_2_0.chat

	arg_2_0.chatText = var_1.Find(var_2_4, "BubbleText")

	local var_2_5 = arg_2_0.chat

	arg_2_0.chatClick = var_1.Find(var_2_5, "BubbleClick")
	setActive = var_1

	var_1(arg_2_0.chat, false)

	setLocalScale = var_1

	var_1(arg_2_0.chat, {
		x = 0,
		y = 0
	})

	setActive = var_1

	var_1(arg_2_0.chat, true)

	local var_2_6 = arg_2_0._tf

	arg_2_0.msgbox = var_1.Find(var_2_6, "Msgbox")
	setActive = var_1

	var_1(arg_2_0.msgbox, false)

	local var_2_7 = arg_2_0.msgbox
	local var_2_8 = var_1.Find(var_2_7, "window/msg_panel/content")

	arg_2_0.contentText = var_1.GetComponent(var_2_8, "RichText")

	return
end

function var_0_1.SetShop(arg_3_0, arg_3_1)
	arg_3_0.shop = arg_3_1

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "Top/Back")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SOUND_BACK = var_5

	var_1_10001(var_4_0, var_4_2, var_4_3, var_5)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_3.Find(var_4_5, "Top/Help")

	local function var_4_7()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.hotspring_shop_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_4, var_4_6, var_4_7, var_5)

	onButton = var_1_10001

	local var_4_8 = arg_4_0
	local var_4_9 = arg_4_0.msgbox

	var_1_10001(var_4_8, var_3.Find(var_4_9, "BG"), function()
		setActive = var_2_10000

		var_2_10000(arg_4_0.msgbox, false)

		return
	end)

	onButton = var_1_10001

	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0.msgbox
	local var_4_12 = var_3.Find(var_4_11, "window/button_container/Button1")

	local function var_4_13()
		setActive = var_2_10000

		var_2_10000(arg_4_0.msgbox, false)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_4_10, var_4_12, var_4_13, var_5)

	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0.chatClick, function()
		local var_9_0 = arg_4_0

		var_0.HideChat(var_9_0)

		return
	end)

	onButton = var_1_10001

	local var_4_14 = arg_4_0
	local var_4_15 = arg_4_0._tf

	var_1_10001(var_4_14, var_3.Find(var_4_15, "Box/Spine"), function()
		local var_10_0 = arg_4_0

		var_0.DisplayChat(var_10_0, {
			"hotspring_shop_touch1",
			"hotspring_shop_touch2",
			"hotspring_shop_touch3"
		})

		local var_10_1 = arg_4_0.role

		var_0.SetActionOnce(var_10_1, "touch")

		return
	end)
	arg_4_0:ShowEnterMsg()

	SpineRole = var_1
	arg_4_0.role = var_1.New()

	local var_4_16 = arg_4_0.role

	var_1.SetData(var_4_16, "mingshi_2")
	arg_4_0:LoadingOn()

	local var_4_17 = arg_4_0.role

	var_1.Load(var_4_17, function()
		local var_11_0 = arg_4_0.role
		local var_11_1 = var_0.SetParent
		local var_11_2 = arg_4_0._tf

		var_11_1(var_11_0, var_2.Find(var_11_2, "Box/Spine"))

		local var_11_3 = arg_4_0.role

		var_0.SetAction(var_11_3, "stand")

		local var_11_4 = arg_4_0.role

		var_0.SetActionCallBack(var_11_4, function(arg_12_0)
			if arg_12_0 == "finish" then
				local var_12_0 = arg_4_0.role

				var_1.SetAction(var_12_0, "stand")
			end

			return
		end)

		local var_11_5 = arg_4_0

		var_0.LoadingOff(var_11_5)

		return
	end, true)
	arg_4_0:UpdateView()

	pg = var_1

	local var_4_18 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_18, arg_4_0._tf)

	return
end

function var_0_1.ShowEnterMsg(arg_13_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_13_0 = var_1_10001(var_1_10002)
	local var_13_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if var_13_1(var_13_0, var_1_10003.ACTIVITY_TYPE_HOTSPRING) then
		local var_13_2 = var_1

		if var_1.isEnd(var_13_2) then
			var_13_2 = arg_13_0

			arg_13_0.DisplayChat(var_13_2, {
				"hotspring_shop_end"
			})

			return
		end

		_ = var_13_0

		local var_13_3 = var_13_0.all

		_ = var_13_2

		if var_13_3(var_13_2.values(arg_13_0.shop.goods), function(arg_14_0)
			return not arg_14_0:canPurchase()
		end) then
			arg_13_0:DisplayChat({
				"hotspring_shop_finish"
			})

			return
		end

		arg_13_0:DisplayChat({
			"hotspring_shop_enter1",
			"hotspring_shop_enter2"
		})

		return
	end
end

function var_0_1.UpdateView(arg_15_0)
	local var_15_0 = arg_15_0.shop
	local var_15_1 = var_1.getResId(var_15_0)

	getProxy = var_15_0
	PlayerProxy = var_1_10003

	local var_15_2 = var_15_0(var_1_10003)
	local var_15_3 = var_2.getRawData(var_15_2)

	id2res = var_15_2

	local var_15_4

	if not var_15_3[var_15_2(var_15_1)] then
		var_15_4 = 0
	end

	setText = var_4

	local var_15_5 = arg_15_0._tf

	var_4(var_5.Find(var_15_5, "Top/Ticket/TicketText"), var_15_4)
	arg_15_0:UpdateGoods()

	return
end

function var_0_1.UpdateGoods(arg_16_0)
	_ = var_1_10001

	local var_16_0 = var_1_10001.values(arg_16_0.shop.goods)

	table = var_2

	var_2.sort(var_16_0, function(arg_17_0, arg_17_1)
		return arg_17_0.id < arg_17_1.id
	end)

	UIItemList = var_2

	local var_16_1 = var_2.StaticAlign
	local var_16_2 = arg_16_0.goodsContainer
	local var_16_3 = arg_16_0.goodsContainer

	var_16_1(var_16_2, var_4.GetChild(var_16_3, 0), #var_16_0, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_18_0 = var_16_0[arg_18_1 + 1]
		local var_18_1 = var_3.canPurchase(var_18_0)

		setActive = var_18_0

		var_18_0(arg_18_2:Find("mask"), not var_18_1)

		local var_18_2 = var_3:getConfig("commodity_type")
		local var_18_3 = var_3:getConfig("commodity_id")
		local var_18_4 = {
			type = var_18_2,
			id = var_18_3,
			count = var_3:getConfig("num")
		}

		updateDrop = var_8

		var_8(arg_18_2:Find("Icon"), var_18_4)

		onButton = var_8

		local var_18_5 = arg_16_0
		local var_18_6 = arg_18_2

		local function var_18_7()
			local var_19_0 = arg_16_0

			var_0.OnClickCommodity(var_19_0, var_0, function(arg_20_0, arg_20_1)
				local var_20_0 = arg_16_0

				var_2.OnPurchase(var_20_0, var_0, arg_20_1)

				return
			end)

			return
		end

		SFX_PANEL = var_2_10012

		var_8(var_18_5, var_18_6, var_18_7, var_2_10012)

		return
	end)

	return
end

function var_0_1.CheckRes(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_1:canPurchase() then
		arg_21_0:DisplayChat({
			"hotspring_shop_exchanged"
		})

		return false
	end

	Drop = var_3

	local var_21_0 = var_3.New({
		type = arg_21_1:getConfig("resource_category"),
		id = arg_21_1:getConfig("resource_type")
	})

	if var_3.getOwnedCount(var_21_0) < arg_21_1:getConfig("resource_num") * arg_21_2 then
		arg_21_0:DisplayChat({
			"hotspring_shop_insufficient"
		})

		return false
	end

	return true
end

function var_0_1.Purchase(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.ShowMsgbox
	local var_22_2 = {}

	i18n = var_1_10008
	var_22_2.content = var_1_10008("hotspring_shop_exchange", arg_22_1:getConfig("resource_num") * arg_22_2, arg_22_1:getConfig("num") * arg_22_2, arg_22_3)

	function var_22_2.onYes()
		local var_23_0 = arg_22_0

		if var_0.CheckRes(var_23_0, arg_22_1, arg_22_2) then
			arg_22_4(arg_22_1, arg_22_2)
		end

		return
	end

	var_22_1(var_22_0, var_22_2)

	return
end

function var_0_1.OnClickCommodity(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_0:CheckRes(arg_24_1, 1) then
		return
	end

	Drop = var_3

	local var_24_0 = var_3.New({
		id = arg_24_1:getConfig("commodity_id"),
		type = arg_24_1:getConfig("commodity_type")
	})

	arg_24_0:Purchase(arg_24_1, 1, var_24_0:getConfig("name"), arg_24_2)

	return
end

function var_0_1.OnPurchase(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.shop.activityId
	local var_25_1 = arg_25_0
	local var_25_2 = arg_25_0.emit

	NewYearHotSpringShopMediator = var_1_10006

	var_25_2(var_25_1, var_1_10006.ON_ACT_SHOPPING, var_25_0, 1, arg_25_1.id, arg_25_2)

	return
end

function var_0_1.OnShoppingDone(arg_26_0)
	arg_26_0:DisplayChat({
		"hotspring_shop_success1",
		"hotspring_shop_success2"
	})

	return
end

function var_0_1.ShowMsgbox(arg_27_0, arg_27_1)
	setActive = var_1_10002

	var_1_10002(arg_27_0.msgbox, true)

	arg_27_0.contentText.text = arg_27_1.content

	local var_27_0 = arg_27_0.msgbox
	local var_27_1 = var_2.Find(var_27_0, "window/button_container/Button2")

	onButton = var_27_0

	local var_27_2 = arg_27_0
	local var_27_3 = var_27_1

	local function var_27_4()
		setActive = var_2_10000

		var_2_10000(arg_27_0.msgbox, false)

		existCall = var_2_10000

		var_2_10000(arg_27_1.onYes)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_27_0(var_27_2, var_27_3, var_27_4, var_1_10007)

	return
end

function var_0_1.DisplayChat(arg_29_0, arg_29_1)
	arg_29_0:HideChat()

	onNextTick = var_2

	var_2(function()
		LeanTween = var_2_10000

		local var_30_0 = var_2_10000.delayedCall

		go = var_2_10001

		local var_30_1 = var_2_10001(arg_29_0.chat)
		local var_30_2 = 10

		System = var_2_10003

		local var_30_3 = var_30_0(var_30_1, var_30_2, var_2_10003.Action(function()
			local var_31_0 = arg_29_0

			var_0.HideChat(var_31_0)

			return
		end))

		arg_29_0.chatTween = var_30_3.uniqueId

		local var_30_4 = arg_29_1

		math = var_2

		local var_30_5 = var_30_4[var_2.random(#arg_29_1)]

		i18n = var_2

		local var_30_6 = var_2(var_30_5)
		local var_30_7 = arg_29_0.chatAnimator

		var_3.ResetTrigger(var_30_7, "Shrink")

		local var_30_8 = arg_29_0.chatAnimator

		var_3.SetTrigger(var_30_8, "Pop")

		local var_30_9 = arg_29_0.chatAnimEvent

		var_3.SetTriggerEvent(var_30_9, function()
			setText = var_3_10000

			var_3_10000(arg_29_0.chatText, var_30_6)

			return
		end)

		return
	end)

	return
end

function var_0_1.HideChat(arg_33_0)
	if arg_33_0.chatTween then
		local var_33_0 = arg_33_0.chatAnimator

		var_1.ResetTrigger(var_33_0, "Pop")

		local var_33_1 = arg_33_0.chatAnimator

		var_1.SetTrigger(var_33_1, "Shrink")

		local var_33_2 = arg_33_0.chatAnimEvent

		var_1.SetTriggerEvent(var_33_2, nil)

		LeanTween = var_1

		var_1.cancel(arg_33_0.chatTween)

		arg_33_0.chatTween = nil
	end

	return
end

function var_0_1.LoadingOn(arg_34_0)
	if arg_34_0.animating then
		return
	end

	arg_34_0.animating = true
	pg = var_1

	local var_34_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_34_0, false)

	return
end

function var_0_1.LoadingOff(arg_35_0)
	if not arg_35_0.animating then
		return
	end

	pg = var_1

	local var_35_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOff(var_35_0)

	arg_35_0.animating = false

	return
end

function var_0_1.willExit(arg_36_0)
	pg = var_1_10001

	local var_36_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_36_0, arg_36_0._tf)
	arg_36_0:HideChat()

	local var_36_1 = arg_36_0.role

	var_1.Dispose(var_36_1)
	arg_36_0:LoadingOff()

	return
end

return var_0_1
