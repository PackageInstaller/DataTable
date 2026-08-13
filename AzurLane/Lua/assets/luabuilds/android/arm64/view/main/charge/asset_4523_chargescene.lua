class = var_0_10000

local var_0_0 = "ChargeScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

var_0_1.TYPE_DIAMOND = 1
var_0_1.TYPE_GIFT = 2
var_0_1.TYPE_ITEM = 3
var_0_1.TYPE_PICK = 4

function var_0_1.getUIName(arg_1_0)
	return "ChargeShopUI"
end

function var_0_1.onBackPressed(arg_2_0)
	arg_2_0:closeView()

	return
end

function var_0_1.preload(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	ShopsProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)

	local function var_3_1()
		local var_4_0 = var_3_0
		local var_4_1 = var_0.getFirstChargeList(var_4_0)
		local var_4_2 = var_3_0
		local var_4_3 = var_1.getChargedList(var_4_2)
		local var_4_4 = var_3_0
		local var_4_5 = var_2.GetNormalList(var_4_4)
		local var_4_6 = var_3_0
		local var_4_7 = var_3.GetNormalGroupList(var_4_6)

		if var_4_1 then
			local var_4_8 = arg_3_0

			var_4.setFirstChargeIds(var_4_8, var_4_1)
		end

		if var_4_3 then
			local var_4_9 = arg_3_0

			var_4.setChargedList(var_4_9, var_4_3)
		end

		if var_4_5 then
			local var_4_10 = arg_3_0

			var_4.setNormalList(var_4_10, var_4_5)
		end

		if var_4_7 then
			local var_4_11 = arg_3_0

			var_4.setNormalGroupList(var_4_11, var_4_7)
		end

		arg_3_1()

		return
	end

	if var_3_0:ShouldRefreshChargeList() then
		pg = var_4

		local var_3_2 = var_4.m02
		local var_3_3 = var_4.sendNotification

		GAME = var_1_10007

		var_3_3(var_3_2, var_1_10007.GET_CHARGE_LIST, {
			callback = var_3_1
		})
	else
		var_3_1()
	end

	return
end

function var_0_1.setPlayer(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1

	return
end

function var_0_1.setFirstChargeIds(arg_6_0, arg_6_1)
	arg_6_0.firstChargeIds = arg_6_1

	return
end

function var_0_1.setChargedList(arg_7_0, arg_7_1)
	arg_7_0.chargedList = arg_7_1

	return
end

function var_0_1.setNormalList(arg_8_0, arg_8_1)
	arg_8_0.normalList = arg_8_1

	return
end

function var_0_1.setNormalGroupList(arg_9_0, arg_9_1)
	arg_9_0.normalGroupList = arg_9_1

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.addRefreshTimer

	GetZeroTime = var_1_10005

	var_9_1(var_9_0, var_1_10005())

	return
end

function var_0_1.ResUISettings(arg_10_0)
	return true
end

function var_0_1.init(arg_11_0)
	local var_11_0 = arg_11_0._tf

	arg_11_0.blurPanel = var_1.Find(var_11_0, "blur_panel")

	local var_11_1 = arg_11_0.blurPanel

	arg_11_0.top = var_1.Find(var_11_1, "adapt/top")

	local var_11_2 = arg_11_0._tf

	arg_11_0.frame = var_1.Find(var_11_2, "frame")

	local var_11_3 = arg_11_0._tf

	arg_11_0.viewContainer = var_1.Find(var_11_3, "viewContainer")

	local var_11_4 = arg_11_0._tf

	arg_11_0.bg = var_1.Find(var_11_4, "viewContainer/bg")

	local var_11_5 = arg_11_0._tf

	arg_11_0.painting = var_1.Find(var_11_5, "frame/painting")

	local var_11_6 = arg_11_0._tf

	arg_11_0.chat = var_1.Find(var_11_6, "viewContainer/chat")

	local var_11_7 = arg_11_0.chat

	arg_11_0.chatText = var_1.Find(var_11_7, "Text")

	local var_11_8 = arg_11_0._tf

	arg_11_0.switchBtn = var_1.Find(var_11_8, "blur_panel/adapt/switch_btn")

	local var_11_9 = arg_11_0._tf

	arg_11_0.skinShopBtn = var_1.Find(var_11_9, "blur_panel/adapt/skin_btn")
	LOCK_SKIN_SHOP_ENTER = var_11_11

	local var_11_11

	if var_11_11 then
		getProxy = var_11_11
		PlayerProxy = var_11_9

		local var_11_10 = var_11_11(var_11_9)

		var_11_11 = var_11_11.getData(var_11_10).level
		LOCK_SKIN_SHOP_ENTER_LEVEL = var_1_10002
		var_11_11 = var_11_11 < var_1_10002
	end

	setActive = var_1_10002

	var_1_10002(arg_11_0.skinShopBtn, not var_11_11)

	local var_11_12 = arg_11_0.viewContainer

	arg_11_0.itemToggle = var_2.Find(var_11_12, "toggle_list/item_toggle")

	local var_11_13 = arg_11_0.viewContainer

	arg_11_0.giftToggle = var_2.Find(var_11_13, "toggle_list/gift_toggle")

	local var_11_14 = arg_11_0.viewContainer

	arg_11_0.diamondToggle = var_2.Find(var_11_14, "toggle_list/diamond_toggle")

	local var_11_15 = arg_11_0.giftToggle

	arg_11_0.giftTip = var_2.Find(var_11_15, "tip")

	local var_11_16 = arg_11_0.viewContainer

	arg_11_0.pickToggle = var_2.Find(var_11_16, "toggle_list/pick_toggle")

	local var_11_17 = arg_11_0.pickToggle

	arg_11_0.pickTip = var_2.Find(var_11_17, "tip")
	ChargeTipWindow = var_2
	arg_11_0.chargeTipWindow = var_2.New(arg_11_0._tf, arg_11_0.event)

	local var_11_18 = arg_11_0.diamondToggle
	local var_11_19 = var_2.Find(var_11_18, "light/title")
	local var_11_20 = arg_11_0.diamondToggle
	local var_11_21 = var_3.Find(var_11_20, "dark/title")
	local var_11_22 = arg_11_0.giftToggle
	local var_11_23 = var_4.Find(var_11_22, "light/title")
	local var_11_24 = arg_11_0.giftToggle
	local var_11_25 = var_5.Find(var_11_24, "dark/title")
	local var_11_26 = arg_11_0.itemToggle
	local var_11_27 = var_6.Find(var_11_26, "light/title")
	local var_11_28 = arg_11_0.itemToggle
	local var_11_29 = var_7.Find(var_11_28, "dark/title")
	local var_11_30 = arg_11_0.pickToggle
	local var_11_31 = var_8.Find(var_11_30, "light/title")
	local var_11_32 = arg_11_0.pickToggle
	local var_11_33 = var_9.Find(var_11_32, "dark/title")

	setText = var_11_30

	local var_11_34 = var_11_19

	i18n = var_1_10013

	var_11_30(var_11_34, var_1_10013("shop_diamond_title"))

	setText = var_11_30

	local var_11_35 = var_11_21

	i18n = var_13

	var_11_30(var_11_35, var_13("shop_diamond_title"))

	setText = var_11_30

	local var_11_36 = var_11_23

	i18n = var_13

	var_11_30(var_11_36, var_13("shop_gift_title"))

	setText = var_11_30

	local var_11_37 = var_11_25

	i18n = var_13

	var_11_30(var_11_37, var_13("shop_gift_title"))

	setText = var_11_30

	local var_11_38 = var_11_27

	i18n = var_13

	var_11_30(var_11_38, var_13("shop_item_title"))

	setText = var_11_30

	local var_11_39 = var_11_29

	i18n = var_13

	var_11_30(var_11_39, var_13("shop_item_title"))

	setText = var_11_30

	local var_11_40 = var_11_31

	i18n = var_13

	var_11_30(var_11_40, var_13("shop_akashi_pick_title"))

	setText = var_11_30

	local var_11_41 = var_11_33

	i18n = var_13

	var_11_30(var_11_41, var_13("shop_akashi_pick_title"))

	local var_11_42 = {}
	local var_11_43 = arg_11_0.top

	var_11_42[1] = var_11.Find(var_11_43, "title/title_diamond")

	local var_11_44 = arg_11_0.top

	var_11_42[2] = var_11.Find(var_11_44, "title/title_gift")

	local var_11_45 = arg_11_0.top

	var_11_42[3] = var_11.Find(var_11_45, "title/title_item")

	local var_11_46 = arg_11_0.top

	var_11_42[4] = var_11.Find(var_11_46, "title/title_pick")
	arg_11_0.linkTitle = var_11_42
	arg_11_0.toggleList = {
		arg_11_0.diamondToggle,
		arg_11_0.giftToggle,
		arg_11_0.itemToggle,
		arg_11_0.pickToggle
	}
	Live2dConst = var_10

	if var_10.GetLive2DArm32MatchAble() then
		Ship = var_10

		local var_11_47 = var_10.New({
			configId = 312011
		})
		local var_11_48 = var_10.getPainting(var_11_47)

		LoadPaintingPrefabAsync = var_12

		var_12(arg_11_0.painting, var_11_48, var_11_48, "mainNormal", function()
			arg_11_0.loading = false

			return
		end)
	else
		arg_11_0:createLive2D()
	end

	Timer = var_10
	arg_11_0.live2dTimer = var_10.New(function()
		pg = var_2_10000

		local var_13_0 = var_2_10000.ChargeShipTalkInfo.Actions

		math = var_2_10001

		local var_13_1 = var_13_0[var_2_10001.random(#var_13_0)]
		local var_13_2 = arg_11_0

		if var_2.checkBuyDone(var_13_2, var_13_1.action) then
			local var_13_3 = arg_11_0

			var_2.displayShipWord(var_13_3, nil, false, var_13_1.dialog_index)
		end

		return
	end, 20, -1)

	local var_11_49 = arg_11_0.live2dTimer

	var_10.Start(var_11_49)
	arg_11_0:jpUIInit()
	arg_11_0:blurView()
	arg_11_0:initSubView()

	return
end

function var_0_1.didEnter(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.chat, false)

	onButton = var_1_10001

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.top
	local var_14_2 = var_4.Find(var_14_1, "back_button")

	local function var_14_3()
		local var_15_0 = arg_14_0

		var_0.closeView(var_15_0)

		return
	end

	SFX_CANCEL = var_14_1

	var_1_10001(var_14_0, var_14_2, var_14_3, var_14_1)

	onButton = var_1_10001

	local var_14_4 = arg_14_0
	local var_14_5 = arg_14_0.painting

	local function var_14_6()
		local var_16_0 = arg_14_0

		var_0.displayShipWord(var_16_0)

		local var_16_1 = arg_14_0
		local var_16_2 = var_0.emit

		ChargeMediator = var_2_10003

		var_16_2(var_16_1, var_2_10003.CLICK_MING_SHI)

		return
	end

	SFX_PANEL = var_14_1

	var_1_10001(var_14_4, var_14_5, var_14_6, var_14_1)

	for iter_14_0 = 1, #arg_14_0.toggleList do
		local var_14_7 = arg_14_0.toggleList[iter_14_0]

		onToggle = var_14_1

		local var_14_8 = arg_14_0
		local var_14_9 = var_14_7

		local function var_14_10(arg_17_0)
			local var_17_0 = var_14_7
			local var_17_1 = var_1.Find(var_17_0, "dark")

			setActive = var_2_10002

			var_2_10002(var_17_1, not arg_17_0)

			if arg_17_0 then
				local var_17_2 = arg_14_0

				var_2.switchSubView(var_17_2, iter_14_0)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_14_1(var_14_8, var_14_9, var_14_10, var_1_10011)
	end

	onButton = var_1

	local var_14_11 = arg_14_0
	local var_14_12 = arg_14_0.switchBtn

	local function var_14_13()
		local var_18_0 = arg_14_0
		local var_18_1 = var_0.emit

		ChargeMediator = var_2_10003

		local var_18_2 = var_2_10003.SWITCH_TO_SHOP
		local var_18_3 = {}

		NewShopsScene = var_2_10005
		var_18_3.warp = var_2_10005.TYPE_SHOP_STREET

		var_18_1(var_18_0, var_18_2, var_18_3)

		local var_18_4 = arg_14_0

		var_0.stopCV(var_18_4)

		return
	end

	SFX_PANEL = var_14_1

	var_1(var_14_11, var_14_12, var_14_13, var_14_1)

	onButton = var_1

	local var_14_14 = arg_14_0
	local var_14_15 = arg_14_0.skinShopBtn

	local function var_14_16()
		local var_19_0 = arg_14_0
		local var_19_1 = var_0.emit

		ChargeMediator = var_2_10003

		var_19_1(var_19_0, var_2_10003.ON_SKIN_SHOP)

		return
	end

	SFX_PANEL = var_14_1

	var_1(var_14_14, var_14_15, var_14_16, var_14_1)
	arg_14_0:updateNoRes()

	if arg_14_0.contextData.wrap ~= nil then
		arg_14_0:switchSubViewByTogger(arg_14_0.contextData.wrap)

		arg_14_0.contextData.wrap = nil
	else
		local var_14_17 = arg_14_0
		local var_14_18 = arg_14_0.switchSubViewByTogger

		ChargeScene = var_14_15

		var_14_18(var_14_17, var_14_15.TYPE_DIAMOND)
	end

	arg_14_0:jpUIEnter()

	return
end

function var_0_1.OnChargeSuccess(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.chargeTipWindow

	var_2.ExecuteAction(var_20_0, "Show", arg_20_1)

	return
end

function var_0_1.willExit(arg_21_0)
	arg_21_0:unBlurView()

	if arg_21_0.chargeTipWindow then
		local var_21_0 = arg_21_0.chargeTipWindow

		var_1.Destroy(var_21_0)

		arg_21_0.chargeTipWindow = nil
	end

	if arg_21_0.heartsTimer then
		local var_21_1 = arg_21_0.heartsTimer

		var_1.Stop(var_21_1)

		arg_21_0.heartsTimer = nil
	end

	if arg_21_0.live2dChar then
		local var_21_2 = arg_21_0.live2dChar

		var_1.Dispose(var_21_2)
	end

	if arg_21_0.live2dTimer then
		local var_21_3 = arg_21_0.live2dTimer

		var_1.Stop(var_21_3)

		arg_21_0.live2dTimer = nil
	end

	if arg_21_0.giftShopView then
		local var_21_4 = arg_21_0.giftShopView

		var_1.OnDestroy(var_21_4)
	end

	arg_21_0:stopCV()

	return
end

function var_0_1.initSubView(arg_22_0)
	local var_22_0 = arg_22_0.viewContainer

	arg_22_0.subViewContainer = var_1.Find(var_22_0, "SubView")
	ChargeDiamondShopView = var_1
	arg_22_0.diamondShopView = var_1.New(arg_22_0.subViewContainer, arg_22_0.event, arg_22_0.contextData)
	ChargeGiftShopView = var_1
	arg_22_0.giftShopView = var_1.New(arg_22_0.subViewContainer, arg_22_0.event, arg_22_0.contextData)
	ChargeItemShopView = var_1
	arg_22_0.itemShopView = var_1.New(arg_22_0.subViewContainer, arg_22_0.event, arg_22_0.contextData)
	ChargePickShopView = var_1
	arg_22_0.pickShopView = var_1.New(arg_22_0.subViewContainer, arg_22_0.event, arg_22_0.contextData)
	arg_22_0.curSubViewNum = 0

	local var_22_1 = {}

	ChargeScene = var_1_10002
	var_22_1[var_1_10002.TYPE_DIAMOND] = arg_22_0.diamondShopView
	ChargeScene = var_2
	var_22_1[var_2.TYPE_GIFT] = arg_22_0.giftShopView
	ChargeScene = var_2
	var_22_1[var_2.TYPE_ITEM] = arg_22_0.itemShopView
	ChargeScene = var_2
	var_22_1[var_2.TYPE_PICK] = arg_22_0.pickShopView
	arg_22_0.subViewList = var_22_1

	return
end

function var_0_1.switchSubView(arg_23_0, arg_23_1)
	if arg_23_1 == arg_23_0.curSubViewNum then
		return
	end

	local var_23_0 = arg_23_0.subViewList[arg_23_1]

	var_2.setGoodData(var_23_0, arg_23_0.firstChargeIds, arg_23_0.chargedList, arg_23_0.normalList, arg_23_0.normalGroupList)

	local var_23_1 = arg_23_0.subViewList[arg_23_1]

	var_2.Reset(var_23_1)

	local var_23_2 = arg_23_0.subViewList[arg_23_1]

	var_2.Load(var_23_2)

	if arg_23_0.subViewList[arg_23_0.curSubViewNum] then
		var_2:Destroy()
	end

	arg_23_0.curSubViewNum = arg_23_1
	PLATFORM_CODE = var_3
	PLATFORM_JP = var_23_2

	if var_3 == var_23_2 then
		setActive = var_3

		var_3(arg_23_0.userAgreeBtn3, arg_23_1 == var_0_1.TYPE_DIAMOND)

		setActive = var_3

		var_3(arg_23_0.userAgreeBtn4, arg_23_1 == var_0_1.TYPE_DIAMOND)
	end

	ipairs = var_3

	for iter_23_0, iter_23_1 in var_3(arg_23_0.linkTitle) do
		setActive = var_8

		var_8(iter_23_1, iter_23_0 == arg_23_1)
	end

	return
end

function var_0_1.switchSubViewByTogger(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.toggleList[arg_24_1]

	triggerToggle = var_1_10003

	var_1_10003(var_24_0, true)

	return
end

function var_0_1.updateCurSubView(arg_25_0)
	local var_25_0 = arg_25_0.subViewList[arg_25_0.curSubViewNum]

	var_1.setGoodData(var_25_0, arg_25_0.firstChargeIds, arg_25_0.chargedList, arg_25_0.normalList, arg_25_0.normalGroupList)
	var_1:reUpdateAll()

	return
end

function var_0_1.updateNoRes(arg_26_0, arg_26_1)
	if not arg_26_1 then
		arg_26_1 = arg_26_0.contextData.noRes
	else
		arg_26_0.contextData.noRes = arg_26_1
	end

	if not arg_26_1 or #arg_26_1 <= 0 then
		return
	end

	local var_26_0 = arg_26_0.contextData

	var_26_0.noRes = {}
	getProxy = var_26_0
	BagProxy = var_1_10004

	local var_26_1 = var_26_0(var_1_10004)
	local var_26_2 = var_2.getData(var_26_1)
	local var_26_3 = ""

	ipairs = var_26_1

	for iter_26_0, iter_26_1 in var_26_1(arg_26_1) do
		if iter_26_1[2] > 0 then
			if iter_26_1[1] == 59001 then
				var_1_10010 = arg_26_1[iter_26_0]
				var_1_10010[2] = iter_26_1[3] - arg_26_0.player.gold
			else
				var_1_10010 = arg_26_1[iter_26_0]

				local var_26_4 = iter_26_1[3]
				local var_26_5

				if not var_26_2[iter_26_1[1]] or not var_26_2[iter_26_1[1]].count then
					var_26_5 = 0
				end

				var_1_10010[2] = var_26_4 - var_26_5
			end
		end

		if arg_26_1[iter_26_0][2] > 0 then
			table = var_1_10010

			var_1_10010.insert(arg_26_0.contextData.noRes, arg_26_1[iter_26_0])
		end
	end

	ipairs = var_5

	for iter_26_2, iter_26_3 in var_5(arg_26_0.contextData.noRes) do
		Item = var_1_10010
		var_1_10010 = var_1_10010.getConfigData(iter_26_3[1]).name

		local var_26_6 = var_26_3

		i18n = var_12
		var_26_3 = var_26_6 .. var_12(iter_26_3[1] == 59001 and "text_noRes_info_tip" or "text_noRes_info_tip2", var_1_10010, iter_26_3[2])

		if iter_26_2 < #arg_26_0.contextData.noRes then
			local var_26_7 = var_26_3

			i18n = var_12
			var_26_3 = var_26_7 .. var_12("text_noRes_info_tip_link")
		end
	end

	if var_26_3 == "" then
		local var_26_8 = arg_26_0
		local var_26_9 = arg_26_0.displayShipWord

		i18n = iter_26_2

		var_26_9(var_26_8, iter_26_2("text_shop_enoughRes_tip"), false)
	else
		local var_26_10 = arg_26_0
		local var_26_11 = arg_26_0.displayShipWord

		i18n = iter_26_2

		var_26_11(var_26_10, iter_26_2("text_shop_noRes_tip", var_26_3), true)
	end

	return
end

function var_0_1.displayShipWord(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if not arg_27_0.chatFlag then
		if not arg_27_1 and arg_27_0.contextData.noRes then
			local var_27_0 = #arg_27_0.contextData.noRes

			if 0 < var_27_0 then
				setActive = var_27_0

				var_27_0(arg_27_0.chat, false)

				local var_27_1 = arg_27_0.chat.transform

				Vector3 = var_1_10005
				var_27_1.localScale = var_1_10005(0, 0, 1)
			end
		end

		arg_27_0.chatFlag = true

		if not arg_27_0.isInitChatPosition then
			arg_27_0.isInitChatPosition = true

			arg_27_0:InitChatPosition()
		end

		setActive = var_4

		var_4(arg_27_0.chat, true)

		local var_27_2 = arg_27_0.player
		local var_27_3 = var_4.getChargeLevel(var_27_2)

		if not arg_27_3 then
			::label_27_0::

			math = var_1_10005
			var_1_10005 = var_1_10005.random(1, var_27_3)
		end

		local var_27_4

		if arg_27_3 then
			pg = var_7
			var_27_4 = var_7.pay_level_award[var_1_10005].dialog
		elseif not arg_27_1 then
			::label_27_1::

			pg = var_7
			var_27_4 = var_7.pay_level_award[var_1_10005].dialog
		end

		if not arg_27_1 then
			arg_27_0:playCV(var_1_10005)
		end

		setText = var_7

		var_7(arg_27_0.chatText, var_27_4)

		local var_27_5 = arg_27_0.chatText
		local var_27_6 = var_7.GetComponent

		typeof = var_10
		Text = var_1_10012

		local var_27_7 = #var_27_6(var_27_5, var_10(var_1_10012)).text

		CHAT_POP_STR_LEN_SHORT = var_27_5

		if var_27_5 < var_27_7 then
			TextAnchor = var_27_7
			var_7.alignment = var_27_7.MiddleLeft
		else
			TextAnchor = var_27_7
			var_7.alignment = var_27_7.MiddleCenter
		end

		;(function()
			local var_28_0 = 3
			local var_28_1 = 0.3

			LeanTween = var_2_10002

			local var_28_2 = var_2_10002.scale

			rtf = var_2_10004

			local var_28_3 = var_2_10004(arg_27_0.chat.gameObject)

			Vector3 = var_2_10005

			local var_28_4 = var_28_2(var_28_3, var_2_10005.New(1, 1, 1), var_28_1)
			local var_28_5 = var_2.setFrom

			Vector3 = var_5

			local var_28_6 = var_28_5(var_28_4, var_5.New(0, 0, 0))
			local var_28_7 = var_2.setEase

			LeanTweenType = var_5

			local var_28_8 = var_28_7(var_28_6, var_5.easeOutBack)
			local var_28_9 = var_2.setOnComplete

			System = var_5

			var_28_9(var_28_8, var_5.Action(function()
				if not arg_27_2 then
					LeanTween = var_0

					local var_29_0 = var_0.scale

					rtf = var_3_10002

					local var_29_1 = var_3_10002(arg_27_0.chat.gameObject)

					Vector3 = var_3_10003

					local var_29_2 = var_29_0(var_29_1, var_3_10003.New(0, 0, 1), var_28_1)
					local var_29_3 = var_0.setEase

					LeanTweenType = var_3

					local var_29_4 = var_29_3(var_29_2, var_3.easeInBack)
					local var_29_5 = var_0.setDelay(var_29_4, var_28_1 + var_28_0)
					local var_29_6 = var_0.setOnComplete

					System = var_3

					var_29_6(var_29_5, var_3.Action(function()
						local var_30_0 = arg_27_0

						var_30_0.chatFlag = nil
						setActive = var_30_0

						var_30_0(arg_27_0.chat, false)

						if arg_27_0.contextData.noRes and #arg_27_0.contextData.noRes > 0 then
							local var_30_1 = arg_27_0

							var_0.updateNoRes(var_30_1)
						end

						return
					end))
				else
					arg_27_0.chatFlag = nil
				end

				return
			end))

			return
		end)()
	end

	return
end

function var_0_1.InitChatPosition(arg_31_0)
	local var_31_0 = arg_31_0.painting.localPosition

	Vector3 = var_1_10002

	local var_31_1 = var_31_0 + var_1_10002(-21, -176, 0)
	local var_31_2 = arg_31_0.painting.parent
	local var_31_3 = var_2.TransformPoint(var_31_2, var_31_1)
	local var_31_4 = arg_31_0.chat.parent
	local var_31_5 = var_3.InverseTransformPoint(var_31_4, var_31_3)
	local var_31_6 = arg_31_0.chat

	Vector3 = var_31_4
	var_31_6.localPosition = var_31_4(var_31_5.x, var_31_5.y, 0)

	return
end

function var_0_1.playHeartEffect(arg_32_0)
	if arg_32_0.heartsTimer then
		local var_32_0 = arg_32_0.heartsTimer

		var_1.Stop(var_32_0)
	end

	local var_32_1 = arg_32_0.painting
	local var_32_2 = var_1.Find(var_32_1, "heartsfly")

	setActive = var_1_10002

	var_1_10002(var_32_2, true)

	Timer = var_1_10002
	arg_32_0.heartsTimer = var_1_10002.New(function()
		setActive = var_2_10000

		var_2_10000(var_32_2, false)

		return
	end, 1, 1)

	local var_32_3 = arg_32_0.heartsTimer

	var_2.Start(var_32_3)

	return
end

function var_0_1.createLive2D(arg_34_0)
	Live2DPainting = var_1_10001

	local var_34_0 = var_1_10001.GenerateData
	local var_34_1 = {}

	Ship = var_1_10004
	var_34_1.ship = var_1_10004.New({
		configId = 312011
	})
	var_34_1.offset = {
		0,
		0,
		0,
		75
	}
	Vector3 = var_4
	var_34_1.position = var_4(0, 0, 0)

	local var_34_2 = arg_34_0._tf

	var_34_1.parent = var_4.Find(var_34_2, "frame/painting/live2d")

	local var_34_3 = var_34_0(var_34_1)

	Live2DPainting = var_1_10002
	arg_34_0.live2dChar = var_1_10002.New(var_34_3, function(arg_35_0)
		local var_35_0 = arg_35_0
		local var_35_1 = arg_35_0.setSortingLayer

		LayerWeightConst = var_2_10004

		var_35_1(var_35_0, var_2_10004.L2D_DEFAULT_LAYER)

		return
	end)

	return
end

function var_0_1.checkBuyDone(arg_36_0, arg_36_1)
	if arg_36_0.live2dChar then
		local var_36_0 = arg_36_0.live2dChar

		if not var_2.IsLoaded(var_36_0) then
			return
		end

		local var_36_1

		type = var_1_10003

		if var_1_10003(arg_36_1) == "string" then
			if arg_36_1 == "damonds" then
				var_36_1 = "diamond"
			else
				var_36_1 = arg_36_1
			end
		else
			pg = var_3

			if var_3.shop_template[arg_36_1] and var_3.effect_args then
				type = var_4

				if var_4(var_3.effect_args) == "table" then
					ipairs = var_4

					for iter_36_0, iter_36_1 in var_4(var_3.effect_args) do
						if iter_36_1 == 1 then
							var_36_1 = "gold"
						end
					end
				end
			end
		end

		local var_36_2 = arg_36_0.preAniName == "gold" or arg_36_0.preAniName == "diamond"
		local var_36_3 = var_36_1 == "gold" or var_36_1 == "diamond"
		local var_36_4 = var_36_2 and var_36_3 or not var_36_2

		var_36_4 = var_36_1 and arg_36_0.preAniName ~= var_36_1 and var_36_4

		if var_36_4 then
			arg_36_0.preAniName = var_36_1

			local var_36_5 = arg_36_0.live2dChar

			var_6.TriggerAction(var_36_5, var_36_1, nil, true)
		end

		return var_36_4
	end
end

function var_0_1.playCV(arg_37_0, arg_37_1)
	pg = var_1_10002

	local var_37_0 = var_1_10002.pay_level_award[arg_37_1]
	local var_37_1

	if var_37_0 and var_37_0.cv_key ~= "" then
		var_37_1 = "event:/cv/chargeShop/" .. var_37_0.cv_key
	end

	if var_37_1 then
		arg_37_0:stopCV()

		arg_37_0._currentVoice = var_37_1
		pg = var_4

		local var_37_2 = var_4.CriMgr.GetInstance()

		var_4.PlaySoundEffect_V3(var_37_2, var_37_1)
	end

	return
end

function var_0_1.stopCV(arg_38_0)
	if arg_38_0._currentVoice then
		pg = var_1

		local var_38_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadSoundEffect_V3(var_38_0, arg_38_0._currentVoice)
	end

	arg_38_0._currentVoice = nil

	return
end

function var_0_1.blurView(arg_39_0)
	pg = var_1_10001

	local var_39_0 = var_1_10001.UIMgr.GetInstance()
	local var_39_1 = var_1.OverlayPanel
	local var_39_2 = arg_39_0.viewContainer
	local var_39_3 = {}
	local var_39_4 = {}
	local var_39_5 = arg_39_0.viewContainer

	var_39_4[1] = var_7.Find(var_39_5, "blurBg")
	var_39_3.pbList = var_39_4

	var_39_1(var_39_0, var_39_2, var_39_3)

	return
end

function var_0_1.unBlurView(arg_40_0)
	pg = var_1_10001

	local var_40_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_40_0, arg_40_0.viewContainer, arg_40_0.frame)

	return
end

function var_0_1.jpUIInit(arg_41_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		return
	end

	local var_41_0 = arg_41_0._tf

	arg_41_0.userAgreeBtn3 = var_1.Find(var_41_0, "frame/raw1Btn")

	local var_41_1 = arg_41_0._tf

	arg_41_0.userAgreeBtn4 = var_1.Find(var_41_1, "frame/raw2Btn")

	return
end

function var_0_1.jpUIEnter(arg_42_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		return
	end

	onButton = var_1_10001

	local var_42_0 = arg_42_0
	local var_42_1 = arg_42_0.userAgreeBtn3

	local function var_42_2()
		require = var_2_10000

		local var_43_0 = var_2_10000("ShareCfg.UserAgreement3")
		local var_43_1 = arg_42_0
		local var_43_2 = var_1.emit

		ChargeMediator = var_2_10004

		var_43_2(var_43_1, var_2_10004.OPEN_USER_AGREE, var_43_0 or "")

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_42_0, var_42_1, var_42_2, var_1_10006)

	onButton = var_1_10001

	local var_42_3 = arg_42_0
	local var_42_4 = arg_42_0.userAgreeBtn4

	local function var_42_5()
		require = var_2_10000

		local var_44_0 = var_2_10000("ShareCfg.UserAgreement4")
		local var_44_1 = arg_42_0
		local var_44_2 = var_1.emit

		ChargeMediator = var_2_10004

		var_44_2(var_44_1, var_2_10004.OPEN_USER_AGREE, var_44_0 or "")

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_42_3, var_42_4, var_42_5, var_1_10006)

	return
end

function var_0_1.addRefreshTimer(arg_45_0, arg_45_1)
	(function()
		if arg_45_0.refreshTimer then
			local var_46_0 = arg_45_0.refreshTimer

			var_0.Stop(var_46_0)

			arg_45_0.refreshTimer = nil
		end

		return
	end)()

	Timer = var_3
	arg_45_0.refreshTimer = var_3.New(function()
		local var_47_0 = arg_45_1 + 1

		pg = var_2_10001

		local var_47_1 = var_2_10001.TimeMgr.GetInstance()
		local var_47_3

		if var_47_0 - var_1.GetServerTime(var_47_1) <= 0 then
			var_0()

			local var_47_2 = arg_45_0

			var_47_3 = var_47_3.emit
			ChargeMediator = var_2_10004

			var_47_3(var_47_2, var_2_10004.GET_CHARGE_LIST)
		else
			pg = var_47_3

			local var_47_4 = var_47_3.TimeMgr.GetInstance()
			local var_47_5 = var_1.DescCDTime(var_47_4, var_0)
		end

		return
	end, 1, -1)

	local var_45_0 = arg_45_0.refreshTimer

	var_3.Start(var_45_0)
	arg_45_0.refreshTimer.func()

	return
end

function var_0_1.checkFreeGiftTag(arg_48_0)
	TagTipHelper = var_1_10001

	var_1_10001.FreeGiftTag({
		arg_48_0.giftTip
	})

	return
end

return var_0_1
