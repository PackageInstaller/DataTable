class = var_0_10000

local var_0_0 = "AmusementParkShopPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AmusementParkShopPage"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.goodsContainer = var_1.Find(var_2_0, "Box/Container/Goods")

	local var_2_1 = arg_2_0._tf

	arg_2_0.specialsContainer = var_1.Find(var_2_1, "Box/Container/SpecialList")

	local var_2_2 = arg_2_0._tf

	arg_2_0.specailsDecoration = var_1.Find(var_2_2, "Box/Container/Specials")

	local var_2_3 = arg_2_0._tf

	arg_2_0.specailsOtherDecoration = var_1.Find(var_2_3, "Box/Container/SpecialsOther")
	setActive = var_1

	var_1(arg_2_0.specailsOtherDecoration, false)

	local var_2_4 = arg_2_0._tf

	arg_2_0.chat = var_1.Find(var_2_4, "Box/Bubble")

	local var_2_5 = arg_2_0.chat

	arg_2_0.chatText = var_1.Find(var_2_5, "BubbleText")

	local var_2_6 = arg_2_0._tf

	arg_2_0.chatClick = var_1.Find(var_2_6, "Box/BubbleClick")
	arg_2_0.chatActive = false

	local var_2_7 = {}

	i18n = var_1_10002
	var_2_7[1] = var_1_10002("amusementpark_shop_carousel1")
	i18n = var_2
	var_2_7[2] = var_2("amusementpark_shop_carousel2")
	i18n = var_2
	var_2_7[3] = var_2("amusementpark_shop_carousel3")
	i18n = var_2
	var_2_7[4] = var_2("amusementpark_shop_0")
	arg_2_0.pollText = var_2_7
	math = var_2_7

	local var_2_8 = var_2_7.random
	local var_2_9 = 0

	math = var_4
	arg_2_0.pollIndex = var_2_8(var_2_9, var_4.max(0, #arg_2_0.pollText - 1))

	local var_2_10 = arg_2_0._tf

	arg_2_0.msgbox = var_1.Find(var_2_10, "Msgbox")
	setActive = var_1

	var_1(arg_2_0.msgbox, false)

	local var_2_11 = arg_2_0.msgbox
	local var_2_12 = var_1.Find(var_2_11, "window/msg_panel/content")

	arg_2_0.contentText = var_1.GetComponent(var_2_12, "RichText")

	return
end

function var_0_1.SetShop(arg_3_0, arg_3_1)
	arg_3_0.shop = arg_3_1

	return
end

function var_0_1.SetSpecial(arg_4_0, arg_4_1)
	arg_4_0.specialLists = arg_4_1

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_4.Find(var_5_1, "Top/Back")

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.closeView(var_6_0)

		return
	end

	SOUND_BACK = var_5_1

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5_1)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0._tf
	local var_5_6 = var_4.Find(var_5_5, "Top/Help")

	local function var_5_7()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.amusementpark_shop_help.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_5_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5_5)

	onButton = var_1_10001

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.msgbox

	var_1_10001(var_5_8, var_4.Find(var_5_9, "BG"), function()
		setActive = var_2_10000

		var_2_10000(arg_5_0.msgbox, false)

		return
	end)

	onButton = var_1_10001

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.msgbox
	local var_5_12 = var_4.Find(var_5_11, "window/button_container/Button1")

	local function var_5_13()
		setActive = var_2_10000

		var_2_10000(arg_5_0.msgbox, false)

		return
	end

	SFX_CANCEL = var_5_11

	var_1_10001(var_5_10, var_5_12, var_5_13, var_5_11)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.chatClick, function()
		local var_10_0 = arg_5_0

		var_0.SetActiveBubble(var_10_0, not arg_5_0.chatActive)

		return
	end)

	local var_5_14 = arg_5_0.shop
	local var_5_15 = var_1.getResId(var_5_14)

	Drop = var_1_10002

	local var_5_16 = var_1_10002.New
	local var_5_17 = {}

	DROP_TYPE_RESOURCE = var_5
	var_5_17.type = var_5
	var_5_17.id = var_5_15

	local var_5_18 = var_5_16(var_5_17)
	local var_5_19 = var_2.getIcon(var_5_18)
	local var_5_20 = arg_5_0.contentText
	local var_5_21 = var_3.AddSprite
	local var_5_22 = var_5_19

	LoadSprite = var_7

	var_5_21(var_5_20, var_5_22, var_7(var_5_19, ""))
	arg_5_0:UpdateView()
	arg_5_0:ShowEnterMsg()

	pg = var_3

	local var_5_23 = var_3.UIMgr.GetInstance()

	var_3.OverlayPanel(var_5_23, arg_5_0._tf)

	return
end

function var_0_1.ShowEnterMsg(arg_11_0)
	_ = var_1_10001

	local var_11_0 = var_1_10001.all

	_ = var_1_10003

	if var_11_0(var_1_10003.values(arg_11_0.shop.goods), function(arg_12_0)
		return not arg_12_0:canPurchase()
	end) then
		local var_11_1 = arg_11_0
		local var_11_2 = arg_11_0.ShowShipWord

		i18n = var_5

		var_11_2(var_11_1, var_5("amusementpark_shop_end"))

		return
	end

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.ShowShipWord

	i18n = var_5

	var_11_4(var_11_3, var_5("amusementpark_shop_enter"))

	return
end

function var_0_1.UpdateView(arg_13_0)
	local var_13_0 = arg_13_0.shop
	local var_13_1 = var_1.getResId(var_13_0)

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_13_2 = var_1_10002(var_1_10004)
	local var_13_3 = var_2.getRawData(var_13_2)

	id2res = var_13_0

	local var_13_4

	if not var_13_3[var_13_0(var_13_1)] then
		var_13_4 = 0
	end

	setText = var_13_2

	local var_13_5 = arg_13_0._tf

	var_13_2(var_6.Find(var_13_5, "Box/TicketText"), "X" .. var_13_4)
	arg_13_0:UpdateGoods()

	return
end

function var_0_1.UpdateGoods(arg_14_0)
	_ = var_1_10001

	local var_14_0 = var_1_10001.values(arg_14_0.shop.goods)

	table = var_1_10002

	var_1_10002.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0.id < arg_15_1.id
	end)

	UIItemList = var_2

	local var_14_1 = var_2.StaticAlign
	local var_14_2 = arg_14_0.goodsContainer
	local var_14_3 = arg_14_0.goodsContainer

	var_14_1(var_14_2, var_5.GetChild(var_14_3, 0), #var_14_0, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_16_0 = var_14_0[arg_16_1 + 1]
		local var_16_1 = var_3.canPurchase(var_16_0)

		setActive = var_2_10005

		var_2_10005(arg_16_2:Find("mask"), not var_16_1)

		local var_16_2 = var_3:getConfig("commodity_type")
		local var_16_3 = var_3:getConfig("commodity_id")
		local var_16_4 = {
			type = var_16_2,
			id = var_16_3,
			count = var_3:getConfig("num")
		}

		updateDrop = var_8

		var_8(arg_16_2, var_16_4)

		setText = var_8

		local var_16_5 = arg_16_2:Find("Price")
		local var_16_6 = var_3

		var_8(var_16_5, var_3.getConfig(var_16_6, "resource_num"))

		onButton = var_8

		local var_16_7 = arg_14_0
		local var_16_8 = arg_16_2

		local function var_16_9()
			local var_17_0 = arg_14_0

			var_0.OnClickCommodity(var_17_0, var_0, function(arg_18_0, arg_18_1)
				local var_18_0 = arg_14_0

				var_2.OnPurchase(var_18_0, var_0, arg_18_1)

				return
			end)

			return
		end

		SFX_PANEL = var_16_6

		var_8(var_16_7, var_16_8, var_16_9, var_16_6)

		return
	end)

	setActive = var_14_1

	var_14_1(arg_14_0.specailsDecoration, #arg_14_0.specialLists > 0)

	setActive = var_14_1

	var_14_1(arg_14_0.specailsOtherDecoration, #arg_14_0.specialLists <= 0)

	UIItemList = var_14_1

	local var_14_4 = var_14_1.StaticAlign
	local var_14_5 = arg_14_0.specialsContainer
	local var_14_6 = arg_14_0.specialsContainer

	var_14_4(var_14_5, var_5.GetChild(var_14_6, 0), 3, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_19_0 = arg_14_0.specialLists[arg_19_1 + 1]

		setActive = var_4

		var_4(arg_19_2, var_19_0)

		if not var_19_0 then
			return
		end

		setActive = var_4

		var_4(arg_19_2:Find("mask"), var_19_0.HasGot)

		onButton = var_4

		local var_19_1 = arg_14_0
		local var_19_2 = arg_19_2

		local function var_19_3()
			local var_20_0 = arg_14_0
			local var_20_1 = var_0.emit

			BaseUI = var_3_10003

			var_20_1(var_20_0, var_3_10003.ON_DROP, var_19_0)

			return
		end

		SFX_PANEL = var_9

		var_4(var_19_1, var_19_2, var_19_3, var_9)

		return
	end)

	return
end

function var_0_1.CheckRes(arg_21_0, arg_21_1, arg_21_2)
	local var_21_1

	if not arg_21_1:canPurchase() then
		pg = var_21_1

		local var_21_0 = var_21_1.TipsMgr.GetInstance()

		var_21_1 = var_21_1.ShowTips
		i18n = var_1_10006

		var_21_1(var_21_0, var_1_10006("buy_countLimit"))

		return false
	end

	Drop = var_21_1

	local var_21_2 = var_21_1.New({
		type = arg_21_1:getConfig("resource_category"),
		id = arg_21_1:getConfig("resource_type")
	})

	if var_3.getOwnedCount(var_21_2) < arg_21_1:getConfig("resource_num") * arg_21_2 then
		local var_21_3 = arg_21_0
		local var_21_4 = arg_21_0.ShowMsgbox
		local var_21_5 = {
			useGO = true
		}

		i18n = var_8
		var_21_5.content = var_8("amusementpark_shop_exchange")

		function var_21_5.onYes()
			local var_22_0 = arg_21_0
			local var_22_1 = var_0.emit

			AmusementParkShopMediator = var_2_10003

			local var_22_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_22_1(var_22_0, var_22_2, var_2_10004.TASK)

			return
		end

		var_21_4(var_21_3, var_21_5)

		return false
	end

	return true
end

function var_0_1.Purchase(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.ShowMsgbox
	local var_23_2 = {}

	i18n = var_1_10009
	var_23_2.content = var_1_10009("amusementpark_shop_exchange2", arg_23_1:getConfig("resource_num") * arg_23_2, arg_23_1:getConfig("num") * arg_23_2, arg_23_3)

	function var_23_2.onYes()
		local var_24_0 = arg_23_0

		if var_0.CheckRes(var_24_0, arg_23_1, arg_23_2) then
			arg_23_4(arg_23_1, arg_23_2)
		end

		return
	end

	var_23_1(var_23_0, var_23_2)

	return
end

function var_0_1.OnClickCommodity(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_0:CheckRes(arg_25_1, 1) then
		return
	end

	Drop = var_3

	local var_25_0 = var_3.New({
		id = arg_25_1:getConfig("commodity_id"),
		type = arg_25_1:getConfig("commodity_type")
	})

	arg_25_0:Purchase(arg_25_1, 1, var_25_0:getConfig("name"), arg_25_2)

	return
end

function var_0_1.OnPurchase(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0.shop.activityId
	local var_26_1 = arg_26_0
	local var_26_2 = arg_26_0.emit

	AmusementParkShopMediator = var_1_10007

	var_26_2(var_26_1, var_1_10007.ON_ACT_SHOPPING, var_26_0, 1, arg_26_1.id, arg_26_2)

	return
end

function var_0_1.ShowMsgbox(arg_27_0, arg_27_1)
	setActive = var_1_10002

	var_1_10002(arg_27_0.msgbox, true)

	arg_27_0.contentText.text = arg_27_1.content

	local var_27_0 = arg_27_0.msgbox
	local var_27_1 = var_2.Find(var_27_0, "window/button_container/Button2")
	local var_27_2 = arg_27_0.msgbox
	local var_27_3 = var_3.Find(var_27_2, "window/button_container/Button3")
	local var_27_4 = arg_27_1.useGO

	setActive = var_27_2

	var_27_2(var_27_1, not var_27_4)

	setActive = var_27_2

	var_27_2(var_27_3, var_27_4)

	local var_27_5 = var_27_4 and var_27_3 or var_27_1

	onButton = var_6

	local var_27_6 = arg_27_0
	local var_27_7 = var_27_5

	local function var_27_8()
		setActive = var_2_10000

		var_2_10000(arg_27_0.msgbox, false)

		existCall = var_2_10000

		var_2_10000(arg_27_1.onYes)

		return
	end

	SFX_CONFIRM = var_1_10011

	var_6(var_27_6, var_27_7, var_27_8, var_1_10011)

	return
end

function var_0_1.SetActiveBubble(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0.chatActive

	tobool = var_1_10004

	if var_29_0 == var_1_10004(arg_29_1) and not arg_29_2 then
		return
	end

	LeanTween = var_29_0

	local var_29_1 = var_29_0.cancel

	go = var_1_10005

	var_29_1(var_1_10005(arg_29_0.chat))

	local var_29_2 = 0.3

	tobool = var_4
	arg_29_0.chatActive = var_4(arg_29_1)

	local var_29_3

	if arg_29_1 then
		setActive = var_29_3

		var_29_3(arg_29_0.chat, true)

		LeanTween = var_29_3
		var_29_3 = var_29_3.scale

		local var_29_4 = arg_29_0.chat.gameObject

		Vector3 = var_7

		local var_29_5 = var_29_3(var_29_4, var_7.New(1, 1, 1), var_29_2)

		var_29_3 = var_29_3.setFrom
		Vector3 = var_7

		local var_29_6 = var_29_3(var_29_5, var_7.New(0, 0, 0))

		var_29_3 = var_29_3.setEase
		LeanTweenType = var_7

		var_29_3(var_29_6, var_7.easeOutBack)
	else
		setActive = var_29_3

		var_29_3(arg_29_0.chat, true)

		LeanTween = var_29_3

		local var_29_7 = var_29_3.scale
		local var_29_8 = arg_29_0.chat.gameObject

		Vector3 = var_7

		local var_29_9 = var_29_7(var_29_8, var_7.New(0, 0, 0), var_29_2)
		local var_29_10 = var_4.setFrom

		Vector3 = var_7

		local var_29_11 = var_29_10(var_29_9, var_7.New(1, 1, 1))
		local var_29_12 = var_4.setEase

		LeanTweenType = var_7

		local var_29_13 = var_29_12(var_29_11, var_7.easeOutBack)
		local var_29_14 = var_4.setOnComplete

		System = var_7

		var_29_14(var_29_13, var_7.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_29_0.chat, false)

			return
		end))
	end

	return
end

function var_0_1.ShowShipWord(arg_31_0, arg_31_1)
	arg_31_0:SetActiveBubble(true, true)

	setText = var_2

	var_2(arg_31_0.chatText, arg_31_1)
	arg_31_0:AddPollingChat()

	return
end

function var_0_1.AddPollingChat(arg_32_0)
	arg_32_0:StopPolling()

	Timer = var_1
	arg_32_0.pollTimer = var_1.New(function()
		local var_33_0 = arg_32_0.pollText[arg_32_0.pollIndex + 1]
		local var_33_1 = arg_32_0

		var_1.ShowShipWord(var_33_1, var_33_0)

		arg_32_0.pollIndex = (arg_32_0.pollIndex + 1) % #arg_32_0.pollText

		return
	end, 6)

	local var_32_0 = arg_32_0.pollTimer

	var_1.Start(var_32_0)

	return
end

function var_0_1.StopPolling(arg_34_0)
	if not arg_34_0.pollTimer then
		return
	end

	local var_34_0 = arg_34_0.pollTimer

	var_1.Stop(var_34_0)

	arg_34_0.pollTimer = nil

	return
end

function var_0_1.StopChat(arg_35_0)
	LeanTween = var_1_10001

	local var_35_0 = var_1_10001.isTweening

	go = var_1_10003

	local var_35_1

	if var_35_0(var_1_10003(arg_35_0.chat)) then
		LeanTween = var_35_1
		var_35_1 = var_35_1.cancel
		go = var_3

		var_35_1(var_3(arg_35_0.chat))
	end

	setActive = var_35_1

	var_35_1(arg_35_0.chat, false)

	return
end

function var_0_1.willExit(arg_36_0)
	pg = var_1_10001

	local var_36_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_36_0, arg_36_0._tf)
	arg_36_0:StopPolling()

	return
end

function var_0_1.GetActivityShopTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_37_0 = var_1_10000(var_1_10002)
	local var_37_1 = var_0.getActivityByType

	ActivityConst = var_1_10004

	if not var_37_1(var_37_0, var_1_10004.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD) or var_1:isEnd() then
		return
	end

	pg = var_1_10002

	local var_37_2 = var_1_10002.activity_shop_template

	ipairs = var_37_0

	for iter_37_0, iter_37_1 in var_37_0(var_37_2.all) do
		if var_1.id == var_37_2[iter_37_1].activity then
			table = var_8

			local var_37_3

			if not var_8.indexof(var_1.data1_list, iter_37_1) or not var_1.data2_list[var_8] then
				var_37_3 = 0
			end

			local var_37_4 = var_37_2[iter_37_1].num_limit == 0 or var_37_3 < var_10.num_limit

			Drop = var_1_10012

			local var_37_5 = var_1_10012.New({
				type = var_10.resource_category,
				id = var_10.resource_type
			})

			var_1_10012 = var_1_10012.getOwnedCount(var_37_5) >= var_10.resource_num

			if var_37_4 and var_1_10012 then
				return true
			end
		end
	end

	return false
end

return var_0_1
